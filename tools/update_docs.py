#!/usr/bin/env python3
"""
Regenerates docs/CODE_MAP.md from the source code, so the *facts* in the documentation
never go stale:

  * every file with its one-line purpose (taken from the header comment of the file)
  * files that nothing imports (candidates for deletion)
  * every server endpoint the app knows about
  * every status number and its meaning
  * an automatically detected LAUNCH CHECKLIST (test-mode payments, localhost URL, ...)
  * files that are missing a header comment

The narrative guides (OWNER_GUIDE.md / DEVELOPER_GUIDE.md) are written by people; this file is
produced by a machine and must not be edited by hand.

Usage
    python tools/update_docs.py            # rewrite docs/CODE_MAP.md
    python tools/update_docs.py --check    # exit 1 if it is out of date (used by the git hook)
"""
import os
import re
import subprocess
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
LIB = os.path.join(ROOT, 'lib')
OUT = os.path.join(ROOT, 'docs', 'CODE_MAP.md')


def rel(p):
    return os.path.relpath(p, ROOT).replace('\\', '/')


def read(p):
    with open(p, encoding='utf-8', errors='ignore') as f:
        return f.read()


def dart_files():
    out = []
    for r, _, fs in os.walk(LIB):
        for f in fs:
            if f.endswith('.dart'):
                out.append(os.path.join(r, f))
    return sorted(out, key=lambda p: rel(p).lower())


# ---------------------------------------------------------------- header parsing
def parse_header(text):
    """Return (title, description, is_unused) from the '// ----' block at the top."""
    lines = text.split('\n')
    i = 0
    if lines and lines[0].startswith('// @dart'):
        i = 1
    if i >= len(lines) or not lines[i].startswith('// ---'):
        return None
    i += 1
    title = lines[i][3:].strip() if lines[i].startswith('// ') else ''
    i += 1
    desc, unused, in_tail = [], False, False
    while i < len(lines) and not lines[i].startswith('// ---'):
        l = lines[i][2:].strip() if lines[i].startswith('//') else ''
        if l.startswith('STATUS:'):
            unused, in_tail = True, True
        elif l.startswith('Developer note:'):
            in_tail = True
        elif l and not in_tail:
            desc.append(l)
        i += 1
    return title, ' '.join(desc).strip(), unused


# ---------------------------------------------------------------- unused-file detection
def find_unused(files, texts):
    imports = []
    for p in files:
        for m in re.finditer(r"import\s+'([^']+)'", texts[p]):
            imports.append((p, m.group(1).replace('%20', ' ')))
    main = os.path.join(LIB, 'main.dart')
    unused = []
    for target in files:
        if target == main:
            continue
        base = os.path.basename(target)
        tl = rel(target)[len('lib/'):].lower()
        used = False
        for src, imp in imports:
            if src == target or not (imp.lower().endswith('/' + base.lower()) or imp.lower() == base.lower()):
                continue
            if imp.startswith('package:'):
                if imp.split('/', 1)[1].lower() == tl:
                    used = True
                    break
            else:
                resolved = os.path.normpath(os.path.join(os.path.dirname(src), imp))
                if rel(resolved).lower() == rel(target).lower():
                    used = True
                    break
        if not used:
            unused.append(target)
    return unused


# ---------------------------------------------------------------- constants
def parse_consts(path, kind):
    rows = []
    for m in re.finditer(r"^const\s+%s\s+(\w+)\s*=\s*([^;]+);" % kind, read(path), flags=re.M):
        rows.append((m.group(1), m.group(2).strip().strip("'\"")))
    return rows


# ---------------------------------------------------------------- launch checklist
def launch_checklist(files, texts):
    items = []  # (severity, text)
    api = texts.get(os.path.join(LIB, 'constants', 'apiConstants.dart'), '')

    m = re.search(r"^const String apiBaseUrl\s*=\s*'([^']+)'", api, flags=re.M)
    base = m.group(1) if m else '(not found)'
    if re.search(r'127\.0\.0\.1|localhost|10\.0\.2\.2', base):
        items.append(('BLOCKER', f'`apiBaseUrl` points at a local machine: `{base}`'))
    elif base.startswith('http://'):
        items.append(('WARN', f'`apiBaseUrl` uses plain HTTP: `{base}`'))
    else:
        items.append(('OK', f'`apiBaseUrl` = `{base}`'))

    m = re.search(r"^const String oneSignalAppId\s*=\s*'([^']*)'", api, flags=re.M)
    if not m or not m.group(1):
        items.append(('BLOCKER', '`oneSignalAppId` is empty: push notifications are disabled'))
    else:
        items.append(('OK', 'OneSignal App ID is set'))

    hard_sandbox = []
    uses_flag = False
    for p in files:
        for n, line in enumerate(texts[p].split('\n'), 1):
            code = line.lstrip()
            if code.startswith('//'):
                continue
            if 'cashfreeProduction' in line and 'CFEnvironment' in line:
                uses_flag = True
            elif re.search(r'CFEnvironment\.SANDBOX', line):
                hard_sandbox.append(f'{rel(p)}:{n}')
    if hard_sandbox:
        items.append(('BLOCKER', 'Cashfree is hard-wired to SANDBOX (test) mode at: ' +
                      ', '.join(f'`{x}`' for x in hard_sandbox)))
    elif uses_flag:
        items.append(('WARN', 'Cashfree runs in TEST mode unless the release is built with '
                      '`--dart-define=CASHFREE_PRODUCTION=true` (and the server holds live keys)'))
    else:
        items.append(('OK', 'No Cashfree sandbox settings found'))

    main = texts.get(os.path.join(LIB, 'main.dart'), '')
    if 'badCertificateCallback' in main and re.search(r'HttpOverrides\.global\s*=', main):
        guarded = re.search(r'if\s*\(\s*kDebugMode\s*\)\s*\{[^}]*HttpOverrides\.global', main, flags=re.S)
        if guarded:
            items.append(('OK', 'Certificate-skipping override is installed in debug builds only'))
        else:
            items.append(('BLOCKER', '`MyHttpOverrides` is active in `main.dart` for all builds: HTTPS certificates are not verified'))
    else:
        items.append(('OK', 'HTTPS certificate checking is not disabled'))

    if re.search(r"WITHDRAW_AMOUNT\s*=\s*'driver/f\?", api):
        items.append(('INFO', 'In-app wallet withdrawal is switched off (drivers are told to visit the office); '
                      'its endpoint `driver/f` is a placeholder'))

    m = re.search(r"skipperOffersEnabled\s*=\s*(true|false)", api)
    if m and m.group(1) == 'true':
        items.append(('WARN', '`skipperOffersEnabled` is true: the taxi/skipper polling is active in the driver app'))

    try:
        tracked = subprocess.run(['git', 'ls-files'], cwd=ROOT, capture_output=True,
                                 text=True, encoding='utf-8').stdout.split('\n')
        keys = [t for t in tracked if t.lower().endswith(('.jks', '.keystore', '.pem'))]
        if keys:
            items.append(('WARN', 'Signing/secret files are tracked in git: ' + ', '.join(f'`{k}`' for k in keys)))
    except Exception:  # noqa: BLE001
        pass

    # languages offered vs translated
    picker = texts.get(os.path.join(LIB, 'views', 'appLanguage', 'chooseAppLanguage.dart'), '')
    order = ['en_us', 'hi_in', 'kn_in', 'tl_in', 'ta_in', 'gu_in']  # picker positions 0..5
    m = re.search(r'_offeredLanguageIndexes\s*=\s*\[([^\]]*)\]', picker)
    if m:
        idx = [int(x) for x in re.findall(r'\d+', m.group(1))]
        offered = [order[i] for i in idx if i < len(order)]
    else:
        offered = order
    tr = texts.get(os.path.join(LIB, 'views', 'translate.dart'), '')
    have = set(k.lower() for k in re.findall(r"^\s*'([a-zA-Z]{2}_[a-zA-Z]{2})'\s*:\s*\{", tr, flags=re.M))
    missing = [o for o in offered if o not in have]
    if missing:
        items.append(('WARN', 'Languages offered but with no translations: ' +
                      ', '.join(f'`{m_}`' for m_ in missing)))
    else:
        items.append(('OK', 'Every language offered in the picker has translations ('
                      + ', '.join(offered) + ')'))
    return items


# ---------------------------------------------------------------- build the document
def build():
    files = dart_files()
    texts = {p: read(p) for p in files}
    unused = set(find_unused(files, texts))
    out = []
    w = out.append

    w('# Code map (auto-generated)')
    w('')
    w('> **Do not edit this file.** It is rebuilt from the source code by '
      '`python tools/update_docs.py` (and checked by the git pre-commit hook), so it always '
      'matches the code. For explanations in plain language see `OWNER_GUIDE.md`; for '
      'architecture see `DEVELOPER_GUIDE.md`.')
    w('')

    # ---- launch checklist
    w('## 1. Launch checklist (detected from the code)')
    w('')
    w('| Status | Finding |')
    w('|---|---|')
    order = {'BLOCKER': 0, 'WARN': 1, 'INFO': 2, 'OK': 3}
    for sev, text in sorted(launch_checklist(files, texts), key=lambda t: order[t[0]]):
        icon = {'BLOCKER': 'BLOCKER', 'WARN': 'WARNING', 'INFO': 'note', 'OK': 'ok'}[sev]
        w(f'| {icon} | {text} |')
    w('')

    # ---- file inventory
    total_lines = sum(len(t.split('\n')) for t in texts.values())
    w(f'## 2. Files ({len(files)} files, about {total_lines:,} lines)')
    w('')
    w('| File | Lines | Purpose | Status |')
    w('|---|---:|---|---|')
    no_header = []
    for p in files:
        h = parse_header(texts[p])
        if h:
            title, desc, flagged = h
            purpose = title + (' - ' + desc if desc else '')
        else:
            purpose = '(no header comment yet)'
            no_header.append(p)
            flagged = False
        purpose = purpose.replace('|', '/')
        if len(purpose) > 170:
            purpose = purpose[:167] + '...'
        status = 'unused' if (p in unused or flagged) else ''
        w(f'| `{rel(p)[4:]}` | {len(texts[p].split(chr(10)))} | {purpose} | {status} |')
    w('')

    # ---- unused
    w(f'## 3. Files nothing imports ({len(unused)})')
    w('')
    w('These are not referenced by any other Dart file; most are leftovers and can be deleted '
      'after a quick check.')
    w('')
    for p in sorted(unused, key=lambda x: rel(x).lower()):
        w(f'- `{rel(p)[4:]}` ({len(texts[p].split(chr(10)))} lines)')
    w('')

    # ---- endpoints
    api_path = os.path.join(LIB, 'constants', 'apiConstants.dart')
    endpoints = parse_consts(api_path, 'String')
    w(f'## 4. Server endpoints ({len(endpoints)})')
    w('')
    w('Paths are relative to `apiBaseUrl`.')
    w('')
    w('| Constant | Path |')
    w('|---|---|')
    for n, v in endpoints:
        if n in ('apiBaseUrl', 'oneSignalAppId', 'rideApiPrefix'):
            continue
        w(f'| `{n}` | `{v}` |')
    w('')

    # ---- statuses
    st_path = os.path.join(LIB, 'constants', 'stetuesConstant.dart')
    # status constants are declared as `const NAME = 1;`
    raw = [(m.group(1), m.group(2)) for m in
           re.finditer(r"^const\s+(\w+)\s*=\s*(\d+);", read(st_path), flags=re.M)]
    w(f'## 5. Status numbers ({len(raw)})')
    w('')
    w('| Name | Value |')
    w('|---|---:|')
    for n, v in raw:
        w(f'| `{n}` | {v} |')
    w('')

    # ---- header coverage
    w('## 6. Documentation coverage')
    w('')
    if no_header:
        w(f'{len(no_header)} file(s) have no header comment. Add one (see any other file for the style):')
        w('')
        for p in no_header:
            w(f'- `{rel(p)[4:]}`')
    else:
        w('Every Dart file has a header comment.')
    w('')

    # ---- dependencies
    pub = read(os.path.join(ROOT, 'pubspec.yaml'))
    m = re.search(r'^dependencies:\n(.*?)^\S', pub, flags=re.M | re.S)
    deps = []
    if m:
        for line in m.group(1).split('\n'):
            d = re.match(r'^  ([a-z0-9_]+):\s*(.*)$', line)
            if d and d.group(1) != 'flutter':
                deps.append((d.group(1), d.group(2).strip() or 'any'))
    w(f'## 7. Libraries used ({len(deps)})')
    w('')
    w(', '.join(f'`{n}` {v}' if not v.startswith('\n') else f'`{n}`' for n, v in deps))
    w('')
    return '\n'.join(out)


def main():
    new = build()
    old = read(OUT) if os.path.exists(OUT) else ''
    if '--check' in sys.argv:
        if new != old:
            print('docs/CODE_MAP.md is out of date. Run: python tools/update_docs.py')
            sys.exit(1)
        print('docs/CODE_MAP.md is up to date.')
        return
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, 'w', encoding='utf-8', newline='\n') as f:
        f.write(new)
    print('wrote', rel(OUT))


if __name__ == '__main__':
    main()

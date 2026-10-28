#!/usr/bin/env python3
"""
Writes START / END marker comments around every class and function in lib/*.dart.

    // >>> START  HomePage.build()  -  draws this screen (its layout)
    ...code...
    // <<< END    HomePage.build()

Why: so a reader (developer or curious owner) can see at a glance where each piece of
functionality begins and ends, even inside 1,000-line files.

Safe by design
  * Only adds comment lines. After every run the script strips its own markers from the
    result and checks the code is byte-for-byte what it was before.
  * Idempotent: old markers are removed first, so re-running after code changes simply
    refreshes them. This is what the git pre-commit hook does.

Usage
    python tools/annotate_code.py            # (re)write markers in place
    python tools/annotate_code.py --check    # exit 1 if any file's markers are stale
"""
import os
import re
import sys

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
LIB = os.path.join(ROOT, 'lib')

MARK_RE = re.compile(r'^\s*// (>>> START|<<< END) ')

LIFECYCLE = {
    'build': 'draws this screen / widget (its layout)',
    'initState': 'runs once when the screen opens',
    'dispose': 'cleanup when the screen closes',
    'didChangeDependencies': 'reacts when inherited data changes',
    'didUpdateWidget': 'reacts when the widget is rebuilt with new values',
    'createState': 'creates the screen\'s changing state',
    'main': 'app entry point',
}


# ----------------------------------------------------------------------------------------
# A small Dart-aware scanner: skips strings (incl. ${} interpolation) and comments.
# ----------------------------------------------------------------------------------------
class Scanner:
    def __init__(self, src):
        self.s = src
        self.n = len(src)

    def skip_line_comment(self, i):
        j = self.s.find('\n', i)
        return self.n if j < 0 else j

    def skip_block_comment(self, i):
        depth = 0
        while i < self.n:
            if self.s.startswith('/*', i):
                depth += 1
                i += 2
            elif self.s.startswith('*/', i):
                depth -= 1
                i += 2
                if depth == 0:
                    return i
            else:
                i += 1
        return self.n

    def skip_string(self, i):
        """i points at the first quote (or at r/R of a raw string). Returns index after it."""
        s = self.s
        raw = False
        if s[i] in 'rR' and i + 1 < self.n and s[i + 1] in '\'"':
            raw = True
            i += 1
        q = s[i]
        triple = s.startswith(q * 3, i)
        i += 3 if triple else 1
        end = q * 3 if triple else q
        while i < self.n:
            c = s[i]
            if c == '\\' and not raw:
                i += 2
                continue
            if s.startswith(end, i):
                return i + len(end)
            if not triple and c == '\n':
                return i  # unterminated; bail out gracefully
            if c == '$' and not raw and i + 1 < self.n and s[i + 1] == '{':
                i = self.skip_interpolation(i + 2)
                continue
            i += 1
        return self.n

    def skip_interpolation(self, i):
        """Just after '${'. Returns index after the matching '}'."""
        s = self.s
        depth = 1
        while i < self.n and depth:
            c = s[i]
            if c in '\'"':
                i = self.skip_string(i)
                continue
            if c == '/' and s.startswith('//', i):
                i = self.skip_line_comment(i)
                continue
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
            i += 1
        return i


CLASS_RE = re.compile(
    r'^(?:@\w+(?:\([^)]*\))?\s*)*'
    r'(?:(?:abstract|base|final|sealed|interface|mixin|macro)\s+)*'
    r'(class|mixin|enum|extension)\b\s*(\w+)?')
FUNC_TAIL_RE = re.compile(r'\)\s*(?:async\*?|sync\*)?\s*$')
GETTER_RE = re.compile(r'\bget\s+(\w+)\s*$')


def strip_comments(text):
    out = []
    sc = Scanner(text)
    i = 0
    while i < sc.n:
        if text.startswith('//', i):
            i = sc.skip_line_comment(i)
        elif text.startswith('/*', i):
            i = sc.skip_block_comment(i)
        else:
            out.append(text[i])
            i += 1
    return ''.join(out)


def classify(header, current_class):
    """Return (kind, name) if the text before '{' is a declaration with a body."""
    h = ' '.join(strip_comments(header).split())
    if not h:
        return None
    m = CLASS_RE.match(h)
    if m:
        return ('class', m.group(2) or m.group(1))
    if '=>' in h:
        return None
    g = GETTER_RE.search(h)
    if g and '(' not in h:
        return ('member', 'get ' + g.group(1))
    if '(' in h and FUNC_TAIL_RE.search(h):
        first = h.index('(')
        before = h[:first].rstrip()
        # a '=' before the first '(' means "variable = something(...) {" -> not a declaration
        if '=' in before:
            return None
        nm = re.search(r'([A-Za-z_$][\w$]*)$', before)
        if not nm:
            return None
        name = nm.group(1)
        if name in ('if', 'for', 'while', 'switch', 'catch', 'else', 'try'):
            return None
        if current_class and name == current_class:
            return ('member', name + '()')
        return ('member', name + '()')
    return None


def find_declarations(src):
    """Return list of dicts: name, start_idx (first token), close_idx, depth, kind."""
    sc = Scanner(src)
    s = src
    i = 0
    stack = []          # entries: dict(decl=None|dict, nest_at_open)
    stmt_start = [0]    # one per structural depth
    nest = 0            # ( [ nesting
    decls = []
    class_stack = []

    def first_token(idx):
        j = idx
        while j < sc.n:
            if s[j].isspace():
                j += 1
            elif s.startswith('//', j):
                j = sc.skip_line_comment(j)
            elif s.startswith('/*', j):
                j = sc.skip_block_comment(j)
            else:
                return j
        return j

    while i < sc.n:
        c = s[i]
        if s.startswith('//', i):
            i = sc.skip_line_comment(i)
            continue
        if s.startswith('/*', i):
            i = sc.skip_block_comment(i)
            continue
        if c in '\'"' or (c in 'rR' and i + 1 < sc.n and s[i + 1] in '\'"'
                          and (i == 0 or not (s[i - 1].isalnum() or s[i - 1] == '_'))):
            i = sc.skip_string(i)
            continue
        if c in '([':
            nest += 1
        elif c in ')]':
            nest = max(0, nest - 1)
        elif c == '{':
            depth = len(stack)
            decl = None
            if nest == 0 and depth <= 1:
                header = s[stmt_start[-1]:i]
                cur_class = class_stack[-1] if class_stack else None
                cl = classify(header, cur_class)
                if cl:
                    kind, name = cl
                    if kind == 'class':
                        full = name
                    elif depth == 1 and cur_class:
                        full = f'{cur_class}.{name}'
                    else:
                        full = name
                    decl = {
                        'kind': kind, 'name': full, 'depth': depth,
                        'start': first_token(stmt_start[-1]), 'open': i,
                        'short': name,
                    }
                    if kind == 'class':
                        class_stack.append(name)
            stack.append({'decl': decl, 'nest': nest})
            stmt_start.append(i + 1)
            nest = 0 if decl else nest  # inside a body, parens restart
        elif c == '}':
            if stack:
                top = stack.pop()
                stmt_start.pop()
                nest = top['nest']
                if top['decl']:
                    d = top['decl']
                    d['close'] = i
                    decls.append(d)
                    if d['kind'] == 'class':
                        class_stack.pop()
                if stmt_start:
                    stmt_start[-1] = i + 1
        elif c == ';' and nest == 0:
            stmt_start[-1] = i + 1
        i += 1
    if stack:
        raise ValueError('unbalanced braces')
    return decls


def describe(d):
    short = d['short']
    if d['kind'] == 'class':
        return ''
    base = short.replace('()', '')
    if base in LIFECYCLE:
        return LIFECYCLE[base]
    if base.startswith('get '):
        return 'computed value'
    cls = d['name'].split('.')[0] if '.' in d['name'] else ''
    if cls and base == cls:
        return 'constructor (receives the values this class needs)'
    # fall back to the name read as plain words:  fetchDeviceToken -> "fetch device token"
    words = re.sub(r'([a-z0-9])([A-Z])', r'\1 \2', base.lstrip('_')).replace('_', ' ').lower().split()
    if len(words) >= 2:
        return ' '.join(words)
    return ''


def strip_markers(text):
    lines = text.split('\n')
    return '\n'.join(l for l in lines if not MARK_RE.match(l))


def annotate(text):
    clean = strip_markers(text)
    decls = find_declarations(clean)
    lines = clean.split('\n')

    # char index -> line number
    starts = [0]
    for ln in lines[:-1]:
        starts.append(starts[-1] + len(ln) + 1)

    def line_of(idx):
        lo, hi = 0, len(starts) - 1
        while lo < hi:
            mid = (lo + hi + 1) // 2
            if starts[mid] <= idx:
                lo = mid
            else:
                hi = mid - 1
        return lo

    before, after = {}, {}
    for d in decls:
        sl = line_of(d['start'])
        el = line_of(d['close'])
        indent = re.match(r'\s*', lines[sl]).group(0)
        # keep doc comments / annotations attached: climb over the comment block above
        top = sl
        while (top > 0 and re.match(r'\s*(//|@\w|/\*|\*)', lines[top - 1])
               and not re.match(r'\s*// -{10,}', lines[top - 1])):
            top -= 1
        label = ('class ' if d['kind'] == 'class' else '') + d['name']
        desc = describe(d)
        start = f'{indent}// >>> START  {label}' + (f'  -  {desc}' if desc else '')
        end = f'{indent}// <<< END    {label}'
        before.setdefault(top, []).append((d['depth'], start))
        after.setdefault(el, []).append((d['depth'], end))

    out = []
    for idx, line in enumerate(lines):
        for _, m in sorted(before.get(idx, []), key=lambda t: t[0]):
            out.append(m)
        out.append(line)
        for _, m in sorted(after.get(idx, []), key=lambda t: -t[0]):
            out.append(m)
    return '\n'.join(out), clean


def main():
    check = '--check' in sys.argv
    stale, failed, changed, total = [], [], 0, 0
    for root, _, files in os.walk(LIB):
        for f in files:
            if not f.endswith('.dart'):
                continue
            path = os.path.join(root, f)
            with open(path, encoding='utf-8') as fh:
                original = fh.read()
            total += 1
            try:
                new, clean = annotate(original)
            except Exception as e:  # noqa: BLE001
                failed.append((path, str(e)))
                continue
            # safety net: removing the markers must give back exactly the clean code
            assert strip_markers(new) == clean, path
            if new != original:
                stale.append(path)
                if not check:
                    with open(path, 'w', encoding='utf-8', newline='') as fh:
                        fh.write(new)
                    changed += 1
    rel = lambda p: os.path.relpath(p, ROOT).replace('\\', '/')
    if failed:
        for p, e in failed:
            print('SKIPPED (could not parse):', rel(p), e)
    if check:
        if stale:
            print('Markers out of date in', len(stale), 'file(s). Run: python tools/annotate_code.py')
            for p in stale[:20]:
                print('  ', rel(p))
            sys.exit(1)
        print('Markers up to date.')
    else:
        print(f'annotated {changed} of {total} files ({len(failed)} skipped)')


if __name__ == '__main__':
    main()

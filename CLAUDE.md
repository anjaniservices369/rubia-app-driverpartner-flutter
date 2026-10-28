# Notes for AI assistants working on this repo

- After changing any file under `lib/`, run
  `python tools/annotate_code.py && python tools/update_docs.py`
  (a project hook in `.claude/settings.json` does this automatically after edits).
  This refreshes the `// >>> START` / `// <<< END` markers and `docs/CODE_MAP.md`.
- Every Dart file starts with a plain-language header block (`// ----` ... `// ----`).
  New files need one; copy the style of any existing file.
- If you change behaviour the guides describe (payments, login, push, ride steps), also update
  `docs/OWNER_GUIDE.md` and `docs/DEVELOPER_GUIDE.md` - those narrative parts are not generated.
- Never put the local test base URL (`127.0.0.1`) or secrets in a commit.

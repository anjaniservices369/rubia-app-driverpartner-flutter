# Rubia Driver (Flutter)

The Android app for Rubia **drivers**: register, get approved, go online, accept bookings,
complete rides, collect payment, and track earnings. It talks to the Rubia backend over a
JSON API; nothing important is stored on the phone.

## Read this first

| You are... | Start here |
|---|---|
| The business owner / non-technical | [`docs/OWNER_GUIDE.md`](docs/OWNER_GUIDE.md) |
| A developer taking over the code | [`docs/DEVELOPER_GUIDE.md`](docs/DEVELOPER_GUIDE.md) |

Every Dart file under `lib/` begins with a short plain-language header saying what the file
is for (and flagging files that are unused), and every class/function is wrapped in
`// >>> START` / `// <<< END` markers. [`docs/CODE_MAP.md`](docs/CODE_MAP.md) is generated
from the code (file list, endpoints, launch checklist) and cannot go stale.

Keep them in sync with `python tools/annotate_code.py && python tools/update_docs.py`.
Enable the commit check once with `git config core.hooksPath .githooks`.

## Quick start

```bash
flutter pub get
flutter analyze
flutter build apk --debug
```

The server is chosen at build time (`API_BASE_URL` in `lib/constants/apiConstants.dart`); a plain build uses the
live server. For a backend on your computer build with
`--dart-define=API_BASE_URL=http://127.0.0.1:8080/api/` and run `adb reverse tcp:8080 tcp:8080` for every connected phone.

## Before a release

See "Things you should know before launch" in the owner guide and "Known issues" in the
developer guide. In short: build with `--dart-define=CASHFREE_PRODUCTION=true` for real payments, point
`apiBaseUrl` at the live server, set the OneSignal Android (FCM) credentials in the OneSignal
dashboard, and keep a safe backup of the signing keystore (`jks/`, now git-ignored).

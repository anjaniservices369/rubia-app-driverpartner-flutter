# Reminders to keep in the admin dashboard

*Written for: the business owner, and whoever maintains the admin panel (backend project) —
paste these as pinned tasks/notes there. This repository cannot add them itself.*

---

## Reminder 1 — Back up the app signing key (HIGH, one-time, do it now)

| | |
|---|---|
| **Title** | Back up the Rubia Driver app signing keystore |
| **Priority** | High |
| **Owner** | Business owner (or a trusted developer, with the owner present) |
| **Due** | Now — before the next app release |
| **Status** | Open |

### What
Copy the file **`jks/vgow.jks`** from the Rubia Driver app project to a safe place, and write
down its **key alias and the two passwords** (store password, key password).

### Why this matters
- This file is the app's "signature". Without it you **cannot publish updates** to the same
  app on Google Play; you would have to publish a brand-new app and lose installs and reviews.
- It has been stored in the code repository in the past. It has now been removed from the
  working files and is ignored by git, but **it still exists in the repository's history**,
  so anyone who has had access to the repository could have a copy.

### How
1. Copy `jks/vgow.jks` to **two** separate safe locations (e.g. an encrypted USB drive kept
   offline, and a password manager or private cloud vault that supports file attachments).
2. Store the key alias and both passwords **separately from the file** (password manager).
3. Do not email it, do not put it in chat, do not commit it back to the repository.
4. Write the date of the backup and who holds the copies in the notes field below.

### Then check (5 minutes, Google Play Console)
- Open the app → **Setup → App integrity → App signing**.
  - If **"Play App Signing" is enabled**: the file you hold is only an *upload key*. If it ever
    leaks, ask Google to reset the upload key. Risk is limited.
  - If it is **not enabled**: the file is the *only* key. Treat the backup as critical, and
    consider enrolling in Play App Signing at the next release.

### Done when
- [ ] Two backups exist and were opened once to prove they are readable
- [ ] Alias and passwords are stored separately
- [ ] Play App Signing status checked and noted
- [ ] Date + holders written here: ______________________

---

*Add further reminders below. Another open item from the app's launch checklist, for
reference (details are in `docs/CODE_MAP.md`, section 1):*

- Real-money payments require building the release with `--dart-define=CASHFREE_PRODUCTION=true`
  and live Cashfree keys on the server.
- Point `apiBaseUrl` at the live server before release.
- Upload the Firebase service-account file in OneSignal (Settings → Platforms → Google Android).

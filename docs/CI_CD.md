# Rubia Driver app — CI/CD and environments

Package `com.rubia.driver`. Written 29 Oct 2026. No passwords or tokens are kept in this file.

## 1. Where the code lives

| Place | Address |
|---|---|
| GitLab | `gitlab.com/rubia-services-group/rubia-app-driverpartner-flutter` |
| GitHub | `github.com/anjaniservices369/rubia-app-driverpartner-flutter` |

Work goes to `develop` first; `git push all develop` pushes to both.

## 2. Pipelines

| | GitHub Actions | GitLab CI |
|---|---|---|
| Files | `.github/workflows/ci.yml`, `cd.yml` | `.gitlab-ci.yml` |
| What | CI: analyze, test, debug build. CD: signed builds per environment | verify; debug build for one CPU type (`android-arm64`, to fit the free runner's disk); no Gradle cache |

CD triggers: push to `develop` = `dev` (signed APK), push to `staging` = `staging` (signed APK), tag `v1.2.3` = `production` (signed AAB + APK, GitHub Release, Google Play upload if `PLAY_SERVICE_ACCOUNT_JSON` is set), or run by hand from the Actions tab.

## 3. Secrets and variables (names only)

- **Repository secrets (GitHub):** `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`, optional `PLAY_SERVICE_ACCOUNT_JSON`. Set on 29 Oct 2026 from the same `jks/vgow.jks` the customer app uses. The driver repo has no `android/key.properties`, so the passwords were reused from the customer app; **a signed build has not yet been run on the driver repo to confirm they open the keystore**.
- **Environments:** `dev`, `staging`, `production` exist on GitHub (production has a required reviewer; GitHub may not enforce it on a private repository on a free plan).
- **Per-environment variables:** `API_BASE_URL` for `dev` and `staging` = `https://staging.rubiaservices.org/api/` (**keep the trailing slash**: this app's built-in address `https://rubiaservices.org/api/` has one and the API paths do not start with `/`). Production is not set: the built-in live address is used. `CASHFREE_PRODUCTION=true` only on production once the server holds live Cashfree keys.

## 4. Git history cleaned (29 Oct 2026)

Build files under `android/app/build` (three `kernel_blob.bin` files of about 70 MB) had been committed long ago and made GitHub warn about large files. They were removed from the history of `develop`, `staging` and `rubia_driver_upgrade`, which were force-pushed to GitLab (and `develop` to GitHub). The current files are unchanged.

- **`main` on GitLab is protected** and refused the rewrite, so remote `main` still has the old history while the local `main` was rewritten. Do not push `main` from the old clone; decide first whether to allow a force-push once.
- Everyone with an old clone must **clone again**.
- A full backup of the repository before the rewrite is in `D:\backups\driver-before-rewrite.bundle` on the owner's PC.

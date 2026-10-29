# Rubia Driver app — Developer guide

*Written for: developers who will maintain this Flutter app. A plain-language overview for the
business owner is in `OWNER_GUIDE.md`.*

---

## 1. Stack at a glance

| Concern | Choice |
|---|---|
| Framework | Flutter 3.47 / Dart 3.x, Android is the real target (iOS/web/Windows folders exist but are not maintained) |
| Navigation + translations | **GetX** (`GetMaterialApp`, `Get.to`, `.tr`) |
| State | **Provider** (`ChangeNotifier`s in `lib/providers`) plus plain `StatefulWidget` state |
| Networking | `package:http` through `ApiHelper` |
| Local storage | `shared_preferences` (session + a few flags), `sqflite` (background location points) |
| Push | **OneSignal** (`onesignal_flutter`) |
| Maps / location | `google_maps_flutter`, `geolocator`, `flutter_background_service` |
| Payments | Cashfree PG SDK |
| Image uploads | Backend `POST media/upload` (stored on the Rubia server) |
| OTP autofill | `smart_auth` (Android SMS User Consent API) |

There is **no Firebase SDK** in the app. Firebase is used only as OneSignal's delivery
channel and is configured in the OneSignal dashboard.

---

## 2. Folder map

```
lib/
  main.dart                  App entry: startup checks, providers, first-screen routing
  responsive.dart            isMobile / isTab / isDesktop helpers
  api_services/              Everything that talks to the server (see §4)
  background_services/       Android foreground service that records the route during a ride
  constants/                 URLs, status numbers, colours, image paths
  globalFuctions/            "Twl" helper class (alerts, navigation, date formatting, image picking)
  globalWidgets/             Reusable buttons, text fields, drawer
  providers/                 ChangeNotifier state holders
  views/                     One folder per screen / feature (see §5)
packages/                    Patched copies of 3 abandoned plugins (see §8)
android/                     Gradle project (see §7)
docs/                        This documentation
```

Naming is inconsistent (`componants`, `globalFuctions`, `stetuesConstant`, `hoempageProvider`)
— typos kept because renaming churns every import. Folder `rider_Details` is imported as both
`rider_Details` and `rider_details`; this works on Windows/macOS but **breaks on Linux CI**.

---

## 3. Startup flow (`lib/main.dart`)

1. Create notification channels (`new_booking_alert` with ringtone, `other_high_importance_channel`).
2. `PushService.init()` — starts OneSignal if `oneSignalAppId` is set.
3. Read `authCode` from `SharedPreferences`.
   - none → *Login / Register* (`LoginPageView`; the three intro slides were removed on 29 Oct 2026).
   - present → call `driver/check`. On `OK` the response tells which onboarding step is
     unfinished; on a *session-invalid* NOK the stored code is deleted.
4. First screen is chosen in this order (first false wins):
   `PersonalDetails → EmergencyContact → VechileSelection → Documents → BankDetails →
   AddDetailsView → JoiningFees → ProfileReview (unless profile_verified) →
   LocationPopUpPage (consent and readiness) → BottomNavigation / Home`.

> A network failure during step 3 shows a retry screen and keeps the stored session. Do not
> treat a temporary backend failure as a logged-out account.

---

## 4. Server communication

### 4.1 Configuration — `lib/constants/apiConstants.dart`
- `apiBaseUrl` — must end in `/api/`. Local dev: `http://127.0.0.1:8080/api/` (see §9).
- Every endpoint is a constant such as `driver/bookings?auth_code=`; the session token is
  appended as a query string by the caller.
- `oneSignalAppId` — public OneSignal App ID.
- `skipperOffersEnabled = false` — the taxi/skipper ride-offer code is present but **disabled**
  in this app (see §6.4).

### 4.2 `ApiHelper` (`lib/api_services/ApiHelper.dart`)
- `getTypePost` / `getTypeGet` — all calls go through these. Both return decoded JSON.
- **Session handling**: the backend answers an invalid/expired token with **HTTP 200** and
  `{"status":"NOK","error":"User Not Found" | "Session Not Found" | "Auth code not found"}`
  (error may be a string or a list). `isSessionInvalid()` detects that and
  `handleSessionExpired()` wipes local storage (keeping the language) and goes to Login.
  Never test for HTTP 401.
- `getHeader()` calls `driver/check` before most requests (it validates the session every
  time). This means ~6 `check` calls per screen change — a known inefficiency.

### 4.3 API classes
| File | Responsibility |
|---|---|
| `userApi.dart` (`UserAPI`) | OTP send/verify, `check`, logout, notifications, lat/long, odometer, device token |
| `rideBookingsApi.dart` | Booking list/details, accept/reject, go-for-pickup, start/complete, earnings, reviews, referral |
| `DriverDetailApis.dart` | Registration data, vehicle types, documents, bank, online/offline status, payments, wallet, subscription |
| `mediaApi.dart` | Uploads one image to `media/upload`, returns its URL |
| `pushService.dart` | OneSignal init, foreground notifications, device-token sync |
| `locationPing.dart` | Posts position to `driver/update-lat-lng` every 20 s while online |
| `skipperApi.dart`, `offerService.dart` | Taxi/skipper ride-offer client (disabled) |
| `notificationController.dart` | Legacy, unused |

### 4.4 Response convention
`{"status":"OK", ...}` or `{"status":"NOK","error": ...}`. Some endpoints use `details`
instead of `error`. Always check `status`.

---

## 5. Screens (`lib/views`)

| Folder | Purpose |
|---|---|
| `appLanguage`, `logiPage`, `otpPage`, `referalCode` | First-run flow: language, login / register, OTP, optional referral code |
| `rider_Details` | Registration wizard: personal, emergency contacts, vehicle types, documents (`documents/componants/*`), bank, submit (`add_Details.dart`) |
| `joiningfees` | One-time fee payment (Cashfree) |
| `profile_review` | Approval states: under review / approved / blocked |
| `enable_location`, `locationError`, `location_popup_page.dart` | Permission and GPS gating |
| `bottomNavigation.dart` | Home / Bookings / Wallet / Profile tabs |
| `homePage` | Map, online switch, earnings tiles, notifications |
| `bookingsPage` | Available and accepted rides, fare breakdown |
| `ride_info` | The whole ride: details → go for pickup → OTP → photos → car number → start → complete |
| `odometer` | Start/end odometer capture |
| `bill_details`, `collect_payment.dart` | Final bill, cash/QR collection, review |
| `order_completed` | "Great job" end screen |
| `wallet` | Balance, top-up, transactions |
| `profilePage` | Profile, earnings, ride history, reviews, subscription, referral, language, support, tutorials, notifications |
| `skipperRide` | Taxi/skipper ride progress screen (disabled) |
| `translate.dart` | All UI strings (`en_us`, `hi_in`, `tl_in`) |

### Driver business flow, screen by screen

This is the current source-defined flow; it is a guide to navigation and options, not a claim
that every backend-dependent branch has been exercised.

1. **First launch and login**
   - A fresh session starts on the Login / Register screen (the intro slides are gone); it accepts a
     mobile number and requests an SMS OTP.
   - OTP supports resending and correcting the mobile number. Verification stores the session
     and routes the driver to the next registration step.
   - Onboarding, Login, and OTP are separate screens. OTP autofill uses Android's SMS User
     Consent prompt.
2. **Registration and review**
   - The `driver/check` startup flags select, in order: Personal details → Emergency contacts
     → Vehicle types → Documents → Bank details → Add-details/submit → Joining fee → Profile
     review. Required form fields and uploads are validated by their individual screens.
   - Documents links to separate selfie, driving licence, Aadhaar, and PAN capture screens.
     Joining-fee payment uses Cashfree; approval status is checked separately in Profile Review.
   - On approval, the app presents referral code and then a single guided location screen
     before the main tabs.
   - Both startup and post-OTP routing use `document_verification` to decide whether the
     Documents screen is still required, so logging in again resumes at the same registration
     step.
3. **Location consent, readiness, and main tabs**
   - One guided screen first explains the background-location use and requests permissions only
     after the driver taps Allow. It requests foreground location before background ("Allow all
     the time") access, as Android requires, then requests notifications. A denied permission
     still opens the existing recovery page with Android settings guidance. Once permissions are
     granted, the same screen advances to location readiness, obtains the current position,
     submits it to the backend, and opens Home after a successful response. Startup and the
     post-OTP/referral route enter through this consent step; no permission is pre-granted.
   - Main navigation is Home / Bookings / Wallet / Profile. Home shows a map, Online/Offline
     status, earnings/cash summaries, and notifications. Going online is conditional on
     booking eligibility; while online the location-ping service reports location.
4. **Bookings and ride**
   - Bookings provides Available Rides and Accepted Rides. Available rides can be opened for
     details and accepted when the account is eligible. Accepted rides reopen at a step chosen
     from booking status and the saved vehicle-photo state.
   - The ride path is: ride details → Go for pickup → arrival within the allowed distance →
     customer OTP → driver selfie and vehicle photos → vehicle number → Start ride → Complete
     ride → end verification/photos → final bill.
   - The start/end odometer screens exist, but are not reached by the currently traced
     accepted-ride path; do not describe odometer capture as a required ride step without
     confirming a backend or product requirement.
5. **Bill, payment, and follow-up**
   - Bill Details displays the final fare. When payment is due, Collect Payment exposes cash
     collection; successful collection leads to the review sheet, then the completion screen
     and Bookings.
   - The QR contents in Collect Payment are currently commented out; an operational QR
     collection option was not verified. Do not promise QR payment as a working driver action
     based on that screen alone.
   - Profile provides Earnings, Subscriptions, Ride History, Ratings & Reviews, Training
     tutorials, Notifications, Refer & Earn, App Language, Support, policy pages, and Logout.
     Wallet displays balance, Add Balance, Withdraw, and transaction history.

### Screen-consolidation notes

Location consent and location readiness now share one guided route; foreground location is
requested before background location, followed by notification access. The Android recovery
page, readiness behavior, and backend submission remain explicit steps. The post-OTP
registration route uses the same document-completion flag as startup. Do not conflate
registration validation with location setup or remove any registration validation.
- **Do not combine ride verification steps merely to reduce page count.** Customer OTP,
  identity/vehicle photo verification, vehicle-number entry, ride start, and end-of-ride
  verification each gate separate backend actions. A combined presentation would need to
  preserve each validation, retry, and status transition.

### Device smoke-test coverage (26 October 2026)

A manual test on a connected Android device verified onboarding, Login, OTP (using the
test-device SMS consent flow), location permission/readiness, Home/map, and navigation into
Bookings, Wallet, and Profile. Tutorial content, notifications, earnings, and an existing
completed ride's history/details were also opened. Available and Accepted rides showed no
active booking at the time. The account was already Online; no availability, ride, payment,
or logout action was performed. This was a smoke test, not full end-to-end ride or payment
coverage: there was no active ride to accept, and no payment was initiated.

### Ride lifecycle (status numbers in `constants/stetuesConstant.dart`)
`1 waiting` → `2 accepted` → `4 go for pickup` → `5 arrived` → `6 started` → `7 completed`
(`3/8/9/10/11` = rejected / cancelled variants). The app moves a ride with these calls:
`accept-ride` → `go-for-pickup` → `notify-arrived` → `arrived-location` (verifies the
customer's 4-digit OTP) → `vehicle-verification` (photos) → `start-ride` → `complete-ride` →
`collect-cash` → `add-review`.

---

## 6. Cross-cutting features

### 6.1 Push notifications
`PushService.init()` runs from `main()`. The OneSignal *subscription id* is the `device_token`:
sent in `verify-otp`, and re-sent through `driver/check` (`AuthSession[device_token]`) when it
changes. Foreground messages are shown with a local notification so the booking ringtone
plays. Android delivery requires the Firebase service-account JSON in the OneSignal dashboard.

### 6.2 Uploads
Every image goes `MediaApi.upload(file)` → backend returns a public URL → the URL is sent in
the existing form field (`profile_image`, documents, `vehicle-verification` …).
Photos are downscaled to ≤1600 px / quality 80 (server cap is ~4 MB). Network images have
no-op error handlers, so a missing file simply renders blank.

### 6.3 Location
- **Foreground**: `LocationPing` posts to `driver/update-lat-lng` while online (started from
  `HomePage.fetchCheckDetails`).
- **During a ride**: `background_services.dart` runs a foreground service, stores points in
  SQLite and also pings the server (min 10 s apart).
- **Android 14 requirement**: the service must declare `foregroundServiceType="location"` in
  the manifest *and* in `AndroidConfiguration`, plus the
  `FOREGROUND_SERVICE_LOCATION` permission. Missing this crashes the app the instant a ride
  starts (`MissingForegroundServiceTypeException`).

### 6.4 Skipper/taxi offers (disabled)
`OfferService` polls `skipper/new-request`, rings and shows an accept dialog. It exists
because the same backend has a taxi product. Driver-role accounts have no such endpoints, so
`skipperOffersEnabled` is `false`. Delete these files if never needed:
`skipperApi.dart`, `offerService.dart`, `views/skipperRide`, and the `SKIPPER_*` constants.

### 6.5 OTP autofill
`otpPage.dart` listens with `SmartAuth.getSmsWithUserConsentApi` and fills the PIN with the
first standalone 4-digit group. The received SMS is printed in **debug builds only**.

---

## 7. Android build notes

- Declarative Gradle plugins (`settings.gradle`), AGP 8.11, Gradle 8.14, Kotlin 2.2, Java 17.
- `android/build.gradle` contains a shim that gives old plugins a `namespace`, Java 17 and
  `compileSdk 36`, because several plugins are unmaintained.
- `android/gradle.properties`: `kotlin.incremental=false` (the pub cache and project on
  different drives break incremental Kotlin) and a 4 GB Gradle heap.
- Debug manifest (`android/app/src/debug`) allows cleartext HTTP for local backends; the
  release manifest does not.
- `compileSdk 36`. `permission_handler` is pinned to 12.x because 14.x needs compileSdk 37.

### Vendored plugins (`packages/`)
Patched copies, wired through `pubspec.yaml` (path / `dependency_overrides`):
`background_locator_2` (null-safety fix), `google_api_headers` (nullable signing info),
`location_permissions` (removed dead v1 `Registrar` code). Replace each if a maintained
version appears.

---

## 8. Local development

```bash
flutter pub get
flutter analyze            # ~580 info/warnings, 0 errors is the baseline
flutter build apk --debug  # first build is slow (~8 min)
```

Backend on the dev PC at `127.0.0.1:8080`. Build the app for it with
`--dart-define=API_BASE_URL=http://127.0.0.1:8080/api/` (a plain build uses the live server) and reach it from a phone with:

```bash
adb reverse tcp:8080 tcp:8080
```

If the phone suddenly shows onboarding or the login button spins forever, the reverse was
probably dropped — re-run the command above.
The dev backend accepts any OTP for the test number configured on the server.

---

## 9. Known issues / technical debt

The *automatically detected* launch checklist is in [`CODE_MAP.md`](CODE_MAP.md). Narrative
notes:

**Money / security**
1. **Cashfree mode** is `cashfreeProduction` in `constants/apiConstants.dart`
   (`bool.fromEnvironment('CASHFREE_PRODUCTION')`, default `false` = sandbox). Release builds
   for real money must pass `--dart-define=CASHFREE_PRODUCTION=true`, and the server's keys must
   match. Used in `joining _fees.dart`, `profilePage/subscription/subscription.dart`,
   `wallet/components.dart`. Those three now open Cashfree's **web checkout**
   (`CFWebCheckoutPaymentBuilder`); the SDK marked the old drop-in checkout as no longer
   supported. This was compiled but **not run against a real order** - test a joining fee,
   a subscription and a wallet top-up in the Cashfree sandbox before releasing.
2. **Withdrawal** is manual. `WalletCardWidget` shows "visit the office"; `withDrawAlert` (the
   in-app dialog) is commented out and `WITHDRAW_AMOUNT = 'driver/f'` is a placeholder.
3. `MyHttpOverrides` (accepts any TLS certificate) is installed only when `kDebugMode`.
4. `jks/vgow.jks` is untracked and ignored, but remains in git history. Treat as exposed if the
   repository was shared; check Play App Signing.

**Behaviour**
5. Language: `main.dart` restores the saved `language_code` through `_savedLocale()` and sets
   `fallbackLocale` to English. `chooseAppLanguage.dart` offers positions `[0, 1, 3]`
   (English, Hindi, Telugu) via `_offeredLanguageIndexes`; add 2/4/5 back when
   `translate.dart` has `kn_in` / `ta_in` / `gu_in`. The Telugu locale is spelled `tl_in`.
6. Network failure throws a `SnackBar` controller (`throw ScaffoldMessenger...`) in `ApiHelper`,
   which leaves loading buttons spinning. Show the message and return a NOK map instead.
7. `driver/check` is called before almost every request (`ApiHelper.getHeader`).
8. Copy errors: the end-of-ride dialog says "Before you *start* ride"; the review sheet says
   "Write a review to *Driver*".
9. Registration continuation is selected in both startup and post-OTP code; keep their
   `driver/check` flag handling aligned (see §5, "Driver business flow").
10. **Back button** uses `PopScope(canPop: false)` plus a callback (the old `WillPopScope` is
    gone). Unlike `WillPopScope`, *every* `PopScope` in the same route is notified on back, so
    never give a page its own handler if it is a tab inside `BottomNavigation` (they all stay
    alive in an `IndexedStack`) or sits inside another page that has one; the extra handler
    would also fire, e.g. push a second `BottomNavigation` or hide the exit dialog.
11. **Push permission:** `PushService.init()` asks for the notification permission without
    waiting for the answer, so the first screen is not held behind the system dialog.

**Cleanup done**
- Unreferenced files (29, ~10,300 lines) were deleted; the file list in `CODE_MAP.md` is
  authoritative. `tools/update_docs.py` lists any file that nothing imports, so new dead code
  shows up there.

---

## 10. Keeping the documentation current

Three layers, from fully automatic to human-written:

| Layer | File | How it stays current |
|---|---|---|
| Start/end markers inside the code | `// >>> START  X` ... `// <<< END    X` around every class and function in `lib/` | `python tools/annotate_code.py` rewrites them (idempotent) |
| File inventory, unused files, endpoints, status numbers, **launch checklist** | [`CODE_MAP.md`](CODE_MAP.md) | `python tools/update_docs.py` regenerates it from the code |
| Explanations in plain language | `OWNER_GUIDE.md`, this file, the header comment in each file | Written by people; update when behaviour changes |

### Reading the markers
```dart
// >>> START  HomePage.build()  -  draws this screen / widget (its layout)
@override
Widget build(BuildContext context) { ... }
// <<< END    HomePage.build()
```
Names are generated from the code. The words after the dash are either a standard Flutter
meaning (`initState` = "runs once when the screen opens") or the method name read as plain
words. The markers are comments only: the tool checks, on every run, that removing them gives
back exactly the original code.

### What runs automatically
- **Git hook** `.githooks/pre-commit` refuses a commit when the markers or `CODE_MAP.md` are stale.
  Enable once per clone: `git config core.hooksPath .githooks`.
- **Claude Code hook** (`.claude/settings.json`) regenerates both after every file edit, and
  `CLAUDE.md` tells assistants to keep the narrative guides in step.
- To refresh by hand: `python tools/annotate_code.py && python tools/update_docs.py`.

### Rules for contributors
1. A new Dart file needs a header block (`// ----` / title / purpose / `// ----`); `CODE_MAP.md`
   lists files that miss one.
2. If you change payments, login, push or the ride steps, update the matching section of the
   owner and developer guides — a machine cannot rewrite those.
3. The launch checklist in `CODE_MAP.md` is detected from code (sandbox payments, localhost URL,
   certificate checks...). Do not release while it shows BLOCKER.

## 11. Changes of 27 Oct 2026

**Server address.** `lib/constants/apiConstants.dart`: `apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'https://rubiaservices.org/api/')`.
A normal build talks to the live server (an older backend: no radius, no route card). For a backend on the PC build with
`--dart-define=API_BASE_URL=http://127.0.0.1:8080/api/` and run `adb reverse tcp:8080 tcp:8080` for **every** connected phone; that build
cannot reach the backend without the forward (it used to be hard-coded, so a plain build only worked with a PC tunnel). Check
`adb -s <id> reverse --list` after restarting adb or reconnecting a phone.

**New booking alert** (`lib/api_services/newBookingAlert.dart`). Started and stopped next to `LocationPing` in `HomePage.fetchCheckDetails()`.
Every 10 s (and when the app resumes) it POSTs `driver/bookings` status 1 and compares booking ids with what it has seen: the first look after
going online only records them (no ring); every new id plays `assets/tones/noti6x.mp3` once (rings one after another, at most 5 per look); when
the set of ids changes (new, taken or expired) it bumps `NewBookingAlert.changes`, which `AvalableRide` listens to and reloads page 0.
`PushService` marks a booking it already rang for (`markAlerted`) and plays the foreground notification silently for a booking the poller
already rang, so the driver hears one sound per booking.

**Lists and screens that follow the server.** `AcceptedRides` has an 8 s silent refresh (a "No Bookings found" answer is an empty list).
`RideInfoPage` checks the booking every 8 s and on load; status 8 (customer cancelled) or 9 shows "Ride cancelled", forgets `trip_type` /
`booking_id` in SharedPreferences and goes to Bookings. The refresh button on the Bookings screen no longer calls the old hard-coded
production `assign-booking-to-driver` URL; offers are created by the server.

**Cards and bill.** `AvalableRide` no longer filters by a 25 km client-side distance (the server decides who sees a booking); it shows
`distance_to_pickup_km` / `eta_to_pickup_min` from the server. `lib/globalWidgets/viewDetailsButton.dart` is the "View full details" button
used by both lists. `lib/views/bill_details/route_conversion_card.dart` (shown on `BillDetailsPage` and `RideInfo` for history) draws the
message and a `GoogleMap` polyline from `radius_converted`, `radius_note`, `route_points`.

**Navigation bar.** `GetMaterialApp.builder` in `main.dart` keeps the app above the Android navigation bar (Android 15+ edge-to-edge) and
removes that height from the keyboard inset.

**The recorder (27 Oct 2026).** `background_services.dart` used `distanceFilter` 2000 / 5000, which is a distance in metres, so a short trip
recorded nothing; it is now 20 m for every ride. It clears the local `locations` table when the service starts (the service starts when the
driver reaches the OTP screen, just before the ride), shows the 'location is being tracked' notice once, and sends `accuracy`, `speed_kmh` and
`recorded_at` (ms) with every position (`LocationPing.send`, at most one every 10 s). The server adds up the distance from these (backend
MOBILE_APP_CHANGES.md section O). `drive_end_car-sides.dart` uploads at most about 300 points of the local table at completion (a backup:
the server's own track is used first).

**Still to do:** show the driver's distance so far on the ride screen.

**End of a ride (28 Oct 2026).** `collect_payment.dart` runs `collect-cash` and then opens `DriverAddReviews` (`collect_cash_botomsheet.dart`) in a
sheet that cannot be dismissed (`isDismissible: false`, `enableDrag: false`, `PopScope(canPop: false)`); Submit needs stars and a review.
`accepted_rides.dart` labels a completed ride *Collect payment* / *Add review*. `bookingPage.dart` has three tabs; the third is
`RideHistoryList(status: STATUS_RIDE_COMPLETED, allDates: true)` (`fetchBookingHistory(allDates: true)` sends 2000-01-01 .. today instead
of the Ride History date range). `AcceptedRideDetails.dart` shows the server's reason when an accept is refused.

## Account deletion (28 Oct 2026)
UserAPI.deleteAccount posts to driver/delete-account (DELETE_ACCOUNT in apiConstants.dart); _ProfilePageState._confirmDeleteAccount in views/profilePage/profilePage.dart asks, calls it, clears SharedPreferences and goes to LoginPageView. Server side: AccountDeletion::deleteUser in the backend (app/components/AccountDeletion.php). globalWidgets/driverFoodStayNote.dart shows the food-and-stay note on the ride details and the bill.

## Registration screens and the 28 Oct 2026 end-to-end run
**Page versus bottom sheet.** `rider_Details/componants/emergency_Contacts.dart`, `vehicle_Types.dart`
and `bank_details.dart` return a bare `Form`. From the Add-details hub they are shown with
`showModalBottomSheet`, which supplies a Material ancestor. `main.dart` (`nextScreen:`) and
`otpPage.dart` push them as full pages, where the `TextField`s had no Material ancestor
(crash) and the old `Twl.navigateBack(context)` popped the only route (black screen). Each `build()`
now keeps the form in `final form` and, when `ModalRoute.of(context) is PageRoute`, wraps it in
`Scaffold(body: SafeArea(child: form))`; after a successful save a page goes to
`AddDetailsView` via `Twl.forceNavigateTo`, a sheet still calls `Twl.navigateBack`. `personal_Details.dart`
already did this and is the reference.

**Licence save.** `documents/componants/driving_licence.dart`: `selectedIssuedDate` and
`selectedExpiryDate` are null until a date is picked (the boxes show `DateTime.now()` as text),
so `Twl.dateFormate(null)` threw and the spinner never stopped. `onTap` now checks both dates first and
alerts; a failed `validate()` also calls `stopLoading()`.

**Startup flags need an email.** `main.dart` reads `driver/check`'s `personal_details`,
`driver_emergency_contacts`, `driver_vehicle_types`, `document_verification` ... only when
`check['detail']['email'] != null`; a driver without an email always restarts at Personal details.

**What a driver needs before rides show up** (all server data, no app change): `is_paid_joining_fee`,
`profile_verified = 1`, `user.profile_image` set (the selfie step), and a row in `driver_subscription`
with `status = 1` and a future `end_date`; without the subscription the Bookings tab shows
"Your subscription is not active".

**Run of 28 Oct 2026.** Two phones (customer app, Partner app) against the local PHP backend and
`mysql:8.4` (see the customer app's `PROJECT_GUIDE.md` §7.2). Verified: OTP login of a new number,
all registration steps except the selfie (camera) and the joining fee (gateway), `accept-ride`,
`go-for-pickup`, `arrived-location` (ride OTP is `booking.otp`), `collect-cash`, the compulsory
review. `start-ride` and `complete-ride` were called through the API (the start sheet wants camera photos).
The bill was Rs 630 for 6.009 km (driver Rs 540, platform Rs 90) against a customer estimate of Rs 819 and
driver-list figures of Rs 702 / Rs 710.10; the difference is not explained yet.

**New known issues:** `address` posted by `personal_Details.dart` is not saved by the server (the dev
database kept it empty); the vehicle dropdown lists each type twice; the end-of-ride *Completed* tab was
empty before the cash was collected; background location is requested twice at set-up; typos
"u want submit" and "vechile".

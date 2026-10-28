# Rubia Driver app — Owner's guide

*Written for: the business owner (no programming knowledge needed). Developers should read
`DEVELOPER_GUIDE.md` next to this file.*

> **Always-current status:** the file [`CODE_MAP.md`](CODE_MAP.md) is rebuilt automatically
> from the code every time it changes. Its first table ("Launch checklist") lists, in plain
> terms, what is still not ready for real customers (test-mode payments, test server address
> and so on). The list below in section 4 was true when this guide was written; the table in
> `CODE_MAP.md` is always up to date.

---

## 1. What this app is

**Rubia Driver** is the app your **drivers** install on their Android phones. It is one half of
the Rubia platform:

| Part | Who uses it | What it does |
|---|---|---|
| **Rubia Driver app** (this project) | Drivers | Register, get approved, go online, accept bookings, drive, collect payment, see earnings |
| **Rubia customer app** (separate project) | Customers | Book a driver |
| **Rubia backend / admin panel** (separate project) | Your team | The "brain": stores all data, assigns bookings, approves drivers, handles money records |

The driver app does **not** store anything important itself. Everything (bookings, wallet,
earnings, documents) lives on the backend server; the app is the driver's window into it.

---

## 2. A driver's journey (what the app does, in order)

### Step A — Joining
1. **Welcome and login** — a new driver sees the onboarding slides, then enters a mobile
   number and requests an **SMS code (OTP)**. The app can offer to read the received code
   automatically. There are no passwords. The driver's language can be changed from the
   Profile area.
2. **Registration form**, in this order:
   1. Personal details
   2. Emergency contacts
   3. Vehicle types the driver can drive (e.g. SUV, automatic / manual)
   4. Documents: selfie, driving licence, Aadhaar card, PAN card
   5. Bank / UPI details
   6. Submit
3. **Joining fee** — the driver pays the one-time joining fee (the screen says ₹500).
4. **Profile review** — your team checks the documents in the admin panel and approves,
   rejects or blocks the driver. The driver sees one of three screens: *under review*,
   *approved*, or *blocked*.
5. **Referral and location setup** — after approval, the app offers the referral-code step,
   then guides the driver through one location screen. It explains why background location is
   needed, asks for foreground location first and then background location and notification
   permissions, checks location/GPS readiness, and submits the driver's current position before
   opening the main app. If permission is denied, the driver is shown recovery guidance and can
   open Android settings; permission is never granted automatically.

### Step B — A normal working day
1. **Home screen** — a map with a big **Online / Offline** switch and today's earnings.
2. **Going online** makes the driver visible to the system. While online, the app sends the
   driver's position to the server about every 20 seconds so your admin map can show them.
3. **Bookings tab** — *Available rides* (offered to this driver) and *Accepted rides*.
4. **Accept a ride** — the details show the customer, pickup and drop addresses, and fare.
   The driver must be eligible to accept bookings.
5. **Ride steps**:
   1. *Go for pickup*
   2. *Arrived* — the customer is notified
   3. Driver asks the customer for a **4-digit ride code** and types it in (proves they met)
   4. **Before the ride:** driver selfie and vehicle photos
   5. Enters the vehicle number and starts the ride
   6. *Complete ride* — end-of-ride verification/photos and drop-location confirmation
6. **Bill and payment** — the driver reviews distance, time, and amount, then can record cash
   collection and rate the customer. The QR content on the current Collect Payment screen is
   not active, so do not rely on in-app QR collection as an available payment option.

### Step C — Money and growth
| Screen | What the driver sees |
|---|---|
| **Wallet** | Balance, add money, withdraw, list of transactions |
| **Earnings** | Today / last 7 days / custom dates, per-ride breakdown |
| **Ride history** | Completed and cancelled rides |
| **Subscription** | Paid membership plans ("Driver Prime Membership") |
| **Refer & Earn** | Invite friends; the screen advertises "up to ₹50 per friend" |
| **Ratings & reviews** | What customers said |
| **Training tutorials** | How-to guides (e.g. "How to accept an order") |
| **Notifications** | Messages from you / the system |
| **Support** | Contact details and chat |

### What has and has not been tested on a device

A manual Android smoke test reached the Home map after onboarding, OTP login, and location
setup, and opened the Bookings, Wallet, Profile, tutorial, notification, earnings, and ride
history screens. The Available and Accepted ride lists had no active booking at the time,
so accepting and completing a ride and collecting payment were not tested. The test account
was already marked Online; no availability or payment setting was changed during the test.

### Flow notes

The location explanation and readiness steps now appear within one guided screen. The driver
must still explicitly respond to the permission request before the app checks GPS, gets the
current position, and submits it. After OTP login, the app resumes the registration step using
the same document-completion status as it uses on startup. Registration screens and their
validation remain separate. Ride OTP, identity/vehicle checks, ride start, and completion are
separate operational checks and should not be removed just to reduce the screen count.

---

## 3. Outside services the app depends on

| Service | Used for | Who controls it |
|---|---|---|
| **Your backend server** | Everything: login, bookings, money records | Your backend team |
| **SMS provider (2factor.in)** | Sending login codes | Backend / your 2factor account |
| **Google Maps** | Maps and addresses | Google Cloud account (billing!) |
| **OneSignal** | Push notifications ("new booking") | OneSignal dashboard |
| **Google FCM** (behind OneSignal) | Actually delivering pushes to Android phones | Firebase project, configured *inside* OneSignal |
| **Cashfree** | Online payments (joining fee, subscription, wallet top-up) | Cashfree account |

> Firebase is **no longer used inside the app**. It is only needed as the delivery channel for
> OneSignal push messages.

---

## 4. Things you should know before launch (honest status)

> The always-current version of this list is the **Launch checklist** table at the top of
> [`CODE_MAP.md`](CODE_MAP.md); it is detected from the code every time.

Items marked **ACTION** need a decision or a developer.

1. **ACTION - Payments are in TEST mode until you build for real money.**
   The joining fee, subscription and wallet top-up all use Cashfree. The app now chooses the
   mode with one switch: a normal build is always **test mode** (cannot charge real money). The
   real-money release must be built with `--dart-define=CASHFREE_PRODUCTION=true`, and the
   server must hold your live Cashfree keys. The two must match, otherwise payments fail.
2. **ACTION - Server address.**
   Test builds point at a developer's computer (`127.0.0.1`). The release build must point at
   the real server: one line in `lib/constants/apiConstants.dart`.
3. **ACTION - Push notifications need one dashboard step.**
   In OneSignal -> Settings -> Platforms -> *Google Android (FCM)*, upload the Firebase
   service-account file. Until then phones cannot receive pushes (the app still works).
4. **Withdrawals are manual.** The wallet's Withdraw button tells the driver to visit the
   office with documents. An in-app withdrawal exists in the code but is switched off, and its
   server address was never finished. If you want in-app withdrawals, a developer and the
   backend team must build it.
5. **Languages.** The picker now offers only **English, Hindi and Telugu**, the three that are
   translated. Kannada, Tamil and Gujarati are hidden until someone writes their translations
   (in `lib/views/translate.dart`). The driver's choice is now **remembered** between launches.
6. **Security certificate check** is now **on in release builds**. It is only relaxed in
   developer (debug) builds so they can talk to a test server.
7. **Signing key.** `jks/vgow.jks` is no longer tracked by git (it is listed in `.gitignore`),
   but it was committed in the past, so it still exists in the repository's history.
   Copy it to a safe place **now** and keep a backup: without it you cannot update the app on
   Google Play. If the repository was ever shared, ask whether Google Play App Signing is on
   (then a leaked upload key can be reset).
8. **Old test rides.** Ride #921 (December 2024) is still "accepted" for the test driver and
   blocks that driver from taking new rides. Real drivers with abandoned rides will be blocked
   the same way until your team completes or cancels them in the admin panel.
9. **Support contact** (phone +91 78936 53899, rubia.services@gmail.com) is typed directly into
   several screens. If it changes, a developer must edit the app and release a new version.

### Cleaned up in the latest pass
- About 10,000 lines of unused leftover code (29 files such as `dummy.dart`) were removed.
- Payment mode, certificate checking and language handling were fixed as described above.

---

## 5. What was changed in the latest upgrade (October 2026)

You asked for the app to work with the updated backend. In plain words:

- **Login is more secure** — the login token is now a signed ticket that expires after
  90 days. Everyone had to log in again once.
- **Push notifications moved to OneSignal** because Google shut down the old system.
- **Photos and documents now go to your own server** to be stored on your own server. Old
  document photos could not be recovered (the old links are dead), so drivers must upload
  their documents again.
- **Live location** — the app now tells the server where the driver is every ~20 seconds
  while online, so the admin map works.
- **Login code is read automatically** from the SMS (one tap to allow).
- **Fixed a crash** that happened on Android 14 phones the moment a ride started.
- **Technical upgrades** so the app builds with current tools (this is invisible to users but
  keeps the project maintainable).

---

## 6. Where is everything? (for when you hire a developer)

| You want to change… | Look at |
|---|---|
| Colours, fonts | `lib/constants/constants.dart` |
| Wording on screens / translations | `lib/views/translate.dart` |
| Server address, API paths | `lib/constants/apiConstants.dart` |
| Joining fee amount shown | `lib/views/joiningfees/joining _fees.dart` |
| What drivers see per ride step | `lib/views/ride_info/` |
| Payment screens | `lib/views/joiningfees`, `profilePage/subscription`, `wallet` |

---

## 7. Small glossary

- **OTP** — one-time password: the 4-digit SMS code used to log in, and the 4-digit ride code
  the customer tells the driver.
- **API / backend** — the server the app talks to.
- **Push notification** — an alert that appears on the phone even when the app is closed.
- **Sandbox / production** — test mode vs. real-money mode of a payment provider.
- **APK / App Bundle** — the installable app file / the file you upload to Google Play.
- **auth_code / token** — the digital ticket the app shows the server to prove who the
  driver is.

---

## 8. How the documentation stays up to date

- The **code map** (`CODE_MAP.md`) and the small START/END markers inside the code are produced
  by a program, so they always match the app. A saved change that makes them stale is blocked
  at commit time until they are refreshed.
- The **explanations in this guide** are written by people. When a developer changes how
  payments, login, notifications or the ride steps work, they are expected to update the
  relevant section. Ask for this in any developer's task description.

## 9. What changed on 27 October 2026 (new bookings, cancelling, route card)

- **New bookings arrive by themselves, with a sound.** While you are Online and the app is open (also in the background), the app checks
  every 10 seconds for new bookings. Each new booking plays the "new booking" sound once and appears in *Available rides* without pressing
  refresh. Bookings that were already waiting when you went online do not ring. If the app is fully closed you hear about a booking only
  through a push notification, which needs the OneSignal Android credentials (see section 4).
- **Distance and time on every booking card:** "8.3 km from you | about 20 min to reach", worked out from where you are now to the
  customer's pickup (an estimate).
- **Every card has a "View full details" button.**
- **A booking is shown to every online driver within the admin's booking radius of the customer.** The first driver to accept gets it; it
  then disappears from the others' lists.
- **If the customer cancels a ride you accepted:** the ride leaves *Accepted rides* by itself within a few seconds, a message "The customer
  cancelled this ride" appears if you are on the ride screen, and the ride is listed under *Cancelled* in your ride history ("cancelled by
  the customer"). You are credited the cancellation amount (Rs 100 now).
- **If you cancel an accepted ride:** you are charged the driver cancellation charge (Rs 500 now), the booking goes back to the other
  drivers and is not offered to you again. It shows under *Cancelled* as "cancelled by you".
- **Rides billed differently from the booking** (booked in-city but driven out of town, or booked one way but driven as a round trip, or
  the other way round) show a card with the explanation and a map of the route on the ride details and the bill.
- **After a ride: bill, collect cash, review.** Once you complete a ride you see the final bill, then collect the cash; a review sheet then
  opens for the customer (stars and a written review are compulsory; it cannot be closed without them). Until you have collected the payment
  **and** reviewed, the ride stays in *Accepted rides* (marked *Collect payment* / *Add review*) and you cannot accept another ride; the app
  says which ride is waiting.
- **Bookings now has a *Completed* tab** next to Available and Accepted. It lists every ride you have collected and reviewed, with its
  distance, time and amount; tap a card for the ride details. *Profile > Ride History* still shows rides by the dates you choose.
- **The app's screens stay above the phone's navigation bar**, so bottom buttons are not hidden.
- **Which server the app uses is chosen when it is built** (a normal build uses the live server; see the developer guide).

## 10. What changed on 28 October 2026
- **Delete account:** Profile -> Delete account (red text under Logout). After a confirmation the account and personal details are erased at once and the app returns to Login. It is refused while a ride is in progress. For people who no longer have the app, the public page /account-deletion on the website takes a request that support confirms by phone within 30 days. **That page's address must be entered in Play Console -> App content -> Data safety -> Account deletion link** (the old Google Form link is dead).
- Outstation round trips show a note that the customer provides the driver's food and stay (not in the fare).
- A driver must have a photo to accept a ride; ride bill, payment collection and the compulsory rating are as in section 9.
- **Splash:** only the logo on white (Android 12 system splash `values-v31`, same size in-app, fade).

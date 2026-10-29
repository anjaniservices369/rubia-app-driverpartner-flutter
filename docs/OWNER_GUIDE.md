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
1. **Welcome and login** — a new driver sees the logo splash, then the *Login / Register* screen and enters a mobile
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

**Full run on 28 October 2026 (two phones, local test server).** A brand-new driver was registered
from the first login to the Home screen, then took a customer's ride from acceptance to payment and
review. Registration (personal details, emergency contacts, vehicle type, driving licence, Aadhaar,
PAN, police verification, bank details) worked. The selfie and the joining-fee payment were not
tested (the selfie needs the camera; the fee opens the payment gateway); they were marked done in
the *test* database only. Ride steps through the app: accept, go for pickup, arrived with the
customer's 4-digit code. The ride start and finish were sent from the server side, not tapped on
the phone (the start screen asks for selfies and car photos). Then the app's Collect Cash and the
compulsory 5-star review worked, and the customer's phone showed the bill and its own compulsory
rating. No real money was moved.

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

## 11. What changed on 28 October 2026 (registration screens)
- **Registration screens that went blank or crashed are fixed.** *Emergency contacts*, *Vehicle types*
  and *Bank details* used to work only when opened from the *Add details* list. When the app opened one of
  them by itself (after logging in again, or on start-up) it crashed ("No Material widget") or ended on a
  black screen after saving. They now open as normal pages and, after saving, return to the *Add details* list.
- **Driving licence:** pressing *Save* without choosing the issued and expiry dates left the button
  spinning forever with no message. It now says "Please select the issued date and the expiry date".
- **Still open (found in the same test):**
  - The home address typed in *Personal details* is not stored on the driver's record.
  - The vehicle list shows each type twice with no label (probably one set per gear type).
  - Typos: "Are you sure u want submit the fields" and "Select vechile type".
  - Background location is asked for twice during set-up.
  - The completed-ride *Completed* tab was empty until the payment was collected.
- **29 Oct 2026:** the three intro slides after the splash were removed; a new partner goes straight to *Login / Register*
  (button *Continue*). The first registration field is labelled *First Name* (was *Full Name*), and the OTP screen's
  heading is translated. Run on the Redmi from the splash: all five registration steps, including the selfie taken with
  the camera and the other documents, saved without any database edits; the app stops at the joining-fee screen
  (payment was not made).

## 12. Paying the joining fee (29 Oct 2026)
- The joining-fee screen shows the fee set in the admin dashboard (it used to say Rs 500 always) and lets the driver
  choose **Razorpay** or **Cashfree**. Razorpay's checkout offers UPI (PhonePe, Google Pay, Paytm and other UPI apps), cards,
  netbanking and wallets; Cashfree offers UPI (PhonePe, Google Pay, Paytm, any UPI id or QR), cards, wallets and netbanking.
- The old "QR Payment" page (fixed UPI id, screenshot on WhatsApp) can no longer be reached; its Continue button always failed.
- The app never decides a payment is paid: the server reads the payment back from the gateway and only then marks the fee paid.
- Tested on a phone in the gateways' **test modes** (Razorpay demo bank page, Razorpay test UPI, Cashfree simulator): a failed
  payment leaves the fee unpaid and shows a message; a successful one marks it paid (Rs 499) and the app goes to profile review.
  No real money moved and the real PhonePe / Google Pay / Paytm apps were not operated. A live-key test of each is still needed.
- **PhonePe as its own gateway** does not exist on the server (only a placeholder) and needs PhonePe merchant credentials.
- Wallet top-up and subscription still use the older code and were not changed.
- **Wallet top-up (29 Oct 2026):** *Add Balance* no longer opens the fixed-UPI-id QR page (which never recorded anything). It opens a small
  sheet: type an amount (1 to 50,000 rupees), choose Razorpay or Cashfree and pay; the wallet is credited only after the server has checked the
  payment with the gateway. Tested with a UPI payment and a test card on Razorpay: the balance and the transaction list update at once.
- **Withdraw** is still manual: the app shows the office address, phone and timings. The server's withdraw call (not used by the app) used to accept a
  negative amount, which *raised* the balance, and refused to withdraw the exact full balance. It now accepts only a whole number of rupees
  from 1 up to the full balance.
- **The old manual QR payment is gone (29 Oct 2026).** The fixed-UPI-id QR pages for the joining fee, wallet top-up and subscription ("send the
  screenshot on WhatsApp"), and the company UPI id + UTR approval list in the dashboard's Payments screen, were removed. All three payments now go
  through Razorpay or Cashfree inside the app and are confirmed by the server. Old manual payments already recorded stay visible in *Latest payments*.
  **Subscription:** *Subscribe now* opens the same gateway sheet; the price is the active plan's price.
- **Prices come from the dashboard (checked 29 Oct 2026).** The *joining fee* is set in the dashboard under Integrations -> Driver settings (0 = no fee);
  the *subscription price*, days and text are set under Plans. Change either one and it applies at once: the app screens, the gateway checkout and the amount
  charged all use the new value (the app never sends a price). Checked by changing the fee to Rs 650 and the plan to Rs 450 and reading them back through
  the API and both gateways, then restoring Rs 499 and Rs 300. Subscribing also works with Razorpay's Wallet option (Mobikwik) in test mode.
- **Withdrawals go to the driver's own bank account (29 Oct 2026).** *Wallet > Withdraw* now opens a sheet that shows the balance, the minimum
  (dashboard setting *min_withdraw*) and the bank details the driver registered (account number masked), with a *Change bank details* link, and lets the
  driver request an amount (whole rupees). A driver with no bank details is asked to add them first. In the dashboard, **Payments > Withdrawals** lists
  each request with the driver's full bank details; after transferring the money you press *Mark paid* and enter the bank reference (UTR), or *Reject* to
  return the amount to the balance. The bank used is also written into the request so it stays readable if the driver edits the details later.
- **Approval stays manual.** After registering and paying the joining fee a driver waits on the *under review* screen until someone checks every detail in
  the dashboard (Drivers > the driver's profile) and approves. A crash when approving a driver who was not referred (no referral record) was fixed.
- **Checked end to end (29 Oct 2026, new driver on a real phone, local server):** splash, Login / Register, OTP, all five registration steps (selfie
  with the camera, licence, Aadhaar, PAN, police, bank), joining fee by Razorpay, dashboard approval, location permission, Home, and the Withdraw sheet.

## 13. Builds and releases (29 Oct 2026)

New app versions are built by GitHub Actions: pushing to `develop` makes a signed test build, pushing to `staging` a staging build, and a tag such as `v1.2.3` a production release (with a required approval click). Details for a developer are in [CI_CD.md](CI_CD.md). The git history was also cleaned of old build files; anyone with an old copy of the code must download it again.

**After the joining fee (checked 30 Oct 2026).** The driver lands on the "Profile under review" screen: "Your profile is under reviewing process. Please wait 2 to 4 days." (it used to say "Please Visit our office"). "Check Status" says the application is still in progress until your team approves the driver in the dashboard (Users > Drivers). On approval the driver is sent a "Profile verification" notification and, the next time the app opens or signs in, moves on to the location step and then Home. Tested on a phone against the local backend.

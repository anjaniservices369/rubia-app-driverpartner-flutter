# Google Play - Data safety answers: Rubia Driver Partner (com.rubia.driver)

Play Console -> App content -> Data safety. Answers below match the app's code and permissions (checked 28 Oct 2026).
Fill every question; "Incomplete data safety declaration" disappears when the form is saved and submitted.

## 1. Overview questions
| Question | Answer |
|---|---|
| Does your app collect or share any of the required user data types? | **Yes** |
| Is all of the user data collected by your app encrypted in transit? | **Yes** (the live server is https only) |
| Do you provide a way for users to request that their data is deleted? | **Yes** |
| Account creation methods | **Username/phone number and OTP** |
| Delete account URL | `https://<your production domain>/account-deletion` (this replaces the dead Google Form link; deploy the backend first) |
| Privacy policy URL | the public Privacy Policy page of the website |

## 2. Data types collected
Service providers that only process data for us (OneSignal, Sentry, Google Maps) are not "sharing". A driver's name, photo, vehicle and live position go to the customer of a ride only to carry out that ride (user-directed transfer, not marked as shared).

| Category | Data type | Collected | Shared | Optional? | Purposes |
|---|---|---|---|---|---|
| Personal info | Name, Email address, Phone number, User IDs | Yes | No | Required | App functionality, Account management, Fraud prevention and security |
| Personal info | Other info (date of birth, gender, **Aadhaar, PAN, driving licence, police verification, vehicle RC** documents) | Yes | No | Required to work as a driver | Account management, Fraud prevention and security, Compliance |
| Location | Precise location | Yes - **including in the background** (ride tracking and distance while a ride is on; the app shows a foreground notification) | No | Required | App functionality |
| Location | Approximate location | Yes | No | Required | App functionality |
| Photos and videos | Photos (selfie, document and vehicle pictures) | Yes | No | Required | App functionality, Fraud prevention and security |
| Financial info | Bank account details (payouts), Purchase history (earnings, wallet, joining fee, payments) | Yes | No | Required | App functionality, Account management |
| App activity | App interactions / Other user-generated content (ratings, reviews, ride history) | Yes | No | Required | App functionality |
| App info and performance | Crash logs, Diagnostics | Yes (personal data not sent) | No | Required | Analytics (app stability) |
| Device or other IDs | Device or other IDs (push notification id) | Yes (OneSignal) | No | Required | App functionality |

Not collected: messages, audio, files, calendar, health, web browsing, installed apps, SMS/call logs, contacts.

## 3. Other Play Console items for this app (they are checked together)
- **Background location:** Play asks for a declaration and a short video showing the feature. Core feature: tracking the ride distance and position for the customer and for the fare. Describe it exactly so.
- **Permissions to explain or remove if unused:** SYSTEM_ALERT_WINDOW, USE_FULL_SCREEN_INTENT (new ride alert), SCHEDULE_EXACT_ALARM, READ/WRITE_EXTERNAL_STORAGE, ACTIVITY_RECOGNITION. Remove the ones the app does not need; each one left in has to be justified.
- Privacy Policy text must match this table and mention account deletion.

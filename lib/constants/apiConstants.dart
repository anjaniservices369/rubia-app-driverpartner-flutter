// ----------------------------------------------------------------------
// Server addresses & switches
//
// Every server address the app calls, plus the OneSignal App ID and feature
// switches. THIS is where the app is pointed at the test or the live server
// (apiBaseUrl).
//
// Developer note: Endpoints ending in '?auth_code=' get the session token
// appended by the caller.
// ----------------------------------------------------------------------
// const String apiBaseUrl = 'http://hyperstorz.anxion.co.in/api/';

//Base Url
//const String apiBaseUrl = 'http://rubia.anxion.co.in/api/';
// The server the app talks to is chosen when the app is built. A normal build uses the hosted server, so the app works with just
// an internet connection. For testing against a backend on the PC, build with
//   --dart-define=API_BASE_URL=http://127.0.0.1:8080/api/
// and forward the port to the phone with `adb reverse tcp:8080 tcp:8080` (without the forward that build cannot reach the backend).
const String apiBaseUrl = String.fromEnvironment('API_BASE_URL',
    defaultValue: 'https://rubiaservices.org/api/');


// const String apiBaseUrl = 'https://system.rubia.services/api/';
//  const String apiBaseUrl = 'https://rubiaservices.org/app/api/';
// const String apiBaseUrl = 'http://167.99.120.178/app/api/'; //latest
//
//Login Apis
const String SEND_OTP = 'driver/send-otp';
const String VERIFY_OTP = 'driver/verify-otp';
const String CHECK_API = 'driver/check?auth_code=';
const String UPDATE_LAT_LONG = 'driver/update-lat-lng?auth_code=';
const String REFERAL = 'driver/apply-referral?auth_code=';
const String NOTIFICATION = 'driver/list-fcm-notifications?auth_code=';
const String NOTIFICATION_CLEAR = 'driver/clear-notifications?auth_code=';
const String LOGOUT = 'driver/logout?auth_code=';
const String DELETE_ACCOUNT = 'driver/delete-account?auth_code=';

//Driver Details Apis
const String UPDATE_PROFILE = 'driver/update-profile?auth_code=';
const String UPLOAD_PROFILE_IMAGE = 'driver/upload-profile-picture?auth_code=';
const String UPLOAD_DRIVING_LICENSE = 'driver/driving-license?auth_code=';
const String UPLOAD_AADHAR_CARD = 'driver/add-aadhar?auth_code=';
const String UPLOAD_PAN_CARD = 'driver/add-pan-card?auth_code=';
const String POLICE_VERIFICATION = 'driver/police-verification?auth_code=';
const String VEHICLE_TYPES = 'driver/vehicle-types?auth_code=';
const String VEHICLE_TYPE_ADD = 'driver/driver-vehicle-types-add?auth_code=';
const String DIRVER_ONLINE_STATUS = 'driver/driver-status?auth_code=';
const String ADD_DRIVER_EMERGENCY_CONTACT = 'driver/add-driver-emergency-contacts?auth_code=';
const String ADD_DRIVER_BANK_DETAILS = 'driver/driver-bank-details-add?auth_code=';
const String PAY_JOINING_FEE = 'driver/pay-joining-fee?auth_code=';

//Payment GateWay Apis Cashfree
const String CREATE_ORDER = 'driver/create-order?auth_code=';

//Subscriptio Apis
const String DRIVER_SUSCRIPTION = 'driver/subscribe-now?auth_code=';
const String DRIVER_PLAN_DETAILS = 'driver/plan?auth_code=';

//Adderesss Apis
const String MY_ADDRESS_LIST = 'driver/all-address-list?auth_code=';
const String ADD_UPDATE_ADDRESS = 'driver/add-delivery-address?auth_code=';
const String CHECK_DELIVERY_ADDRESS = 'driver/check-delivery?auth_code=';
const String DELETE_ADDRESS = 'driver/delete-address?auth_code=';
const String CURRENT_CITY = 'driver/current-city?auth_code=';

//Driver Booking Apis
const String DRIVER_BOOKINGS = 'driver/bookings?auth_code=';
const String BOOKING_DETAILS = 'driver/view-booking-details?auth_code=';
const String ACCEPT_RIDE = 'driver/accept-ride?auth_code=';
const String REJECT_RIDE = 'driver/reject-ride?auth_code=';
const String COMPLETE_RIDE = 'driver/complete-ride?auth_code=';
const String RIDE_PICK_UP = 'driver/go-for-pickup?auth_code=';
const String NOTIFY_ARRIVED_LOCATION = 'driver/notify-arrived?auth_code=';
const String DRIVER_ARRIVED_LOCATION = 'driver/arrived-location?auth_code=';
const String VEHICLE_VERIRIFICATION = 'driver/vehicle-verification?auth_code=';
const String START_RIDE = 'driver/start-ride?auth_code=';
const String BOOKING_HISTORY = 'driver/bookings-history?auth_code=';
const String CANCEL_RIDE = 'driver/cancel-ride?auth_code=';
const String COLLECT_CASH = 'driver/collect-cash?auth_code=';

//Driver Reviews Apis
const String DRIVER_RATINGS_REVIEWS = 'driver/rating-and-reviews?auth_code=';
const String ADD_RATINGS_REVIEWS = 'driver/add-review?auth_code=';

//Earnings Apis

const String ADD_BALANCE = 'driver/add-balance?auth_code=';
const String AVAILABLE_BALANCE = 'driver/available-balance?auth_code=';
// Placeholder path: the withdraw dialog is disabled; withdrawals are handled at the office.
const String WITHDRAW_AMOUNT = 'driver/f?auth_code=';
const String TRANSACTION_LIST = 'driver/transaction-list?auth_code=';
const String DASHBOARD_EARNINGS = 'driver/earnings-dash-board?auth_code=';
const String DRIVER_EARNINGS = 'driver/my-earnings?auth_code=';
const String MY_EARNINGS_DASHBOARD = 'driver/my-earnings-dash-board?auth_code=';

//
const String MY_REFERAL_EARNINGS = 'driver/my-referral-earings?auth_code=';
const String MY_REFERALS = 'driver/my-earnings?auth_code=';

//odometer apis
const String STARTING_ODOMETER = 'driver/update-odometer-start?auth_code=';
const String ENDING_ODOMETER = 'driver/update-odometer-end?auth_code=';

/// OneSignal App ID for the Partner (driver) app. Backend `PUSH_DRIVER` must be
/// `onesignal`. Leave empty to disable push registration.
const String oneSignalAppId = '72d43997-f9ac-4ed0-aaaa-8a8830060bd3';

// Ride flow (contract C2). All POST, form-encoded, `auth_code` header.
// These belong to the taxi/skipper partner app, not the driver app: the
// driver account has no `driver/new-request`. Kept switched off
// (`skipperOffersEnabled`) in this app.
const String rideApiPrefix = 'skipper/';
const String SKIPPER_ONLINE_STATUS = rideApiPrefix + 'update-online-status';
const String SKIPPER_UPDATE_LAT_LNG = rideApiPrefix + 'update-lat-lng';
const String SKIPPER_NEW_REQUEST = rideApiPrefix + 'new-request';
const String SKIPPER_ACCEPT_OR_REJECT = rideApiPrefix + 'accept-or-reject';
const String SKIPPER_CHANGE_STATUS = rideApiPrefix + 'change-status';
const String SKIPPER_VERIFY_RIDE_OTP = rideApiPrefix + 'verify-ride-otp';

/// Ride request statuses used by the skipper endpoints.
const int RIDE_ACCEPTED = 4;
const int RIDE_ON_THE_WAY = 5;
const int RIDE_ARRIVED = 6;
const int RIDE_REJECTED = 7;
const int RIDE_STARTED = 8;
const int RIDE_COMPLETED = 9;

/// Poll `skipper/new-request` and ring while online. Only accounts with the
/// backend role the dispatcher targets receive offers (see C2).
const bool skipperOffersEnabled = false;

/// Cashfree payment mode (joining fee, subscription, wallet top-up).
/// Default is TEST mode (sandbox) so a normal build can never charge real money.
/// For a real-money release build pass the flag explicitly:
///   flutter build appbundle --release --dart-define=CASHFREE_PRODUCTION=true
/// It must match the Cashfree keys configured on the server (test keys <-> sandbox).
const bool cashfreeProduction =
    bool.fromEnvironment('CASHFREE_PRODUCTION', defaultValue: false);

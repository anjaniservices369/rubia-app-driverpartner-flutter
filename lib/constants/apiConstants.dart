// const String apiBaseUrl = 'http://hyperstorz.anxion.co.in/api/';

//Base Url
//const String apiBaseUrl = 'http://rubia.anxion.co.in/api/';

// const String apiBaseUrl = 'https://system.rubia.services/api/';
//  const String apiBaseUrl = 'https://rubiaservices.org/app/api/';
const String apiBaseUrl = 'http://167.99.120.178/app/api/'; //latest
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
const String oneSignalAppId = '';

// Skipper ride flow (contract C2). All POST, form-encoded, `auth_code` header.
const String SKIPPER_ONLINE_STATUS = 'skipper/update-online-status';
const String SKIPPER_UPDATE_LAT_LNG = 'skipper/update-lat-lng';
const String SKIPPER_NEW_REQUEST = 'skipper/new-request';
const String SKIPPER_ACCEPT_OR_REJECT = 'skipper/accept-or-reject';
const String SKIPPER_CHANGE_STATUS = 'skipper/change-status';
const String SKIPPER_VERIFY_RIDE_OTP = 'skipper/verify-ride-otp';

/// Ride request statuses used by the skipper endpoints.
const int RIDE_ACCEPTED = 4;
const int RIDE_ON_THE_WAY = 5;
const int RIDE_ARRIVED = 6;
const int RIDE_REJECTED = 7;
const int RIDE_STARTED = 8;
const int RIDE_COMPLETED = 9;

/// Poll `skipper/new-request` and ring while online. Only accounts with the
/// backend role `skipper` receive offers (see MOBILE_APP_CHANGES.md C2).
const bool skipperOffersEnabled = true;

// ----------------------------------------------------------------------
// Status codes
//
// The numbers the server uses for states: ride status, payment type,
// online/offline, profile approved/rejected, image types.
//
// Developer note: Typo in the file name is historical.
// ----------------------------------------------------------------------
//Add details status
const PERSONAL_DETAIL = 1;
const VEHICAL_SELECTION = 2;
const DOCUMENT_UPLOADS = 3;
const BANK_DETAILS = 4;

//documents status
const SELFIE_ADDED = 1;
const DRIVING_LICENCE = 2;
const RC_UPLOAD = 3;
const ADHAAR_CARD = 4;
const PAN_CARD = 5;
const CHASISNUMBER = 6;

//profile review status
const VERIFIED = 1;
const PENDING = 2;
const REJECTED = 3;

//online stauts
const SKIPPER_OFFLINE = 2;
const SKIPPER_ONLINE = 1;

//payment status
//open payment
const PAYMENT_STATUS_PAID = 1;
const PAYMENT_STATUS_PENDING = 2;
const PAYMENT_STATUS_FAILED = 3;

//Vehicle Type Constants

const vehicle_types_automatic = 1;
const vehicle_types_manual = 2;

//profile verified status

const profile_verified_yes = 1;
const profile_verified_no = 2;
const profile_verified_rejected = 3;

//Driver online status
const online_status_yes = 1;
const online_status_no = 2;

//Driver Ride Constants
const STATUS_WAITING_FOR_DRIVER = 1;
const STATUS_DRIVER_ACCEPTED = 2;
const STATUS_DRIVER_REJECTED = 3;
const STATUS_GO_FOR_PICKUP = 4;
const STATUS_ARRIVED_LOCATION = 5;
const STATUS_START_RIDE = 6;
const STATUS_RIDE_COMPLETED = 7;
const STATUS_USER_CANCELLED = 8;
const STATUS_BOOKING_AUTO_CANCELLED = 9;
const STATUS_DRIVER_CANCELLED = 10;
const STATUS_ACCEPTED_RIDES = 12;
const STATUS_CANCELLED = 11;

//trip type
const RIDER_TYPE_ONEWAY = 1;
const RIDER_TYPE_ROUNDTRIP = 2;

//rider type
const TRIP_TYPE_INTERCITY = 1;
const TRIP_TYPE_OUTSTATION = 2;

const CAR_TYPE_AUTOMATIC = 1;
const CAR_TYPE_MANUAL = 2;

const is_vehicle_damage_protection_yes = 1;
const is_vehicle_damage_protection_no = 2;

//payment type
const payment_method_wallet = 1;
const payment_method_qr = 2;
const payment_method_cash = 3;

//Image upload status
const image_type_front = 1;
const image_type_back = 2;
const image_type_side_one = 3;
const image_type_side_two = 4;
const image_type_damages = 5;
const image_type_selfie = 6;

//Ride Status Before or afetre
const type_before_ride = 1;
const type_after_ride = 2;
//Payment type
const payment_type_credit = 1;
const payment_type_debit = 2;

const payment_status_success = 1;
const payment_status_pending = 2;
const payment_status_failed = 3;

// ----------------------------------------------------------------------
// All on-screen text (translations)
//
// Every sentence shown in the app, in English, Hindi and Telugu. To change
// wording or add a language, edit this file.
//
// Developer note: GetX Translations. Keys: en_us, hi_in, tl_in. Used as
// 'key'.tr throughout the views.
// ----------------------------------------------------------------------
import 'package:get/get.dart';

import '../constants/constants.dart';

// >>> START  class LanguageTranslations
class LanguageTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // English Starts Here Z
        'en_us': {
          //carnumberscrren
          'enter_car_number': 'Enter Car Number',
          'subscribe_now': 'Subscribe Now',
          'vehicle_gear_type': 'Vehicle Gear Type',
          'manual': 'Manual',

          'automatic': 'Automatic',

          'view_bill': 'View Bill',
          'write_a_review_to_driver': 'Write a review about the customer',

          // takeselfioccra

          'Before_you_start_ride_please_selfie_along':
              'Before you start ride please selfie along',
          'with_car_number_plate': 'with car number plate',
          //verificationpopup
          'Please_be_ready_with_your_camera_and_clean_your_lens':
              'Please be ready with your camera and clean your lens',
          'take_photos_of_car': 'take photos of car',
          'before_you_start_ride_please_take_selfies_&':
              'Before you start ride please take selfies &',
          'before_you_end_ride_please_take_selfies_&':
              'Before you end ride please take selfies &',
          'verification': 'Verification',
          'car_number_Cant_Be_Empty': 'Car number cant Be Empty',
          //  profile  review
          'your_Profile_Is_Under_Reviewing\nprocess._Please_Wait_2_To_4_Days':
              'Your profile is under reviewing process. please wait 2 to 4 days',
          // JOINING  FEES

          'accepted_rides': 'Accepted Rides',
          'available_rides': 'Available Rides',
          'prices_may_vary':
              'Kindly be aware that the pricing structure is influenced by the distance & time traveled.',
          'and_privacy_policy.': 'Make picture clear',
          'take_selfie': 'Take Selfie',
          'from_the_front_angle.': 'from The front angle',
          'take_front_picture.': 'Take front picture',
          'before_you_start_ride_please_images_of_car':
              'Before you start ride please images of car',
          'make_sure_that_picture_should_be_clear_and_detail.':
              'Make sure that picture should be clear and detail',
          'make_picture_clear.': 'and Privacy Policy.',
          'Pay_₹500_Joining_fees': 'Pay ₹500 Joining fees',
          'Joining_fees': 'Joining fees',
          'by_submission_you_agree_to_our': 'By submission you agree to our',
          'terms_&_condition': 'Terms & Condition',
          'by_submission_you_agree_to_our_terms_&_condition':
              'By submission you agree to our Terms & Condition',
          'the_joining_fees _for_drivers_is_collected_to_cover_any_potential_damages,_violations,_orvunpaid_fees.':
              'The Joining fees for drivers is collected to cover any potential damages, violations, or unpaid fees.',
          //EMERGENCY CONTACT

          'emergency_contact_details': 'Emergency Contact Details',
          'emergency_contacts': 'Emergency Contacts',
          'upload_your_driving_license': 'Upload Your Driving License',
          'Person': 'Person',
          'vehicle_types': 'Vehicle Types',
          'relation_ship_can_not_be_empty': 'relation ship can not be empty',
          'name': 'Name',
          'name_can_not_be_empty': 'Name Can Not Be Empty',
          'phone_number': 'Phone Number',
          'relation_ship': 'Relation Ship',
          'aadhar_number': 'Aadhar Number',
          //
          'Resend_Code': 'Resend Code?',
          "earnings_by_orders": "Earnings by orders",
          'Choose_your_ride': 'Choose Your Ride',
          'Choose_your_service': 'Choose Your Service',
          'Home': 'Home',
          'confirm_your_cancellation': 'Confirm your cancellation',
          'Once_you_cancel_your_ride_you_will_be_pay_fee_Rs_500_for_cancellations_as_per_our_policy':
              'Cancellation of rides is subject to a fee as per our policy.',
          "Driver_details": "Driver Details",
          'Address_details': 'Address Details',
          'bill_details': 'Bill Details',
          'Ride_status': 'Ride Details',
          'Ride': 'Ride',
          'Loads': 'Loads',
          'Ride_now': 'Ride now',
          'Outstation': 'Outstation',
          'Confirm_Ride': 'Confirm Ride',
          'Rentals': 'Rentals',
          'Bike_Car_Auto': 'Bike, Car, Auto',
          'Load_now': 'Load now',
          'Outstation_service': 'Outstation service',
          'Rentals_service': 'Rentals service',
          'More_with_Taxi_Go': 'More with Taxi Go!',
          'Pickup_point': 'Pickup point',
          'Dropping_point': 'Dropping Point',
          'Search_Destination': 'Search Destination',
          'Pick_Up_Date': 'Pick Up Date',
          'Pick_Up_Time': 'Pick Up Time',
          'Return_Date': 'Return Date',
          'Return_Time': 'Return Time',
          'Later': 'Later',
          'Now': 'Now',
          "Book_Ride": 'Book Ride',
          'Select_destination_location': 'Select destination location',
          'Select_Location': 'Select Location',
          'My_favourite_locations': 'My favourite locations',
          'Find_a_place': 'Find a place ...',
          'Check_Location': 'Check Location',
          'we_are_unable_to_find_your_pincode_please_drag_the_place_picker':
              'we are unable to find your pincode. please drag the place picker',
          "Place_not_in_area": "Place not in area",
          'Select_Vehicle': 'Select Vehicle',
          'Select_Package': 'Select Package',
          "Please_wait": "Please wait ...",
          'Please_hold_we_are_searching_for':
              'Please hold! we are searching for',
          'nearby_skipper_for_you': 'nearby skipper for you',
          'Cancel_Ride': 'Cancel Ride',
          'Apply_Coupon_Code': 'Apply Coupon Code',
          'Pay_At_Drop': 'Pay At Drop',
          'Change_payment_Method': 'Change payment Method',
          'Your_skipper_is_arriving': 'Your skipper is arriving',
          'Your_skipper_is_arrived': 'Your skipper is arrived',
          'Price': 'Total Price',
          'Pay_now': 'Pay now',
          "Don't_press_back_until_the_payment_is_completed":
              "Don't press back until the payment is completed.",
          'i_agree_to_The': 'I agree to the',
          'Contact_driver': 'Contact driver',
          'Your_ride_is_started': 'Your ride is started',
          'Skipper': 'Skipper',
          'Online_mode': 'Online mode',
          'Wallet_pay': 'Wallet pay',
          'Cash_mode': 'Cash mode',
          'OTP': 'OTP',
          'No': 'No',
          'submit': 'Submit',
          'Yes': 'Yes',
          'Estimate_fare': 'Estimate fare',
          'subscription_plan': 'Subscription Plan',
          'Submit_your_rating': 'Submit your rating',
          'driver_ prime _membership': 'Driver Prime Membership',
          'Give_Rating': 'Give Rating',
          'You_rated': 'You rated',
          'Are_you_sure_you_want_to_sign_out':
              'Are you sure you want to sign out?',
          'Cancel': 'Cancel',
          'OK': 'OK',
          'Logout_Failed': 'Logout Failed',
          'Please_retry': 'Please retry',
          'Favorites_Location': 'Favorite Location',
          'Choose_Language': 'Choose Language',
          'Emergency_Contact': 'Emergency Contact',
          'Logout': 'Logout',
          'Amount': 'Amount',
          'Ride_Status': 'Ride Status',
          'New_Request': 'New Request',
          'Ride_Booked': 'Ride Booked',
          'Complete_Totally': 'Complete Totally',
          'Payment_Type': 'Payment Type',
          'email_cant_be_empty': "email can't be empty",
          'please_enter_a_valid_email_address':
              'please enter a valid email address',
          'Privacy_Policy': 'Privacy Policy',
          'Terms_&_Conditions': 'Terms & Conditions',
          'Add_New': 'Add New',
          'TaxiGo': 'TaxiGo',
          'Customer_Support': 'Customer Support',

          'Edit_Profile': 'Edit Profile',
          'collect_bill': 'Collect Bill',
          'Full_name': 'Full name',
          'Phone_Number': 'Phone Number',
          'Error_of_coupons': 'Error of coupons',
          'No_rides_found': 'No rides found',
          'Select_Title': 'Select Title',
          'Save_as_Favorites': 'Save as Favorite',
          'Replace': 'Replace',
          'Please_choose_a_title_for_selected_address':
              'Please choose a title for selected address',
          'Title': 'Title',
          'enter_title': 'enter title',
          'Save': 'Save',
          'Delete': 'Delete',
          'Delete_Address': 'Delete Address',
          'Are_you_sure_you_want_to_delete_this_address':
              'Are you sure you want to delete this address ?',
          'Apply_Coupons': 'Apply Coupons',
          'Date': 'Date',
          'Ride_Id': 'Ride Id',
          'Total_Amount': 'Total Amount',
          'Duration': 'Duration',
          'mins': 'mins',
          'km': 'km',
          'amount_cant_be_empty': "amount can't be empty",
          'Enter_amount': 'Enter amount',
          'Minimum_200_required_to_unlock_withdraw':
              'Minimum ₹200 required to unlock withdraw',
          'Submit': 'Submit',
          'Terms_&_Condition': 'Terms & Condition',
          'By_login_you_agree_to_our': 'By login you agree to our',
          'Date_of_birth': 'Date of birth',
          'Enter_valid_date': 'Enter valid date',
          'Enter_date_in_valid_range': 'Enter date in valid range',
          'OTP_Verification': 'OTP Verification',
          'Enter_the_4_digit_code_we_sent_you_to_verify_your_phone_number':
              'Enter the 4 digit code we sent you to verify your phone number',
          'send_to': 'Send to',
          'We_unable_to_get_your_Pincode': 'We unable to get your Pincode',

// Walletpage
          "Wallet": "Wallet",
          "All_Transactions": "All Transactions",
          "Select_Date": "Select Date",
          "Available_Balance": "Available Balance",

//homePage
          "select_location": "Select Location",

//My Rides
          "Active_Rides": "Active Rides",
          "Completed": "Completed",
          "Cancelled": "Cancelled",
          "Track_Rider": "Track rider",
          "Contact_Rider": "Contact rider",

          ///
          "Payment_paid_from_wallet": "Payment paid from wallet",
          "Wait_for_payment": "Wait for payment",
          "your_uPI": "Your UPI",

          // settingpage
          "Also_notify_when_receiving_invites":
              "Also notify when receiving invites",

          "Left_from_school": "Left from school",
          "Hangouts_video_call": "Hangouts video call",
          "Reached_at_school": "Reached at school",
          "Drop_Notifications": "Drop Notifications",
          "When_driverpartner_reached_at_pickup_location":
              "When the driver partner reaches the pickup location",
          "Pick_up_Notifications": "Pick up Notificationst",
          "When_trip_started_at_starting_point":
              "When the trip starts at the starting point",
          "Trip_start_Notifications": "Trip start Notifications",
          "Settings": "Settings",

          //   otp_page
          "privacy_policy": "Privacy Policy",
          "terms_&_Condition": "Terms & Condition",
          "and": "and",
          "by_login_you_agree_to_our": "By login you agree to our",
          "resend(30s)": "Resend(30s)",
          "don't_receive_the_code?": "Don't receive the code?",
          "Log_in": "Log in",
          "OTP_length_did_not_match": "OTP length did not match",
          "please_enter_OTP": "Please enter OTP",
          "sent_to": "Sent to",

          //support
          "support": "Support",
          "easy_go": "TaxiGo",
          "customer_support": "Customer Support",
          "chat": "Chat",
          //ride info
          "ride_info": "Ride Info",
          'ride_id: ': 'Ride Id: ',
          //rideDetails
          'cancel_ride': 'Cancel Ride',
          //payNow
          'please_Pay_The_Amount\nBefore_Contuning':
              'Please pay the amount\nbefore contuning',
          'payout_details': 'Payout Details',
          'pay_now': 'Pay Now',
          'payment_under_process': 'Payment Under Process',
          'please_Don’t_Go_Back_Or_Refresh_The_Page\nas_We_Are_Processing_Your_Payment':
              'Please don’t go back or refresh the page\nas we are processing your payment',
          //customerSupport
          'please_Select_Reason_For_Cancel_ride':
              'Please select reason for cancel ride',
          'unsafe_Pickup_area': 'Unsafe pickup Area',
          'unable_To_Swipe_Arrived': 'Unable to swipe arrived',
          'wrong_Pickup_Location': 'Wrong pickup location',
          'long_Pickup': 'Long pickup',
          'heavy_Traffic': 'Heavy traffic',
          //BackCollectedButton
          'back': 'Back',
          //RateCard
          'rate_card': 'Rate Card',
          'monday_To_sunday': 'Monday to Sunday',
          'maximum_Payout_Limit_Is_₹500': 'Maximum payout limit is ₹500',
          "bike": "Bike",
          "auto": "Auto",
          //BikeInfo
          'base_Fare': 'Base fare',
          'minimum_Fare': 'Minimum fare',
          'earning_Per_km': 'Earning per Km',
          'price_Per_Minute': 'Price per minute',
          'platform_Charge': 'Platform charge',
          'outstation_rides': 'Outstation Rides',

          'pickup_extra_km_Fare_Post_2km': 'Pickup Extra km fare post 2km',
          '(Max_10)': '(max 10)',
          'every_Km_Till_8km': 'Every km till 8km',
          'Per_Km ': 'per km ',
          'every_Km_Above_8km': 'Every km above 8km',
          'are_you_satisfied_with_our_service':
              'Are you satisfied with our service',
          //CollectPaymentView
          'collect_payment': 'Collect Payment',
          'ride_iD: ': 'Ride ID: ',
          "collect_amount": "Collect Amount",
          'generate_qR_code': 'Generate QR Code',
          'or': 'Or',
          'collect_cash': 'Collect Cash',
          //CollectCash
          'collect_Cash_Form_The_Customer.': 'Collect cash form the customer.',
          'collected': 'Collected',
          //ChooseAppLanguageView
          'chengee': 'Chenge',
          'app_languagee': 'app language',
          ////
          'english': 'English',
          'hindi': 'Hindi',
          'kannada': 'Kannada',
          'telugu': 'Telugu',
          'tamil': 'Tamil',
          'gujarati': 'Gujarati',
          'app_language': 'App Language',
          'set_language': 'Set Language',

          'Privacy' : 'Privacy Policy',
          'Terms' : 'Terms & Conditions',
          'Cancellation' : 'Cancellation & Refund Policy',
          //AddDetailsView
          'add_details': 'Add Details',
          'full_name_Cant_Be_Empty': 'Full Name Cant Be Empty',
          'full_name_Must_Be_Minimum_1_Digits':
              'Full Name Must Be Minimum 1 Digits',

          '_Details': 'Personal details',
          'vehicle_Details': 'Vehicle details',
          'documents': 'Documents',
          'bank_Details': 'Bank details',
          'i_Agree_to_The': 'I agree to the ',
          'terms_&_conditions': 'Terms & Conditions',
          'next': 'Next',
          //VehicleRegistration
          'vehicle_registration_card_(RC)': 'Vehicle Registration Card (RC)',
          'upload_your_vehicle_registration_card_(RC)':
              'Upload Your Vehicle Registration Card (RC)',
          'front_side': 'Front Side',
          "camera": "Camera",
          "gallery": "Gallery",
          'back_side': 'Back Side',
          'rC_number': 'RC Number',
          'rC_Number_Cant_Be_Empty': 'RC nuumber cant be empty',
          'rC_Number_Must_be_Minimum_10_Characters':
              'RC nuumber must be minimum 10 characters',
          'enter_rC_number': 'Enter RC Number',
          'save': 'Save',
          //TakeYourSelfie
          'add_your_selfie': 'Add Your Selfie',
          'take_your_selfie': 'Take Your Selfie',
          'we_Use_Your_Selfie_To_Compare_With_Your_id':
              'We use your selfie to compare with your Id',
          'good_Lighting': 'Good lighting',
          'make_Sure_You_Are_In_A_Well_Lit_Area_And_Both_Ears_Are_Uncovered ':
              'Make sure you are in a well lit area and both ears are uncovered ',
          'look_Straight': 'Look straight',
          'hold_Your_Phone_At_Eye_Level_And_Looks_Straight_To_The_Camera':
              'Hold your phone at eye level and looks straight to the camera',
          'open_camera': 'Open Camera',
          'male': 'Male',
          'female': 'Female',
          'Others': 'Others',
          'month/date/year': 'Month/Date/Year',
          'enter_Valid_Date': 'Enter valid date',
          'enter_Date_In_Valid_Range': 'Enter date in valid range',
          'personal_details': 'Personal Details',
          'first_name': 'First Name',
          'firstName_Cant_Be_Empty': 'FirstName cant be empty',
          'firstName_Must_Be_Minimum_1_Digits':
              'FirstName must be minimum 1 digits',
          'full_name': 'Full Name',
          'last_name': 'Last Name',
          'lastName_Cant_Be_Empty': 'LastName cant be empty',
          'lastName_Must_Be_Minimum_1_Digits':
              'LastName must be minimum 1 digits',
          'enter_mail_id': 'Enter Mail Id',
          'e-mail_Address': 'E-mail address',
          "invalid_email": "Invalid Email",
          'enter_date_Of_birth': 'Enter Date of Birth',
          'date_Of_Birth': 'Date of birth',
          'home_address': 'Home Address',
          'home_addres_Cant_Be_Empty': 'Home Addres cant be empty',
          'home_addres_Must_Be_Minimum_1_Digits':
              'Home Addres must be minimum 1 digits',
          'enter_home_address': 'Enter Home Address',
          'city': 'City',
          'city_Cant_Be_Empty': 'City cant be empty',
          'city_Must_Be_Minimum_1_Digits': 'City must be minimum 1 digits',
          'enter_City': 'Enter city',
          'state ': 'State ',
          'state_Cant_Be_Empty': 'State cant be empty',
          'state_Must_Be_Minimum_1_Digits': 'State must be minimum 1 digits',
          'enter_State': 'Enter  state',
          'pincode': 'Pincode',
          'pincode_Cant_Be_Empty': 'Pincode cant be empty',
          'pincode_Must_Be_Minimum_6_Digits':
              'Pincode must be minimum 6 digits',
          'enter_Pincode': 'Enter pincode',
          //PanCard
          'upload_your_pan_card': 'Upload Your PAN Card',
          'pan_number': 'PAN Number',
          'pan_number_can_not_be_empty.': 'PAN number can not be empty.',
          'enter_pan_number': 'Enter PAN Number',
          //VechileSelection
          'job_details': 'Vehicle details',
          'which_Vehicle_Will_You_Use?': 'Which vehicle will you use?',
          'vehicle_type': 'Vehicle Type',
          'electric': 'Electric',
          'non-electric': 'Non-electric',
          "Km)": 'km)',
          //DrivingLicense
          'driving_license': 'Driving Licence',
          'issue_date': 'Issue Date',

          'issued_date': 'Issued Date',

          'select_expiry_date': 'Select expiry date',
          'police_verification': 'Police verification',
          'learner’s_License_Not_Allowed.': 'Learner’s license not allowed.',
          'driving_license_number': 'Driving Licence Number',
          'driving_License_Cant_Be_Empty': 'Driving Licence cant be empty',
          'driving_License_Must_Be_Minimum_16_Characters':
              'Driving Licence must be minimum 16 characters',
          'expiry_date': 'Expiry Date',
//Documents
          'upload_All_documents,_required_For_Your_Verification.':
              'Upload all Documents, Required for your verification.',
          'upload_Your_Aadhar_Card': 'Upload Your Aadhar Card',
          //Demo
          'membership_For_45_Days': 'Membership for 45 days',
          'free': 'Free',
          '10_Days_Left': '10 days left',
//BankDetails
          'enter_A_Valid_iFSC_Number.': 'Enter a valid IFSC number.',
          'add_your_bank_details': 'Add Your Bank Details',
          'account_holder_name': 'Account holder name',
          'enter_bankholder_name_Cant_Be_Empty':
              'Enter Bankholder Name cant be empty',
          'enter_bankholder_name_Must_Be_Minimum_3_Characters':
              'Enter Bankholder Name must be minimum 3 characters',
          'enter_Bank_Holder_Name': 'Enter bank holder name',
          'account_Number': 'Account number',
          'account_Number_Cant_Be_Empty': 'Account number cant be empty',
          'account_Number_Must_Be_9_To_17_Digits':
              'Account number must be 9 to 17 digits',
          'iFSC_Code': 'IFSC code',
          'ifsc_Code_Can_Not_Be_Empty.': 'Ifsc code can not be empty.',
          'enter_Valid_Ifsc_Code': 'Enter valid ifsc code',
          'enter_Ifsc_Code': 'Enter ifsc code',
          'bank_name': 'Bank name',
          'bank_Name_Can_Not_Be_Empty.': 'Bank name can not be empty.',
          'enter_bank_Name': 'Enter bank name',
          'add_your_uPI': 'Add Your UPI',
          'uPI': 'UPI',
          'uPI_Id_Can_Not_Be_Empty.': 'UPI id can not be empty.',
//AdharCard
          'aadhar_card': 'Aadhar Card',
          'aadhar_Number': 'Aadhar number',
          'aadhar_number_Cant_Be_Empty': 'Aadhar Number cant be empty',
          'aadhar_number_Must_Be_12_Digits': 'Aadhar Number must be 12 digits',
//LoginPageView
          "login ": "Login ",
          "mobile_number ": "Mobile Number ",
          "mobile_Number_Can't_Be_Empty": "Mobile number can't be empty",
          "mobile_Number_Must_Be_10_Digits": "Mobile number must be 10 digits",
          'enter_Mobile_Number': 'Enter Mobile Number',
          'get_OTP': 'Get OTP',
          'your_number_is_safe_with_us_we_don’t_use_your_number':
              'Your number is safe with us, we don’t use your number',
          'for_any_unsolicitedcommunication':
              'for any unsolicitedcommunication.',
//NotificationView
          "clear": "Clear",
          "start_your_first_ride_with_winter_Offers.":
              "Start Your First Ride with Winter offers.",
          "happy_winter_offer_On_Your_first_ride,_enjoy_ride_With_best_offers._check_It_Now":
              "Happy Winter Offer on your First Ride, Enjoy Ride with Best Offers. Check it now",
          "2_Days_Ago": "2 days ago",
          // tutorials
          'How to earn more money with Rubia app?':
              'How to earn more money with Rubia app?',
          'How to accept order in Rubia app?':
              'How to accept order in Rubia app?',
//OrderCompletedView
          'ride_completed': 'Ride Completed',
          'great_Job': 'Great Job!',
          'ride_successfully_completed': 'Ride Successfully Completed',
          'total_Distance : ': 'Total distance : ',
          'total_Ride_Time : ': 'Total ride time : ',
          'amount': 'Amount',
          'add_review': 'Add Review',
          'Discount': 'Discount',
          'ready_for_next_ride': 'Ready For Next Ride',
          //ProfileReview
          'subscription': 'Subscriptions',
          'go_home': 'Go Home',
          'ride history': 'Ride History',
          ' rejected': ' Rejected',
          'please_Contact_Admin_Support': 'Please contact admin support',
          "your_profile_is_under_reviewing": "Your profile is under reviewing",
          "process._please_wait_2_to_4_days": "Process.Please wait 2 to 4 days",
//ReferAndEarnView
          "refer_&_earn": "Refer & Earn",
          "refer_friends": "Refer Friends",
          "earn_Upto_₹50_Per_Friend_You_Invite":
              "Earn upto ₹50 per friend you invite",
          "my_rewards": "My Rewards",
          "share_Your_Invite_Code": "Share your invite code",
          "When_your_friends_sign_up_this_referral_code_you_can_received_a_free_ride":
              "When your friends sign up this referral code, you can received a free ride",

          'refer': 'Refer',
          'when_Your_Friends_Sign_Up_This_Referral':
              "When your friends sign up this Referral",
          'Code,_You_Can_Received_A_Free_Ride':
              "code, you can received a free Ride",
//ReferalCodeView
          'login': 'Login',
          "referral_code_can't_be_empty": "Referral Code Can't Be Empty",
          "referral_code": "Referral Code",
          "skip": "Skip",
          "enter_refer_code": "Enter Refer Code",
          "Referra_cod_(Optional)": "Referral code (Optional)",

          'hello,_skipper': 'Hello, Skipper',
          'your_Account_Will_Be_Registered_With_This_Mobile_Number':
              'Your account will be registered with this mobile number',
          "have_a_referral_code?": "Have A Referral Code?",
          'enter_referral_code': 'Enter Referral Code',
          'referal_Code_Must_Be_5_Digits': 'Referal code must be 5 digits',
//ReviewsView
          'rating_&_reviews': 'Rating & Reviews',
          "rating": "Rating",
          "lorem_ipsum_Is_Simply_Dummy_Text_Of_The_Printing_And_Typesetting_Industry._lorem_ipsum_Has_Been_The_Industry's_Standard_Dummy_Text_Ever_Since_The_1500s.":
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
//RideHistoryView
          'ride_history': 'Ride History',
          'training_tutorials': 'Training tutorials',
          'notifications': 'Notifications',
          'today': 'Today',
          "all": "All",
          "completed": "Completed",
          "rejected": "Rejected",

          //RideHistoryCard
          'online_paid ': 'Online Paid ',
          'yesterday': 'Yesterday',
          'week': 'Week',
          'custom': 'Custom',

          'Personal_Details': 'Personal Details',
          //homepage drawer
          'earnings': 'Earnings',
          'order_history': 'Order History',
          'rating_reviews': 'Rating & Reviews',
          'please_pay_the_amount': 'Please pay the amount',

          'refer_earn': 'Refer & Earn',

          'before_continuing': 'before Continuing',
          'bookings': 'Bookings',
          //homepage earningcard
          'enable_location_to_get_nearby_rides':
              'Enable Location to Get Nearby Rides',
          'enable_location': 'Enable Location',
          'todays_earnings': 'Today\'s Earnings',
          'cash_collected': 'Cash Collected',
          //homepage flutterripplewidget
          'go_online': 'Go Online',
          //homepage currentlyofflinecard
          'offine_message':
              'You’re currently Offline, Please\ngo Online to Start earning',
          //homepage RoutingBooking
          'my_route_booking': 'My Route Booking',
          //riplepage widget
          'offline': 'Offline',
          'online': 'Online',
          //riplepage widget AccetedOrderCard
          'pickup': 'Pickup',
          'min_away': ' min away',
          'reject': 'Reject',
          "accept_ride": 'Accept Ride',
          'arrived': 'Arrived',
          'complete_ride': 'Complete Ride',
          'ride_id:': 'Ride Id:',
          'enter_otp': 'Enter OTP',
          'please_ask_otp_to_the_Customer': 'Please ask OTP to the customer',
          'otp_length_didn\'t_match': 'OTP length didn\'t match',
          'start_ride': 'Start Ride',
          'Go_to_drop_Location': 'Go to drop location',
          'go_to_pick_up': 'Go to pick up',
          //earningpage
          'today’s_earning': 'Today’s Earning',
          'payout': 'Payout',
          'history': 'History',
          //today earning
          'rides': 'Rides',
          'Km': 'Km',
          'hours': 'Hours',
          'avg_rating': 'Avg Rating',
          'reject_rides': 'Reject Rides',
          'today\'s_earning': 'Today\'s Earning',
          "order_id :": 'Order id :',
          //payout
          'online_collection': 'Online Collection',
          'amount_to_Pay': 'Amount to pay',
          'total_collected_cash': 'Total Collected Cash',
          'tax_charges': 'Tax Charges',
          'gst_payable_to_the_government.': 'GST payable to the government.',
          'platform_charge': 'Platform Charge',

          'Daily_one_time_fee.': 'Daily one time fee.',
          'transaction_fees': 'Transaction Fees',
          'Towards_unavoidable_costs_for\noperating_the_app':
              'Towards unavoidable costs for\noperating the app',
          'payable_amount': 'Payable Amount',
          'maximum_payout_limit_is ': 'Maximum payout limit is ',
          'please_pay_below-charges': 'Please pay below charges',
          'Immediately': 'immediately',
          'total_earnings': 'Total Earnings',
          'rides)': 'Rides)',
          //ride earning details
          'ride_details': 'Ride Details',
          'time_fare ': 'Time Fare ',
          'distance_fare ': 'Distance Fare ',
          'surge': 'Surge',
          'your_earnings': 'Your Earnings',
          // ride details
          'ride_id': 'Ride Id',
          'date': 'Date',
          'distance': 'Distance',
          'Mins': 'mins',
          'duration': 'Duration',
          'pickup_location': 'Pickup Location',
          'drop_location': 'Drop Location',
          //ride details-total rechargrcard
          'ride_amount': 'Ride Amount',
          'amount_pay_to_company': 'Amount Pay to Company',
          //profile
          'profile': 'Profile',

          'vehicle': 'Vehicle',
          'bank_details': 'Bank Details',
          //profile- personaldetails
          'FirstName_cant_be_empty': 'FirstName cant be empty',
          'FirstName_must_be_minimum_1_digits':
              'FirstName must be minimum 1 digits',
          'mobile_number': 'Mobile Number',
          'mobile_number_cant_be_empty': 'Mobile number cant be empty',
          'mobile_number_must_be_minimum_10_digits':
              'Mobile number must be minimum 10 digits',
          'email': 'Email',
          'gender': 'Gender',
          'others': 'Others',
          //profile-liceience

          'DL_number': 'DL_number',
          'DL_expiry_date': 'DL expiry ate',
          'Upload_driving_license_back': 'Upload driving license back',
          'Upload_driving_license_front': 'Upload driving license front',
          'upload_rc_back_side': 'Upload RC Back Side',
          'please_enter_license_number': 'Please Enter License Number',
          'please_enter_valid_driving_license':
              'Please Enter Valid Driving License',
          'update': 'Update',
          //profile-aadhar card

          'Aadhar_number': 'Aadhar number',
          'upload_Aadhar_back_side': 'Upload Aadhar Back side',
          'Upload_adhar_card_back': 'Upload Aadhar Back side',
          'Upload_adhar_card_front': 'Upload Aadhar Back side',

          //profile-editVechileRegister
          'please_enter_rc_number': 'Please Enter RC Number',
          'please_enter_valid_rc_number': 'Please Enter Valid Rc Number',

          //profile-pancard
          'PAN_number': 'PAN number',
          'pan_card': 'PAN Card',
          'Upload_Pan_card_front': 'Upload Pan Card Front',
          'please_enter_pancard_number': 'Please Enter Pancard Number',
          'please_enter_valid_pancard_number':
              'Please Enter Valid Pancard Number',

          //profile-bandetails
          'ifsc': 'IFSC',
          'please_enter_ifsc_number': 'please enter IFSC number',
          'please_enter_valid_ifsc_number': 'please enter valid IFSC number',
          'please_enter_upi_number': 'please enter UPI number',
          'Please_enter_valid_upi_number': 'Please Enter valid UPI number',

          //notifaction page
          'Notification': 'Notifications',
          //emergency contact
          'Emergency': 'Emergency Contact',
          //estimated fare
          'beyond_1km':
              'If the trip extends beyond 1KM,extra charges as $currencySymbol 9 per KM is applicableee',
          '1min_extra':
              'If the trip extends time,extra charges as $currencySymbol 2 per extra min applicable',
          'night_charge':
              'Night Charge $currencySymbol 300 on drives ending between 10:00PM & 05:59AM ',
          'final_fare':
              'Final Fare will be Charged basis actual distance and time',
          'cancellation_fee':
              'According to our Cancellation Policy,Charge of  $currencySymbol 300 on Cancellation ',

          //QR
          'Are_you_sure': 'Are you sure you want to continue?',
          'Recharge_with_QR':
              'Recharge your Wallet using below QR Code or UPI id',
          'Send_Screenshot':
              'Please Send the Screenshot of the completed payment to this whatsapp number: +91 7893653899',
          'Once_Confirmed': 'Once Payment is confirmed',
          'Subscription_Active': 'Your Subscription plan will be active',

          // Alert
          'Subscription_NotActive':
              'Alert! \nYour subscription is not active. Please subscribe to get rides',
        },

        // Hindi Language Starts Here
        'hi_in': {
          //carnumberscrren
          "enter_car_number": "कार नंबर दर्ज करें",
          "subscribe_now": "अब सदस्यता लें",
          "vehicle_gear_type": "वाहन गियर प्रकार",
          "manual": "मैनुअल",
          "automatic": "स्वचालित",
          "view_bill": "बिल देखें",
          "write_a_review_to_driver": "ग्राहक के बारे में समीक्षा लिखें",
          "Before_you_start_ride_please_selfie_along":
              "राइड शुरू करने से पहले कृपया सेल्फी लें",
          "with_car_number_plate": "कार नंबर प्लेट के साथ",
          "Please_be_ready_with_your_camera_and_clean_your_lens":
              "कृपया अपने कैमरे के साथ तैयार रहें और अपने लेंस को साफ करें",
          "take_photos_of_car": "कार की फोटो लें",
          "before_you_start_ride_please_take_selfies_&":
              "राइड शुरू करने से पहले कृपया सेल्फी लें",
          "before_you_end_ride_please_take_selfies_&":
              "राइड समाप्त करने से पहले कृपया सेल्फी लें",
          "verification": "सत्यापन",
          "car_number_Cant_Be_Empty": "कार नंबर खाली नहीं हो सकता",
          "your_Profile_Is_Under_Reviewing\nprocess._Please_Wait_2_To_4_Days":
              "आपकी प्रोफाइल की समीक्षा प्रक्रिया में है। कृपया 2 से 4 दिनों तक प्रतीक्षा करें",
          "accepted_rides": "स्वीकृत राइड",
          "available_rides": "उपलब्ध राइड",
          "prices_may_vary":
              "कृपया ध्यान दें कि मूल्य संरचना यात्रित हुए दूरी और समय से प्रभावित होती है।",
          "and_privacy_policy.": "चित्र स्पष्ट करें",
          "take_selfie": "सेल्फी लें",
          "from_the_front_angle.": "सामने की ओर से",
          "take_front_picture.": "सामने की ओर से तस्वीर लें",
          "before_you_start_ride_please_images_of_car":
              "राइड शुरू करने से पहले कृपया कार की तस्वीरें",
          "make_sure_that_picture_should_be_clear_and_detail.":
              "यह सुनिश्चित करें कि चित्र स्पष्ट और विवरण हों",
          "make_picture_clear.": "और गोपनीयता नीति।",
          "Pay_₹500_Joining_fees": "₹500 ज्वाइनिंग फीस भुगतान करें",
          "Joining_fees": "ज्वाइनिंग फीस",
          "by_submission_you_agree_to_our":
              "जमा करके आप हमारे से सहमत होते हैं",
          "terms_&_condition": "नियम और शर्तें",
          "by_submission_you_agree_to_our_terms_&_condition":
              "जमा करके आप हमारे से सहमत होते हैं नियम और शर्तें",
          "the_joining_fees _for_drivers_is_collected_to_cover_any_potential_damages,_violations,_orvunpaid_fees.":
              "ड्राइवर्स के लिए ज्वाइनिंग फीस किसी भी संभावित क्षति, उल्लंघन या अवैतनिक शुल्क को कवर करने के लिए वसूली जाती है।",
//EMERGENCY CONTACT

          "emergency_contact_details": "आपातकालीन संपर्क विवरण",
          "emergency_contacts": "आपातकालीन संपर्क",
          "Person": "व्यक्ति",
          "vehicle_types": "वाहन प्रकार",
          "relation_ship_can_not_be_empty": "संबंध खाली नहीं हो सकता",
          "name": "नाम",
          "name_can_not_be_empty": "नाम खाली नहीं हो सकता",
          "phone_number": "फोन नंबर",
          "relation_ship": "संबंध",
          "aadhar_number": "आधार नंबर",
          "Resend_Code": "कोड पुनः भेजें?",
          "earnings_by_orders": "आर्डर्स द्वारा कमाई",
          "Choose_your_ride": "अपनी राइड चुनें",
          "Choose_your_service": "अपनी सेवा चुनें",
          "Home": "होम",
          "confirm_your_cancellation": "अपनी रद्दीकरण की पुष्टि करें",
          "Once_you_cancel_your_ride_you_will_be_pay_fee_Rs_500_for_cancellations_as_per_our_policy":
              "अगर आप अपनी यात्रा रद्द करते हैं, तो हमारी नीति के अनुसार आपको रद्दीकरण के लिए रु. 500 शुल्क देना होगा।",
          "Driver_details": "ड्राइवर विवरण",
          "Address_details": "पता विवरण",
          "bill_details": "बिल विवरण",
          "Ride_status": "राइड स्थिति",
          "Ride": "राइड",
          "Loads": "भार",
          "Ride_now": "अब राइड करें",
          "Outstation": "बाहरी क्षेत्र",
          "Confirm_Ride": "राइड की पुष्टि करें",
          "Rentals": "किराया",
          "Bike_Car_Auto": "बाइक, कार, ऑटो",
          "Load_now": "अब लोड करें",
          "Outstation_service": "बाहरी क्षेत्र सेवा",
          "Rentals_service": "किराया सेवा",
          "More_with_Taxi_Go": "टैक्सी गो के साथ और अधिक!",
          "Pickup_point": "पिकअप प्वाइंट",
          "Dropping_point": "ड्रॉपिंग प्वाइंट",
          "Search_Destination": "गंतव्य खोजें",
          "Pick_Up_Date": "पिक अप तिथि",
          "Pick_Up_Time": "पिक अप समय",
          "Return_Date": "वापसी की तारीख",
          "Return_Time": "वापसी का समय",
          "Later": "बाद में",
          "Now": "अब",
          "Book_Ride": "राइड बुक करें",
          "Select_destination_location": "गंतव्य स्थान का चयन करें",
          "Select_Location": "स्थान चुनें",
          "My_favourite_locations": "मेरे पसंदीदा स्थान",
          "Find_a_place": "एक स्थान ढूँढें...",
          "Check_Location": "स्थान की जाँच करें",
          "we_are_unable_to_find_your_pincode_please_drag_the_place_picker":
              "हम आपके पिनकोड को खोजने में असमर्थ हैं, कृपया स्थान पिकर को खींचें",
          "Place_not_in_area": "स्थान क्षेत्र में नहीं है",
          "Select_Vehicle": "वाहन चुनें",
          "Select_Package": "पैकेज चुनें",
          "Please_wait": "कृपया प्रतीक्षा करें...",
          "Please_hold_we_are_searching_for":
              "कृपया प्रतीक्षा करें! हम आपके लिए खोज रहे हैं",
          "nearby_skipper_for_you": "आपके लिए निकटवर्ती स्किपर",
          "Cancel_Ride": "राइड रद्द करें",
          "Apply_Coupon_Code": "कूपन कोड लागू करें",
          "Pay_At_Drop": "ड्रॉप पर भुगतान करें",
          "Change_payment_Method": "भुगतान का तरीका बदलें",
          "Your_skipper_is_arriving": "आपका स्किपर आ रहा है",
          "Your_skipper_is_arrived": "आपका स्किपर पहुंच गया है",
          "Price": "कीमत",
          "Pay_now": "अभी भुगतान करें",
          "Don't_press_back_until_the_payment_is_completed":
              "भुगतान पूरा होने तक पीछे न जाएं",
          "i_agree_to_The": "मैं सहमत हूँ",
          "Contact_driver": "ड्राइवर से संपर्क करें",
          "Your_ride_is_started": "आपकी राइड शुरू हो गई है",
          "Skipper": "स्किपर",
          "Online_mode": "ऑनलाइन मोड",
          "Wallet_pay": "वॉलेट भुगतान",
          "Cash_mode": "नकद मोड",
          "OTP": "ओटीपी",
          "No": "नहीं",
          "submit": "प्रस्तुत",
          "Yes": "हाँ",
          "Estimate_fare": "अनुमान भाड़ा",
          "subscription_plan": "सदस्यता योजना",
          "Submit_your_rating": "अपनी रेटिंग सबमिट करें",
          "driver_prime_membership": "ड्राइवर प्राइम सदस्यता",
          "Give_Rating": "रेटिंग दें",
          "You_rated": "आपने रेटिंग दी है",
          "Are_you_sure_you_want_to_sign_out": "क्या आप निकासी करना चाहते हैं?",
          "Cancel": "रद्द करें",
          "OK": "ठीक है",
          "Logout_Failed": "लॉगआउट विफल रहा",
          "Please_retry": "कृपया पुनः प्रयास करें",
          "Favorites_Location": "पसंदीदा स्थान",
          "Choose_Language": "भाषा चुनें",
          "Emergency_Contact": "आपातकालीन संपर्क",
          "Logout": "लॉगआउट",
          "Amount": "रकम",
          "Ride_Status": "राइड स्थिति",
          "New_Request": "नया अनुरोध",
          "Ride_Booked": "राइड बुक किया गया",
          "Complete_Totally": "पूर्णत: पूर्ण",
          "Payment_Type": "भुगतान प्रकार",
          "email_cant_be_empty": "ईमेल खाली नहीं हो सकता",
          "please_enter_a_valid_email_address":
              "कृपया एक वैध ईमेल पता दर्ज करें",
          "Privacy_Policy": "गोपनीयता नीति",
          "Terms_&Conditions": "शर्तें और नियम",
          "Add_New": "नया जोड़ें",
          "TaxiGo": "टैक्सीगो",
          "Customer_Support": "ग्राहक सहायता",
          "Edit_Profile": "प्रोफ़ाइल संपादित करें",
          "collect_bill": "बिल जमा करें",
          "Full_name": "पूरा नाम",
          "Phone_Number": "फ़ोन नंबर",
          "Error_of_coupons": "कूपन त्रुटि",
          "No_rides_found": "कोई राइड नहीं मिली",
          "Select_Title": "शीर्षक चुनें",
          "Save_as_Favorites": "पसंदीदा के रूप में सहेजें",
          "Replace": "प्रतिस्थापित करें",
          "Please_choose_a_title_for_selected_address":
              "चयनित पते के लिए एक शीर्षक चुनें",
          "Title": "शीर्षक",
          "enter_title": "शीर्षक दर्ज करें",
          "Save": "सहेजें",
          "Delete": "हटाएँ",
          "Delete_Address": "पता हटाएँ",
          "Are_you_sure_you_want_to_delete_this_address":
              "क्या आप इस पते को हटाना चाहते हैं?",
          "Apply_Coupons": "कूपन लागू करें",
          "Date": "तारीख",
          "Ride_Id": "राइड आईडी",
          "Total_Amount": "कुल रकम",
          "Duration": "अवधि",
          "mins": "मिनट",
          "km": "किमी",
          "amount_cant_be_empty": "राशि खाली नहीं हो सकती",
          "Enter_amount": "राशि दर्ज करें",
          "Minimum_200_required_to_unlock_withdraw":
              "निकालने को अनलॉक करने के लिए कम से कम ₹200 की आवश्यकता है",
          "Submit": "प्रस्तुत",
          "Terms&_Condition": "शर्तें और नियम",
          "By_login_you_agree_to_our": "लॉगिन करके आप हमारे से सहमत होते हैं",
          "Date_of_birth": "जन्म तिथि",
          "Enter_valid_date": "वैध तारीख दर्ज करें",
          "Enter_date_in_valid_range": "वैध सीमा में तारीख दर्ज करें",
          "OTP_Verification": "ओटीपी सत्यापन",
          "Enter_the_4_digit_code_we_sent_you_to_verify_your_phone_number":
              "हमने आपको आपके फोन नंबर को सत्यापित करने के लिए भेजा हमारा 4 अंकों का कोड दर्ज करें",
          "send_to": "भेजें",
          "We_unable_to_get_your_Pincode":
              "हम आपके पिनकोड को प्राप्त करने में असमर्थ हैं",
          // Wallet
          "Wallet": "बटुआ",
          "All_Transactions": "सभी लेन-देन",
          "Select_Date": "तारीख चुनें",
          "Available_Balance": "उपलब्ध शेष",
          "select_location": "स्थान चुनें",
          "Active_Rides": "सक्रिय यात्राएँ",
          "Completed": "पूरा हुआ",
          "Cancelled": "रद्द किया गया",
          "Track_Rider": "राइडर का पता लगाएं",
          "Contact_Rider": "राइडर से संपर्क करें",
          "Payment_paid_from_wallet": "भुगतान बटुआ से किया गया",
          "Wait_for_payment": "भुगतान के लिए प्रतीक्षा करें",
          "your_uPI": "आपका UPI",
          "Also_notify_when_receiving_invites":
              "आमंत्रण प्राप्त करते समय सूचित भी करें",
          "Left_from_school": "स्कूल से निकल गया",
          "Hangouts_video_call": "हैंगआउट्स वीडियो कॉल",
          "Reached_at_school": "स्कूल पर पहुंचा",
          "When_driverpartner_reached_at_pickup_location":
              "जब ड्राइवर पार्टनर पिकअप स्थान पर पहुँचे",
          "Drop_Notifications": "नोटिफिकेशन ड्रॉप करें",
          "Pick_up_Notifications": "नोटिफिकेशन पिकअप करें",
          "When_trip_started_at_starting_point":
              "जब यात्रा शुरुआती स्थान पर शुरू हो",
          "Trip_start_Notifications": "यात्रा शुरू नोटिफिकेशन",
          "Settings": "सेटिंग्स",
          "privacy_policy": "गोपनीयता नीति",
          "terms_&_Condition": "नियम और शर्तें",
          "and": "और",
          "by_login_you_agree_to_our": "लॉग इन करके आप हमारे से सहमत होते हैं",
          "resend(30s)": "पुनः भेजें (30 सेकंड)",
          "don't_receive_the_code?": "कोड प्राप्त नहीं हो रहा है?",
          "Log_in": "लॉग इन करें",
          "OTP_length_did_not_match": "OTP लंबाई मेल नहीं खाती",
          "please_enter_OTP": "कृपया OTP दर्ज करें",
          "sent_to": "भेजा गया",

          //suport
          "support": "सहारा",
          "customer_support": "ग्राहक सहायता",
          "chat": "बात करना",
          //ride info
          "ride_info": "सवारी की जानकारी",
          'ride_id: ': 'सवारी आईडी: ',
          //rideDetails
          'cancel_ride': 'राइड रद्द करें',
          //payNow
          'please_Pay_The_Amount\nBefore_Contuning':
              'कृपया राशि का भुगतान करें\nआगे बढ़ने से पहले',
          'payout_details': 'भुगतान विवरण',
          'pay_now': 'अब भुगतान करें',
          'skip': 'छोड़ें',
          'payment_under_process': 'भुगतान प्रक्रियाधीन है',
          'please_Don’t_Go_Back_Or_Refresh_The_Page\nas_We_Are_Processing_Your_Payment':
              'कृपया वापस न जाएं या पेज को रीफ्रेश न करें\nक्योंकि हम आपका भुगतान संसाधित कर रहे हैं',
          //customerSupport
          'please_Select_Reason_For_Cancel_ride':
              'कृपया राइड रद्द करने का कारण चुनें',
          'unsafe_Pickup_area': 'असुरक्षित पिकअप क्षेत्र',
          'unable_To_Swipe_Arrived': 'स्वाइप करने में असमर्थ आ गया',
          'wrong_Pickup_Location': 'गलत पिकअप स्थान',
          'long_Pickup': 'लंबा पिकअप',
          'heavy_Traffic': 'भारी यातायात',
          //BackCollectedButton
          'back': 'पीछे',
          //RateCard
          'rate_card': 'दर पत्र',
          'monday_To_sunday': 'सोमवार से रविवार',
          'maximum_Payout_Limit_Is_₹500': 'अधिकतम भुगतान सीमा है ₹500',
          "bike": "बाइक",
          "auto": "ऑटो",
          //BikeInfo
          'base_Fare': 'बुनियादी भाड़ा',
          'minimum_Fare': 'न्यूनतम किराया',
          'earning_Per_km': 'आय प्रति किमी',
          'price_Per_Minute': 'मूल्य प्रति मिनट',
          'platform_Charge': 'प्लेटफॉर्म चार्ज',
          'pickup_extra_km_Fare_Post_2km':
              'पिकअप अतिरिक्त किमी किराया 2 किमी के बाद',
          '(Max_10)': '(मैक्स 10)',
          'every_Km_Till_8km': 'हर किमी 8 किमी तक',
          'Per_Km ': 'प्रति किमी ',
          'every_Km_Above_8km': '8 किमी से ऊपर हर किमी',
          //CollectPaymentView
          'collect_payment': 'भुगतान प्राप्त करें',
          'ride_iD: ': 'सवारी आईडी: ',
          "collect_amount": "राशि एकत्रित करें",
          'generate_qR_code': 'क्यूआर कोड जनरेट करें',
          'or': 'या',
          'collect_cash': 'कैश कलेक्ट करें',
          //CollectCash
          'collect_Cash_Form_The_Customer.': 'ग्राहक से नकद राशि लीजिए.',
          'collected': 'जुटाया हुआ।',
          //ChooseAppLanguageView
          'english': 'अंग्रेज़ी',
          'hindi': 'हिंदी',
          'kannada': 'कन्नडा',
          'telugu': 'तेलुगू',
          'tamil': 'तामिल',
          'gujarati': 'गुजराती',
          'app_language': 'ऐप भाषा',
          'set_language': 'भाषा सेट करें',

  'Privacy': 'गोपनीयता नीति',
  'Terms': 'शर्तें और नियम',
  'Cancellation': 'रद्दीकरण और वापसी नीति',
          //AddDetailsView
          'add_details': 'विवरण जोड़ें',
          'personal_Details': 'व्यक्तिगत विवरण',
          'vehicle_Details': 'वाहन की सूचना',
          'documents': 'दस्तावेज़',
          'bank_Details': 'बैंक विवरण',
          'i_Agree_to_The ': 'मैं इसके लिए सहमत हूँ ',
          'terms_&_conditions': 'नियम एवं शर्तें',
          'next': 'Next',
          //VehicleRegistration
          'vehicle_registration_card_(RC)': 'वाहन पंजीकरण कार्ड (आरसी)',
          'Vechile_numberVechile_number':
              'अपना वाहन पंजीकरण कार्ड (आरसी) अपलोड करें',
          'front_side': 'सामने की ओर',
          "camera": "कैमरा",
          "gallery": "गेलरी",
          'back_side': 'पीछे की ओर',
          'rC_number': 'आरसी नंबर',
          'rC_Number_Cant_Be_Empty': 'आरसी नंबर खाली नहीं हो सकता',
          'rC_Number_Must_be_Minimum_10_Characters':
              'आरसी नंबर कम से कम 10 कैरेक्टर का होना चाहिए',
          'enter_rC_number': 'आरसी नंबर दर्ज करें',
          'save': 'बचाना',
          //TakeYourSelfie
          'add_your_selfie': 'अपनी सेल्फी जोड़ेंe',
          'take_your_selfie': 'अपनी सेल्फी लो',
          'we_Use_Your_Selfie_To_Compare_With_Your_id':
              'हम आपकी आईडी के साथ तुलना करने के लिए आपकी सेल्फी का उपयोग करते हैं',
          'good_Lighting': 'अच्छी रोशनी',
          'make_Sure_You_Are_In_A_Well_Lit_Area_And_Both_Ears_Are_Uncovered ':
              'सुनिश्चित करें कि आप एक अच्छी तरह से रोशनी वाले क्षेत्र में हैं और दोनों कान खुले हुए हैं ',
          'look_Straight': 'सीधे देखना',
          'hold_Your_Phone_At_Eye_Level_And_Looks_Straight_To_The_Camera':
              'अपने फ़ोन को आंखों के स्तर पर पकड़ें और सीधे कैमरे की ओर देखें',
          'open_camera': 'कैमरा खोलो',
          'male': 'पुरुष',
          'female': 'महिला',
          'Others': 'अन्य',
          'month/date/year': 'माह/तारीख/वर्ष',
          'enter_Valid_Date': 'मान्य तिथि दर्ज करें',
          'enter_Date_In_Valid_Range': 'दिनांक मान्य श्रेणी में दर्ज करें',
          'personal_details': 'व्यक्तिगत विवरण',
          'first_name': 'पहला नाम',
          'firstName_Cant_Be_Empty': 'पहला नाम खाली नहीं हो सकता',
          'firstName_Must_Be_Minimum_1_Digits':
              'पहला नाम कम से कम 1 अंक का होना चाहिए',
          'full_name': 'पूरा नाम',
          'last_name': 'उपनाम',
          'lastName_Cant_Be_Empty': 'अंतिम नाम खाली नहीं हो सकता',
          'lastName_Must_Be_Minimum_1_Digits':
              'लास्टनाम कम से कम 1 अंक का होना चाहिए',
          'enter_mail_id': 'मेल आईडी दर्ज करें',
          'e-mail_Address': 'मेल पता',
          "invalid_email": "अमान्य ईमेल",
          'enter_date_Of_birth': 'जन्म तारीख दर्ज करें',
          'date_Of_Birth': 'जन्म की तारीख',
          'home_address': 'घर का पता',
          'home_addres_Cant_Be_Empty': 'घर का पता खाली नहीं हो सकता',
          'home_addres_Must_Be_Minimum_1_Digits':
              'घर का पता न्यूनतम 1 अंक का होना चाहिए',
          'enter_home_address': 'घर का पता दर्ज करें',
          'city': 'शहर',
          'city_Cant_Be_Empty': 'शहर खाली नहीं हो सकता',
          'city_Must_Be_Minimum_1_Digits': 'शहर न्यूनतम 1 अंक का होना चाहिए',
          'enter_City': 'शहर का नाम दर्ज करें',
          'state ': 'राज्य ',
          'state_Cant_Be_Empty': 'राज्य का नाम खाली नहीं हो सकता',
          'state_Must_Be_Minimum_1_Digits':
              'राज्य कम से कम 1 अंक का होना चाहिए',
          'enter_State': 'राज्य का नाम  दर्ज करें',
          'pincode': 'पिन कोड',
          'pincode_Cant_Be_Empty': 'पिनकोड खाली नहीं हो सकता',
          'pincode_Must_Be_Minimum_6_Digits':
              'पिनकोड कम से कम 6 अंकों का होना चाहिए',
          'enter_Pincode': 'पिनकोड दर्ज करें',
          //PanCard
          'pAN_card': 'पैन कार्ड',
          'upload_your_pAN_card': 'अपना पैन कार्ड अपलोड करें',
          'pAN_number': 'PAN Number',
          'pAN_Number_Can_Not_Be_Empty.': 'पैन नंबर खाली नहीं हो सकता.',
          'enter_pAN_number': 'पैन नंबर दर्ज करें',
          //VechileSelection
          'job_details': 'नौकरी विवरण',
          'which_Vehicle_Will_You_Use?': 'आप कौन सा वाहन प्रयोग करेंगे?',
          'vehicle_type': 'वाहन का प्रकार',
          'electric': 'विद्युत',
          'non-electric': 'गैर विद्युत',
          //DrivingLicense
          'driving_license': 'ड्राइविंग लाइसेंस',
          'upload_your_driving_license': 'अपना ड्राइविंग लाइसेंस अपलोड करें',
          'learner’s_License_Not_Allowed.': 'लर्नर लाइसेंस की अनुमति नहीं है.',
          'driving_license_number': 'ड्राइविंग लाइसेंस संख्या',
          'driving_License_Cant_Be_Empty':
              'ड्राइविंग लाइसेंस खाली नहीं हो सकता',
          'driving_License_Must_Be_Minimum_16_Characters':
              'ड्राइविंग लाइसेंस न्यूनतम 16 वर्णों का होना चाहिए',
          'expiry_date': 'समाप्ति तिथि',
//Documents
          'upload_All_documents,_required_For_Your_Verification.':
              'आपके सत्यापन के लिए आवश्यक सभी दस्तावेज़ अपलोड करें.',
          'aadhar_card': 'आधार कार्ड',
          //Demo
          'membership_For_45_Days': '45 दिनों के लिए सदस्यता',
          'free': 'मुफ़्त',
          '10_Days_Left': '10 दिन शेष',
//BankDetails
          'enter_A_Valid_iFSC_Number.': 'एक मान्य IFSC नंबर दर्ज करें.',
          'add_your_bank_details': 'अपना बैंक विवरण जोड़ें',
          'account_holder_name': 'खाता धारक का नाम',
          'enter_bankholder_name_Cant_Be_Empty':
              'बैंकधारक का नाम दर्ज करें खाली नहीं हो सकता',
          'enter_bankholder_name_Must_Be_Minimum_3_Characters':
              'बैंकधारक का नाम दर्ज करें कम से कम 3 अक्षर होने चाहिए',
          'enter_Bank_Holder_Name': 'बैंक धारक का नाम दर्ज करें',
          'account_Number': 'Account number',
          'account_Number_Cant_Be_Empty': 'खाता संख्या खाली नहीं हो सकती',
          'account_Number_Must_Be_9_To_17_Digits':
              'खाता संख्या 9 से 17 अंकों की होनी चाहिए',
          'iFSC_Code': 'IFSC कोड',
          'ifsc_Code_Can_Not_Be_Empty.': 'IFSC कोड खाली नहीं हो सकता.',
          'enter_Valid_Ifsc_Code': 'वैध आईएफएससी कोड दर्ज करें',
          'enter_Ifsc_Code': 'IFSC कोड दर्ज करें',
          'bank_name': 'बैंक का नाम',
          'bank_Name_Can_Not_Be_Empty.': 'बैंक का नाम खाली नहीं हो सकता.',
          'enter_bank_Name': 'बैंक का नाम दर्ज करें',
          'add_your_uPI': 'आपका जोड़ें UPI',
          'uPI': 'UPI',
          'uPI_Id_Can_Not_Be_Empty.': 'UPI ID खाली नहीं हो सकती.',
//AdharCard
          'upload_Your_Aadhar_Card': 'अपना आधार कार्ड अपलोड करें',
          'aadhar_Number': 'आधार संख्या',
          'aadhar_number_Cant_Be_Empty': 'आधार संख्या खाली नहीं हो सकती',
          'aadhar_number_Must_Be_12_Digits':
              'आधार संख्या 12 अंकों की होनी चाहिए',
//LoginPageView
          "login ": "लॉग इन करें ",
          "mobile_number ": "मोबाइल नंबर ",
          "mobile_Number_Can't_Be_Empty": "मोबाइल नंबर खाली नहीं हो सकता",
          "mobile_Number_Must_Be_10_Digits":
              "मोबाइल नंबर 10 अंकों का होना चाहिए",
          'enter_Mobile_Number': 'मोबाइल नंबर दर्ज करें',
          'login': 'लॉग इन करें',
//NotificationView
          "clear": "साफ़ करे",
          "start_your_first_ride_with_winter_Offers.":
              "विंटर ऑफ़र के साथ अपनी पहली राइड शुरू करें.",
          "happy_winter_offer_On_Your_first_ride,_enjoy_ride_With_best_offers._check_It_Now":
              "आपकी पहली राइड पर हैप्पी विंटर ऑफर, बेस्ट ऑफर्स के साथ राइड का मजा लें। अब यह जांच करें",
          "2_Days_Ago": "2 दिन पहले",
//OrderCompletedView
          'ride_completed': 'सवारी पूरी हुई',
          'great_job': 'अच्छा काम!',
          'ride_successfully_completed': 'सवारी सफलतापूर्वक पूरी हुई',
          'total_Distance : ': 'कुल दूरी : ',
          'total_Ride_Time : ': 'कुल सवारी का समय : ',
          'amount : ': 'राशि : ',
          'ready_for_next_order': 'अगले आदेश के लिए तैयार',
          //ProfileReview
          ' rejected': ' अस्वीकार कर दिया',
          'please_Contact_Admin_Support':
              'कृपया व्यवस्थापक समर्थन से संपर्क करें',
          "  your_Profile_Is_Under_Reviewing\nprocess._Please_Wait_2_To_4_Days":
              "  आपकी प्रोफ़ाइल समीक्षाधीन है\nप्रक्रियाधीन है। कृपया 2 से 4 दिन प्रतीक्षा करें",
//ReferAndEarnView
          "refer_&_earn": "उद्घृत करो और कमाएँ",
          "refer_friends": "मित्र को उद्घृत करे",
          "earn_Upto_₹50_Per_Friend_You_Invite":
              "आप जिस दोस्त को बुलाते हैं उससे ₹50 तक कमाएं",
          "my_rewards": "मेरे पुरस्कार",
          "share_Your_Invite_Code": "अपना आमंत्रण कोड साझा करें",
          "when_Your_Friends_Sign_Up_This_Referral":
              "जब आपके मित्र इस रेफरल को साइन अप करते हैं",
          "Code,_You_Can_Received_A_Free_Ride":
              "कोड, आप एक मुफ्त सवारी प्राप्त कर सकते हैं",
          'refer': 'उद्घृत करो',
//ReferalCodeView
          'hello,_skipper': 'हैलो, स्किपर',
          'your_Account_Will_Be_Registered_With_This_Mobile_Number':
              'आपका खाता इस मोबाइल नंबर के साथ पंजीकृत हो जाएगा',
          "have_a_referral_code?": "रेफरल कोड है?",
          'enter_referral_code': 'रेफरल कोड दर्ज करें',
          'referal_Code_Must_Be_5_Digits': 'रेफ़रल कोड 5 अंकों का होना चाहिए',
//ReviewsView
          'rating_&_reviews': 'रेटिंग और समीक्षा',
          "rating": "रेटिंग",

//RideHistoryView
          'ride_history': 'सवारी इतिहास',
          'training_tutorials': 'प्रशिक्षण ट्यूटोरियल्स',
          'today': 'आज',
          "all": "सभी",
          "completed": "पूरा हुआ",
          "rejected": "अस्वीकार कर दिया",

          //RideHistoryCard
          'online_paid ': 'ऑनलाइन भुगतान किया',
          'yesterday': 'बीता हुआ कल',
          'week': 'सप्ताह',
          'custom': 'रीति',

          'Personal_Details': 'व्यक्तिगत विवरण',
          //homepage drawer
          'earnings': 'आय',
          'subscription': 'सदस्यता',
          'order_history': 'आदेश इतिहास',
          'rating_reviews': 'रेटिंग और समीक्षा',
          'notifications': 'सूचनाएं',
          'refer_earn': 'उद्घृत करो और कमाएँ',
          //homepage earningcard
          'enable_location_to_get_nearby_rides':
              'आस-पास की सवारी प्राप्त करने के लिए स्थान सक्षम करें',
          'enable_location': 'स्थान सक्षम करें',
          'todays_earnings': 'आज की कमाई',
          'cash_collected': 'नकद एकत्रित',
          //homepage flutterripplewidget
          'go_online': 'ऑनलाइन जाओ',
          //homepage currentlyofflinecard
          'offine_message':
              'आप वर्तमान में ऑफ़लाइन हैं, कृपया\nकमाई शुरू करने के लिए ऑनलाइन जाएं',
          //homepage RoutingBooking
          'my_route_booking': 'माई रूट बुकिंग',
          //riplepage widget
          'offline': 'ऑफलाइन',
          'online': 'ऑनलाइन',
          //riplepage widget AccetedOrderCard
          'pickup': 'उठाना',
          'min_away': 'मिनट दूर',
          'reject': 'अस्वीकार',
          "accept_ride": 'सवारी स्वीकार करें',
          'arrived': 'पहुँचा',
          'complete_ride': 'पूरी सवारी',
          'ride_id:': 'सवारी आईडी:',
          'enter_otp': 'ओटीपी दर्ज करें',
          'please_ask_otp_to_the_Customer': 'कृपया ग्राहक से ओटीपी पूछें',
          'otp_length_didn\'t_match': 'ओटीपी की लंबाई मेल नहीं खाती',
          'start_ride': 'राइड शुरू करें',
          'Go_to_drop_Location': 'ड्रॉप लोकेशन पर जाएं',
          'go_to_pick_up': 'लेने जाओ',
          //earningpage
          'today’s_earning': 'आज की कमाई',
          'payout': 'भुगतान',
          'history': 'इतिहास',
          //today earning
          'rides': 'सवारी',
          'Km': 'किमी',
          'hours': 'घंटे',
          'avg_rating': 'औसत रेटिंग',
          'reject_rides': 'सवारी अस्वीकार करें',
          'today\'s_earning': 'आज की कमाई',
          "order_id :": 'आदेश ID :',
          //payout
          'online_collection': 'ऑनलाइन संग्रह',
          'amount_to_Pay': 'भुगतान की जाने वाली राशि',
          'total_collected_cash': 'कुल एकत्रित नकद',
          'tax_charges': 'कर प्रभार',
          'gst_payable_to_the_government.': 'सरकार को देय जी.एस.टी.',
          'platform_charge': 'प्लेटफॉर्म चार्ज',
          'outstation_rides': 'आउटस्टैटिन सवारी',
          'Daily_one_time_fee.': 'दैनिक एक बार शुल्क.',
          'transaction_fees': 'लेनदेन शुल्क',
          'Towards_unavoidable_costs_for\noperating_the_app':
              'ऐप को संचालित करने के लिए अपरिहार्य लागतों की ओर',
          'payable_amount': 'भुगतान योग्य राशि',
          'maximum_payout_limit_is ': 'अधिकतम भुगतान सीमा है ',
          'please_pay_below-charges': 'कृपया नीचे शुल्क का भुगतान करें',
          'Immediately': 'तुरंत',
          'total_earnings': 'कुल आय',
          'rides)': 'सवारी)',
          //ride earning details
          'ride_details': 'सवारी विवरण',
          'time_fare ': 'समय किराया ',
          'distance_fare ': 'दूरी किराया ',
          'surge': 'तरंग',
          'your_earnings': 'आपकी कमाई',
          // ride details
          'ride_id': 'सवारी आईडी',
          'date': 'तारीख',
          'distance': 'दूरी',
          'Mins': 'मिनट',
          'duration': 'अवधि',
          'pickup_location': 'उठाने की जगह',
          'drop_location': 'ड्रॉप स्थान',
          //ride details-total rechargrcard
          'ride_amount': 'सवारी राशि',
          'amount_pay_to_company': 'कंपनी को राशि का भुगतान',
          //profile
          'profile': 'प्रोफ़ाइल',
          'vehicle': 'वाहन',
          'bank_details': 'बैंक विवरण',
          //profile- personaldetails
          'FirstName_cant_be_empty': 'पहला नाम खाली नहीं हो सकता',
          'FirstName_must_be_minimum_1_digits':
              'पहला नाम कम से कम 1 अंक का होना चाहिए',
          'mobile_number': 'मोबाइल नंबर',
          'mobile_number_cant_be_empty': 'मोबाइल नंबर खाली नहीं हो सकता',
          'mobile_number_must_be_minimum_10_digits':
              'मोबाइल नंबर कम से कम 10 अंकों का होना चाहिए',
          'email': 'ईमेल',
          'gender': 'लिंग',
          'others': 'अन्य',
          //profile-liceience
          'upload_rc_back_side': 'आरसी बैक साइड अपलोड करें',
          'please_enter_license_number': 'कृपया लाइसेंस संख्या दर्ज करें',
          'please_enter_valid_driving_license':
              'कृपया वैध ड्राइविंग लाइसेंस दर्ज करें',
          'update': 'अद्यतन',

          'please_enter_rc_number': 'कृपया आरसी संख्या दर्ज करें',
          'please_enter_valid_rc_number': 'कृपया मान्य आरसी संख्या दर्ज करें',
          //profile-aadharcard

          //profile-pancard
          'please_enter_pancard_number': 'कृपया पैनकार्ड संख्या दर्ज करें',
          'please_enter_valid_pancard_number':
              'कृपया मान्य पैनकार्ड संख्या दर्ज करें',

          //profile-bandetails
          'ifsc': 'आईएफ़एससी',
          'please_enter_ifsc_number': 'कृपया IFSC नंबर दर्ज करें',
          'please_enter_valid_ifsc_number': 'कृपया मान्य IFSC नंबर दर्ज करें',
          'please_enter_upi_number': 'कृपया यूपीआई नंबर दर्ज करें',
          'Please_enter_valid_upi_number': 'कृपया मान्य यूपीआई नंबर दर्ज करें',

          // QR
          "Are_you_sure": "क्या आप निश्चित हैं कि आप जारी रखना चाहते हैं?",
          "Recharge_with_QR":
              "नीचे QR कोड या UPI आईडी का उपयोग करके अपना वॉलेट रिचार्ज करें",
          "Send_Screenshot":
              "कृपया पूर्ण भुगतान की स्क्रीनशॉट को इस व्हाट्सएप नंबर पर भेजें: +91 7893653899",
          "Once_Confirmed": "एक बार भुगतान पुष्टि होने के बाद",
          "Subscription_Active": "आपकी सब्सक्रिप्शन योजना सक्रिय हो जाएगी",

          // Alert
          'Subscription_NotActive':
              'Alert! \nआपकी सदस्यता सक्रिय नहीं है। कृपया राइड प्राप्त करने के लिए सदस्यता लें।'
        },

        // Telegu Language Starts Here
        'tl_in': {
          //carnumberscrren
          "enter_car_number": "కారు సంఖ్య ఎంటర్ చేయండి",
          "subscribe_now": "ఇప్పుడు చందాను చేరుకోండి",
          "vehicle_gear_type": "వాహన గేర్ రకం",
          "manual": "మేన్యువల్",
          "automatic": "స్వయంచాలక",
          "view_bill": "బిల్ వీక్షించు",
          "write_a_review_to_driver": "కస్టమర్ గురించి సమీక్ష రాయండి",
          "Before_you_start_ride_please_selfie_along":
              "రైడ్ ప్రారంభించుటకు ముందుగా సెల్ఫీ తీసుకోండి",
          "with_car_number_plate": "కారు నంబర్ ప్లేట్‌తో",
          "Please_be_ready_with_your_camera_and_clean_your_lens":
              "దయచేసి మీ కెమెరా తయారు చేసుకోండి మరియు మీ లెన్స్‌ను శుభ్రం చేయండి",
          "take_photos_of_car": "కారు చిత్రాలు తీసుకోండి",
          "before_you_start_ride_please_take_selfies_&":
              "రైడ్ ప్రారంభించుటకు ముందుగా సెల్ఫీలను తీసుకోండి &",
          "before_you_end_ride_please_take_selfies_&":
              "రైడ్ ముగించే ముందు సెల్ఫీలను తీసుకోండి &",
          "verification": "ధృవీకరణ",
          "car_number_Cant_Be_Empty": "కారు సంఖ్య ఖాళీ ఉండకూడదు",
          "your_Profile_Is_Under_Reviewing\nprocess.Please_Wait_2_To_4_Days":
              "మీ ప్రొఫైల్ రివ్యూ ప్రాసెస్ కంప్లీట్ అయ్యేలా ఉంది. దయచేసి 2 నుండి 4 రోజుల సమయం ప్రతీక్షించండి",
          "accepted_rides": "అంగీకృత రైడ్‌లు",
          "available_rides": "అందుబాటులో రైడ్‌లు",
          "prices_may_vary":
              "దయచేసి గమనించండి మూల్య వర్గీకరణం దూరం మరియు సమయం ఆధారంగా ప్రభావితం కావచ్చు",
          "and_privacy_policy.": "చిత్రం స్పష్టం చేయండి",
          "take_selfie": "సెల్ఫీ తీసుకొను",
          "from_the_front_angle.": "ముందు కోణం నుండి",
          "take_front_picture.": "ముందు చిత్రం తీసుకొను",
          "before_you_start_ride_please_images_of_car":
              "రైడ్ ప్రారంభించుటకు కారు చిత్రాలు తీసుకొను",
          "make_sure_that_picture_should_be_clear_and_detail.":
              "దయచేసి చిత్రం స్పష్టం మరియు వివరాలు ఉండాలని ఖచ్చితం చేయండి",
          "make_picture_clear.": "మరియు గోప్యతా విధానం.",
          "Pay_₹500_Joining_fees": "₹500 చేరడానికి ఫీజు చెల్లించండి",
          "Joining_fees": "చేరడానికి ఫీజు",
          "by_submission_you_agree_to_our":
              "మార్గదర్శకాలు & నిబంధనలు తప్పక గొట్టించినట్లుగా అంగీకరిస్తారు",
          "terms&condition": "నిబంధనలు & షరతులు",
          "by_submission_you_agree_to_our_terms&_condition":
              "మార్గదర్శకాలు & నిబంధనలు తప్పక గొట్టించినట్లుగా అంగీకరిస్తారు",
          "the_joining_fees _for_drivers_is_collected_to_cover_any_potential_damages,_violations,_orvunpaid_fees.":
              "డ్రైవర్‌ల కోసం జోడింపు శుల్కాలు ఏదైనా సంభవితంగా కొట్టడానికి, ఉల్లంఘనాలని కవర్ చేయడానికి లక్షిస్తారు.",

          //EMERGENCY CONTACT

          "emergency_contact_details": "ఎమర్జెన్సీ సంప్రదించండి వివరాలు",
          "emergency_contacts": "ఎమర్జెన్సీ కాంటాక్ట్‌లు",
          "Person": "వ్యక్తి",
          "vehicle_types": "వాహన రకాలు",
          "relation_ship_can_not_be_empty": "సంబంధం ఖాళీ ఉండకూడదు",
          "name": "పేరు",
          "name_can_not_be_empty": "పేరు ఖాళీ ఉండకూడదు",
          "phone_number": "ఫోన్ నంబర్",
          "relation_ship": "సంబంధం",
          "aadhar_number": "ఆధార్ సంఖ్య",
          "Resend_Code": "కోడ్‌ను రీసెండ్ చేయండి?",
          "earnings_by_orders": "ఆర్డర్ల ద్వారా ఆదాయం",
          "Choose_your_ride": "మీ రైడ్‌ను ఎంచుకోండి",
          "Choose_your_service": "మీ సేవను ఎంచుకోండి",
          "Home": "హోమ్",
          "confirm_your_cancellation": "మీ రద్దు ధృడీకరణను నిర్ధారించండి",
          "Once_you_cancel_your_ride_you_will_be_pay_fee_Rs_500_for_cancellations_as_per_our_policy":
              "మీ రైడ్ రద్దు చేసినా, మేము మీరు మా విధివతికి సరిపోయేందుకు రూ. 500 ఫీజు చెల్లించవచ్చు.",
          "Driver_details": "డ్రైవర్ వివరాలు",
          "Address_details": "చిరునామా వివరాలు",
          "bill_details": "బిల్ వివరాలు",
          "Ride_status": "రైడ్ స్థితి",
          "Ride": "రైడ్",
          "Loads": "లోడ్స్",
          "Ride_now": "ఇప్పుడు రైడ్",
          "Outstation": "ఔట్‌స్టేషన్",
          "Confirm_Ride": "రైడ్ నిర్ధారించండి",
          "Rentals": "రెంటల్‌లు",
          "Bike_Car_Auto": "బైక్, కార్, ఆటో",
          "Load_now": "ఇప్పుడు లోడ్",
          "Outstation_service": "ఔట్‌స్టేషన్ సేవ",
          "Rentals_service": "రెంటల్‌ల సేవ",
          "More_with_Taxi_Go": "టాక్సీ గోతో మరిన్ని!",
          "Pickup_point": "పికప్ పాయింట్",
          "Dropping_point": "డ్రాపింగ్ పాయింట్",
          "Search_Destination": "గమనిక సేర్చ్ చేయండి",
          "Pick_Up_Date": "పిక్ అప్ తేదీ",
          "Pick_Up_Time": "పిక్ అప్ సమయం",
          "Return_Date": "రిటర్న్ తేదీ",
          "Return_Time": "రిటర్న్ సమయం",
          "Later": "తరువాత",
          "Now": "ఇప్పుడు",
          "Book_Ride": "బుక్ రైడ్",
          "Select_destination_location": "గమనిక స్థలాన్ని ఎంచుకోండి",
          "Select_Location": "స్థానాన్ని ఎంచుకోండి",
          "My_favourite_locations": "నా ఇష్టమైన స్థలాలు",
          "Find_a_place": "ఒక స్థానం కనుగొనండి ...",
          "Check_Location": "స్థానం తనిఖీ చేయండి",
          "we_are_unable_to_find_your_pincode_please_drag_the_place_picker":
              "మేము మీ పిన్‌కోడ్ కనుగొనలేము, దయచేసి స్థలం పిక్‌అప్ చేయండి",
          "Place_not_in_area": "స్థలం ప్రాంతంలో లేదు",
          "Select_Vehicle": "వాహనాన్ని ఎంచుకోండి",
          "Select_Package": "పాకేజీని ఎంచుకోండి",
          "Please_wait": "దయచేసి ఎదురుచూస్తుండం ...",
          "Please_hold_we_are_searching_for":
              "దయచేసి ఉండండి! మేము మీకు సమీపంలో స్కిప్‌పర్ కోసం శోధిస్తున్నాం",
          "nearby_skipper_for_you": "మీకు సమీపంలో స్కిప్‌పర్",
          "Cancel_Ride": "రైడ్ రద్దు",
          "Apply_Coupon_Code": "కూపన్ కోడ్ వాడుక",
          "Pay_At_Drop": "డ్రాప్‌లో చెల్లించండి",
          "Change_payment_Method": "చెల్లించడానికి చెల్లించండి పద్దతి",
          "Your_skipper_is_arriving": "మీ స్కిప్‌పర్ వస్తున్నాడు",
          "Your_skipper_is_arrived": "మీ స్కిప్‌పర్ వచ్చింది",
          "Price": "మొత్తం ధర",
          "Pay_now": "ఇప్పుడు చెల్లించండి",
          "Don't_press_back_until_the_payment_is_completed":
              "చెల్లింపు పూర్తి అయ్యింది వరకూ బ్యాక్ నొక్కడానికి ప్రత్యేకంగా నొక్కండి.",
          "i_agree_to_The": "నేను అంగీకరిస్తున్నాను",
          "Contact_driver": "డ్రైవర్‌ను సంప్రదించండి",
          "Your_ride_is_started": "మీ రైడ్ ప్రారంభించబడింది",
          "Skipper": "స్కిప్‌పర్",
          "Online_mode": "ఆన్‌లైన్ మోడ్",
          "Wallet_pay": "వాలెట్ చెల్లించు",
          "Cash_mode": "నగదు మోడ్",
          "OTP": "ఓటిపి",
          "No": "లేదు",
          "submit": "సమర్పించు",
          "Yes": "అవును",
          "Estimate_fare": "అంచనా ధర",
          "subscription_plan": "చందా ప్రణాళిక",
          "Submit_your_rating": "మీ రేటింగ్‌ను సమర్పించండి",
          "driver_prime_membership": "డ్రైవర్ ప్రధాన సభ్యత",
          "Give_Rating": "రేటింగ్ ఇస్తుంది",
          "You_rated": "మీరు రేట్ చేసారు",
          "Are_you_sure_you_want_to_sign_out": "మీరు నిష్క్రమణ చేయాలా?",
          "Cancel": "రద్దు",
          "OK": "సరే",
          "Logout_Failed": "లాగ్ఔట్ విఫలమైంది",
          "Please_retry": "దయచేసి మళ్ళి ప్రయత్నించండి",
          "Favorites_Location": "ఇష్టమైన స్థానం",
          "Choose_Language": "భాషను ఎంచుకోండి",
          "Emergency_Contact": "ఎమర్జెన్సీ సంప్రదించండి",
          "Logout": "లాగ్‌అవుట్",
          "Amount": "మొత్తం",
          "Ride_Status": "రైడ్ స్థితి",
          "New_Request": "కొత్త అభ్యర్థన",
          "Ride_Booked": "రైడ్ బుక్ చేయబడింది",
          "Complete_Totally": "పూర్తిగా పూర్తి చేయండి",
          "Payment_Type": "చెల్లింపు రకం",
          "email_cant_be_empty": "ఇమెయిల్ ఖాళీ ఉండకూడదు",
          "please_enter_a_valid_email_address":
              "దయచేసి చెల్లని ఇమెయిల్ చిరునామా నమోదు చేయండి",
          "Privacy_Policy": "గోప్యతా విధానం",
          "Terms_&_Conditions": "షరతులు మరియు పన్నులు",
          "Add_New": "కొత్తది జోడించు",
          "TaxiGo": "టాక్సీగో",
          "Customer_Support": "గ్రాహక మద్దతు",
          "Edit_Profile": "ప్రొఫైల్‌ను సవరించండి",
          "collect_bill": "బిల్‌ను సేకరించు",
          "Full_name": "పూర్తి పేరు",
          "Phone_Number": "ఫోన్ నంబర్",
          "Error_of_coupons": "కూపన్‌ల దోషం",
          "No_rides_found": "రైడ్‌లు కనుగొనబడలేదు",
          "Select_Title": "శీర్షికను ఎంచుకోండి",
          "Save_as_Favorites": "అనుకూలంగా భద్రపరచండి",
          "Replace": "మార్పు",
          "Please_choose_a_title_for_selected_address":
              "ఎంచుకున్న చిరునామాకు శీర్షికను ఎంచుకోండి",
          "Title": "శీర్షిక",
          "enter_title": "శీర్షిక నమోదు చేయండి",
          "Save": "భద్రపరచు",
          "Delete": "తొలగించు",
          "Delete_Address": "చిరునామా తొలగించు",
          "Are_you_sure_you_want_to_delete_this_address":
              "మీరు ఈ చిరునామాను తొలగించాలా?",
          "Apply_Coupons": "కూపన్‌లను వాడుక",
          "Date": "తేదీ",
          "Ride_Id": "రైడ్ ఐడి",
          "Total_Amount": "మొత్తం మొత్తం",
          "Duration": "అవధి",
          "mins": "నిమి",
          "km": "కి.మీ",
          "amount_cant_be_empty": "మొత్తం ఖాళీ ఉండకూడదు",
          "Enter_amount": "మొత్తం నమోదు చేయండి",
          "Minimum_200_required_to_unlock_withdraw":
              "విడ్డండికి అన్‌లాక్ చేయడానికి కనీసం ₹200 అవసరం",
          "Submit": "సమర్పించు",
          "Terms_&_Condition": "షరతులు మరియు పన్నులు",
          "By_login_you_agree_to_our":
              "లాగిన్ చేస్తే మీరు మాకు అంగీకరిస్తున్నారు",
          "Date_of_birth": "పుట్టిన తేదీ",
          "Enter_valid_date": "చెల్లని తేదీ నమోదు చేయండి",
          "Enter_date_in_valid_range": "చెల్లని పరిమితిలో తేదీ నమోదు చేయండి",
          "OTP_Verification": "ఓటిపి పరిశీలన",
          "Enter_the_4_digit_code_we_sent_you_to_verify_your_phone_number":
              "మీ ఫోన్ నంబర్ ధ్రువీకరించడానికి మేము మీకు పంపిన 4 అంకి కోడ్‌ను నమోదు చేయండి",
          "send_to": "పంపించు",
          "We_unable_to_get_your_Pincode": "మేము మీ పిన్‌కోడ్‌ను పొందలేము",
          "Wallet": "వాలెట్",
          "All_Transactions": "అన్నీ లావాదేవీలు",
          "Select_Date": "తేదీ ఎంచుకోండి",
          "Available_Balance": "అందుబాటులో సంతోషం",

          "select_location": "స్థానం ఎంచుకోండి",

          "Active_Rides": "సక్రియ ప్రయాణాలు",
          "Completed": "పూర్తి",
          "Cancelled": "రద్దు చేయబడింది",
          "Track_Rider": "రైడర్ ట్రాక్",
          "Contact_Rider": "రైడర్ తో సంప్రదించండి",

          "Payment_paid_from_wallet": "వాలెట్ నుండి చెల్లించిన చెల్లించింది",
          "Wait_for_payment": "చెల్లించడానికి ఎదురు",
          "your_uPI": "మీ UPI",

          "Also_notify_when_receiving_invites":
              "ఆమంత్రణలను స్వీకరిస్తున్నప్పుడు సమాచారం ఇవ్వండి",

          "Left_from_school": "పాఠశాలను నుండి వద్దు",
          "Hangouts_video_call": "హాంగ్ అవుట్స్ వీడియో కాల్",
          "Reached_at_school": "పాఠశాలకు చేరాను",
          "Drop_Notifications": "డ్రాప్ నోటిఫికేషన్‌లు",
          "When_driverpartner_reached_at_pickup_location":
              "డ్రైవర్ పార్టనర్ పికప్ స్థానానికి చేరుకున్నప్పుడు",
          "Pick_up_Notifications": "పిక్ అప్ నోటిఫికేషన్‌లు",
          "When_trip_started_at_starting_point":
              "ప్రయాణం ప్రారంభ స్థానంలో ప్రారంభమైనప్పుడు",
          "Trip_start_Notifications": "ట్రిప్ ప్రారంభ నోటిఫికేషన్‌లు",
          "Settings": "సెట్టింగులు",

          "privacy_policy": "గోప్యతా విధానం",
          "terms_&_Condition": "షరతులు & పన్నులు",
          "and": "మరియు",
          "by_login_you_agree_to_our":
              "లాగిన్ చేస్తే మీరు మాకు అంగీకరిస్తున్నారు",
          "resend(30s)": "మళ్లీ పంపు (30 సెకన్లు)",
          "don't_receive_the_code?": "కోడ్ అందుకోలేదా?",
          "Log_in": "లాగిన్",
          "OTP_length_did_not_match": "OTP పొడవు సరిచూ లేదు",
          "please_enter_OTP": "దయచేసి OTP నమోదు చేయండి",
          "sent_to": "పంపబడింది",

          //suport
          "support": "మద్దతు",

          "customer_support": "गవినియోగదారుని మద్దతు",
          "chat": "చాట్",
          //ride info
          "ride_info": "రైడ్ సమాచారం",
          'ride_id: ': 'రైడ్ ID',
          //rideDetails
          'cancel_ride': 'రైడ్ రద్దు',
          //payNow
          'please_Pay_The_Amount\nBefore_Contuning':
              'దయచేసి_మొత్తం_చెల్లించండి\nకొనసాగడానికి ముందు',
          'payout_details': 'చెల్లింపు వివరాలు',
          'pay_now': 'ఇప్పుడు చెల్లించండి',
          'skip': 'దాటవేయండి',
          'payment_under_process': 'చెల్లింపు ప్రక్రియలో ఉంది',
          'please_Don’t_Go_Back_Or_Refresh_The_Page\nas_We_Are_Processing_Your_Payment':
              'దయచేసి_వెనుక_వెళ్లి_లేదా_పేజీ_రిఫ్రెష్_ చేయవద్దు\nమేము_మీ_చెల్లింపును_ప్రాసెస్ చేస్తున్నాముं',
          //customerSupport
          'please_Select_Reason_For_Cancel_ride':
              'దయచేసి రైడ్_రద్దుకు_కారణాన్ని_ఎంచుకోండి',
          'unsafe_Pickup_area': 'అసురక్షిత_పికప్_ఏరియా',
          'unable_To_Swipe_Arrived': 'స్వైప్ చేయడం అసమర్థం',
          'wrong_Pickup_Location': 'చెల్లించబడిన పికప్ స్థానం',
          'long_Pickup': 'అంతా దూరం పికప్',
          'heavy_Traffic': 'భారీ ట్రాఫిక్',
//BackCollectedButton
          'back': 'వెనక్కి',
//RateCard
          'rate_card': 'రేట్ కార్డ్',
          'monday_To_sunday': 'సోమవార నుండి ఆదివారం',
          'maximum_Payout_Limit_Is_₹500': 'అత్యంత పొడవు పొడవు లిమిట్ ₹500',
          "bike": "బైక్",
          "auto": "ఆటో",
          //BikeInfo
          'base_Fare': 'బేస్ ఫేర్',
          'minimum_Fare': 'కనిష్ఠ రేటు',
          'earning_Per_km': 'కిలోమీటరు కొలచాడు',
          'price_Per_Minute': 'ప్రతి నిమిషం ధర',
          'platform_Charge': 'ప్లాట్‌ఫారం ఛార్జీ',
          'pickup_extra_km_Fare_Post_2km':
              '2 కిమీ తర్వాత పికప్ అదనపు కిలోమీటరు ధర',
          '(Max_10)': '(గరిష్టం 10)',
          'every_Km_Till_8km': '8 కిమీ లో ప్రతి కిమీ',
          'Per_Km ': 'ప్రతి కిమీ ',
          'every_Km_Above_8km': '8 కిమీ కంటే మీరి ప్రతి కిమీ',
//CollectPaymentView
          'collect_payment': 'చెల్లించండి',
          'ride_iD: ': 'సైకిల్ ఐడి: ',
          "collect_amount": "మొత్తం సేకరించండి",
          'generate_qR_code': 'QR కోడ్ రూపొందించండి',
          'or': 'లేదా',
          'collect_cash': 'నగదు సేకరించండి',
//CollectCash
          'collect_Cash_Form_The_Customer.': 'గ్రాహకి నుండి నగదు సేకరించండి.',
          'collected': 'సేకరించబడింది.',
          //ChooseAppLanguageView
          'english': 'ఆంగ్లం',
          'hindi': 'హిందీ',
          'kannada': 'కన్నడ',
          'telugu': 'తెలుగు',
          'tamil': 'తమిళ',
          'gujarati': 'గుజరాతి',
          'app_language': 'యాప్ భాష',
          'set_language': 'భాష సెట్ చేయండి',

          'Privacy': 'గోప్యత',
          'Terms': 'షరతులు & ప్రమాణాలు',
          'Cancellation': 'రద్దు & రిఫండ్ విధానం',
//AddDetailsView
          'add_details': 'వివరాలు జోడించండి',
          'personal_Details': 'వ్యక్తిగత వివరాలు',
          'vehicle_Details': 'వాహన వివరాలు',
          'documents': 'పత్రాలు',
          'bank_Details': 'బ్యాంక్ వివరాలు',
          'i_Agree_to_The ': 'నాకు అంగీకారం ',
          'terms_&_conditions': 'నిబంధనలు మరియు షరతులు',
          'next': 'తరువాయి',
//VehicleRegistration
          'vehicle_registration_card_(RC)': 'వాహన నమోదు కార్డ్ (ఆర్సీ)',
          'Vehile_numberVechile_number':
              'మీ వాహన నమోదు కార్డ్ (ఆర్సీ) అప్‌లోడ్ చేయండి',
          'front_side': 'ముందు భాగం',
          "camera": "కెమెరా",
          "gallery": "గ్యాలరీ",
          'back_side': 'తిరస్కరించిన భాగం',
          'rC_number': 'ఆర్సీ సంఖ్య',
          'rC_Number_Cant_Be_Empty': 'ఆర్సీ సంఖ్య ఖాళీ ఉండలేదు',
          'rC_Number_Must_be_Minimum_10_Characters':
              'ఆర్సీ సంఖ్య 10 అక్షరాల కంటే కమ్మి ఉండాలి',
          'enter_rC_number': 'ఆర్సీ సంఖ్యను ఎంటర్ చేయండి',
          'save': 'భద్రపరచు',
          //TakeYourSelfie
          'add_your_selfie': 'మీ సెల్ఫీని జోడించండి',
          'take_your_selfie': 'మీ సెల్ఫీ తీసుకోండి',
          'we_Use_Your_Selfie_To_Compare_With_Your_id':
              'మేము మీ ID తో తులనం చేయడానికి మీ సెల్ఫీని ఉపయోగిస్తాము',
          'good_Lighting': 'మంచి లైటింగ్',
          'make_Sure_You_Are_In_A_Well_Lit_Area_And_Both_Ears_Are_Uncovered ':
              'మీరు ఒక మంచి లైటింగ్ ఉన్న ప్రదేశంలో ఉన్నారు మరియు రెండు చెవిలు ఆవరించబడకలేదు',
          'look_Straight': 'సీధా చూస్కోండి',
          'hold_Your_Phone_At_Eye_Level_And_Looks_Straight_To_The_Camera':
              'మీ ఫోన్‌ను కణ్ణీరు స్థాయిలో ఉంచి మరియు కెమెరాకు సీధా చూస్కోండి',
          'open_camera': 'కెమెరా తెరువు',
          'male': 'పురుషుడు',
          'female': 'మహిళ',
          'Others': 'ఇతరాలు',
          'month/date/year': 'నెల/తేది/సంవత్సరం',
          'enter_Valid_Date': 'చెందినండి చెందిన తేది',
          'enter_Date_In_Valid_Range': 'చెందినండి చెందిన శ్రేణిలో ఉండండి',
          'personal_details': 'వ్యక్తిగత వివరాలు',
          'first_name': 'మొదటి పేరు',
          'firstName_Cant_Be_Empty': 'మొదటి పేరు ఖాళీ ఉండకండి',
          'firstName_Must_Be_Minimum_1_Digits':
              'మొదటి పేరు కనిష్టమే 1 అంకోసం ఉండాలి',
          'full_name': 'పూర్తి పేరు',
          'last_name': 'చివరి పేరు',
          'lastName_Cant_Be_Empty': 'చివరి పేరు ఖాళీ ఉండకండి',
          'lastName_Must_Be_Minimum_1_Digits':
              'చివరి పేరు కనిష్టమే 1 అంకోసం ఉండాలి',
          'enter_mail_id': 'మెయిల్ ఐడి నమోదు చేయండి',
          'e-mail_Address': 'ఇ-మెయిల్ చిరునామా',
          "invalid_email": "చెల్లింపులో ఉన్న ఇమెయిల్",
          'enter_date_Of_birth': 'జన్మ తేది నమోదు చేయండి',
          'date_Of_Birth': 'పుట్టిన తేది',
          'home_address': 'ఇంటి చిరునామా',
          'home_addres_Cant_Be_Empty': 'ఇంటి చిరునామా ఖాళీ ఉండకండి',
          'home_addres_Must_Be_Minimum_1_Digits':
              'ఇంటి చిరునామా కనిష్టమే 1 అంకోసం ఉండాలి',
          'enter_home_address': 'ఇంటి చిరునామా నమోదు చేయండి',
          'city': 'నగరం',
          'city_Cant_Be_Empty': 'నగరం ఖాళీ ఉండకండి',
          'city_Must_Be_Minimum_1_Digits': 'నగరం కనిష్టమే 1 అంకోసం ఉండాలి',
          'enter_City': 'నగరం నమోదు చేయండి',
          'state ': 'రాష్ట్రం',
          'state_Cant_Be_Empty': 'రాష్ట్రం ఖాళీ ఉండకండి',
          'state_Must_Be_Minimum_1_Digits': 'రాష్ట్రం కనిష్టమే 1 అంకోసం ఉండాలి',
          'enter_State': 'రాష్ట్రం నమోదు చేయండి',
          'pincode': 'పిన్‌కోడ్',
          'pincode_Cant_Be_Empty': 'పిన్‌కోడ్ ఖాళీ ఉండకండి',
          'pincode_Must_Be_Minimum_6_Digits':
              'పిన్‌కోడ్ కనిష్టమే 6 అంకోసం ఉండాలి',
          'enter_Pincode': 'పిన్‌కోడ్ నమోదు చేయండి',
          //PanCard
          'pAN_card': 'పాన్ కార్డ్',
          'upload_your_pAN_card': 'మీ పాన్ కార్డ్‌ను అప్‌లోడ్ చేయండి',
          'pAN_number': 'PAN నంబర్',
          'pAN_Number_Can_Not_Be_Empty.': 'PAN నంబర్ ఖాళీ ఉండకండి.',
          'enter_pAN_number': 'PAN నంబర్‌ను నమోదు చేయండి',
//VechileSelection
          'job_details': 'ఉద్యోగ వివరాలు',
          'which_Vehicle_Will_You_Use?':
              'మీరు ఎంచుకోవడానికి ఎంత వాహనం ఉపయోగించిపోతారు?',
          'vehicle_type': 'వాహనం రకం',
          'electric': 'విద్యుత్',
          'non-electric': 'అవిద్యుత్',
          //DrivingLicense
          'driving_license': 'డ్రైవింగ్ లైసెన్స్',
          'upload_your_driving_license':
              'మీ డ్రైవింగ్ లైసెన్స్ అప్‌లోడ్ చేయండి',
          'learner’s_License_Not_Allowed.': 'నేరాలు లైసెన్స్ అనుమతి లేదు.',
          'driving_license_number': 'డ్రైవింగ్ లైసెన్స్ నంబర్',
          'driving_License_Cant_Be_Empty': 'డ్రైవింగ్ లైసెన్స్ ఖాళీ ఉండకూడదు',
          'driving_License_Must_Be_Minimum_16_Characters':
              'డ్రైవింగ్ లైసెన్స్ కనీసం 16 అక్షరాలు ఉండాలి',
          'expiry_date': 'కాలాంతర తేదీ',
          //Documents
          'upload_All_documents,_required_For_Your_Verification.':
              'మీ ధృవీకరణకు అవసరమైన అన్ని పత్రాలను అప్‌లోడ్ చేయండి.',
          'aadhar_card': 'ఆధార్ కార్డు',
          //Demo
          'membership_For_45_Days': '45 రోజుల సభ్యత',
          'free': 'ఉచితం',
          '10_Days_Left': '10 రోజులు ముగిసినవి',
          //BankDetails
          'enter_A_Valid_iFSC_Number.':
              'ఒక చెల్లించబడిన iFSC సంఖ్య నమోదు చేయండి.',
          'add_your_bank_details': 'మీ బ్యాంక్ వివరాలను చేర్చండి',
          'account_holder_name': 'ఖాతా హోల్డర్ పేరు',
          'enter_bankholder_name_Cant_Be_Empty':
              'బ్యాంక్‌హోల్డర్ పేరు ఖాళీ ఉండకూడదు',
          'enter_bankholder_name_Must_Be_Minimum_3_Characters':
              'బ్యాంక్‌హోల్డర్ పేరు కనీసం 3 అక్షరాలు ఉండాలి',
          'enter_Bank_Holder_Name': 'బ్యాంక్ హోల్డర్ పేరు నమోదు చేయండి',
          'account_Number': 'ఖాతా సంఖ్య',
          'account_Number_Cant_Be_Empty': 'ఖాతా సంఖ్య ఖాళీ ఉండకూడదు',
          'account_Number_Must_Be_9_To_17_Digits':
              'ఖాతా సంఖ్య 9 నుండి 17 అంకెల మధ్య ఉండాలి',
          'iFSC_Code': 'iFSC కోడ్',
          'ifsc_Code_Can_Not_Be_Empty.': 'iFSC కోడ్ ఖాళీ ఉండకూడదు.',
          'enter_Valid_Ifsc_Code': 'చెల్లని iFSC కోడ్ నమోదు చేయండి',
          'enter_Ifsc_Code': 'iFSC కోడ్ నమోదు చేయండి',
          'bank_name': 'బ్యాంక్ పేరు',
          'bank_Name_Can_Not_Be_Empty.': 'బ్యాంక్ పేరు ఖాళీ ఉండకూడదు.',
          'enter_bank_Name': 'బ్యాంక్ పేరు నమోదు చేయండి',
          'add_your_uPI': 'మీ UPI జోడించండి',
          'uPI': 'UPI',
          'uPI_Id_Can_Not_Be_Empty.': 'UPI ID ఖాళీ ఉండకండి.',
          //AdharCard
          'upload_Your_Aadhar_Card': 'మీ ఆధార్ కార్డును అప్‌లోడ్ చేయండి',
          'aadhar_Number': 'ఆధార్ నంబర్',
          'aadhar_number_Cant_Be_Empty': 'ఆధార్ నంబర్ ఖాళీ ఉండకండి',
          'aadhar_number_Must_Be_12_Digits': 'ఆధార్ నంబర్ 12 అంకెల ఉండాలి',
//LoginPageView
          "login ": "లాగిన్ చేయండి ",
          "mobile_number ": "మొబైల్ నంబర్ ",
          "mobile_Number_Can't_Be_Empty": "మొబైల్ నంబర్ ఖాళీ ఉండకండి",
          "mobile_Number_Must_Be_10_Digits": "మొబైల్ నంబర్ 10 అంకెల ఉండాలి",
          'enter_Mobile_Number': 'మొబైల్ నంబర్ నమోదు చేయండి',
          'login': 'లాగిన్',
//NotificationView
          "clear": "తిరిగి నివేదించండి",
          "start_your_first_ride_with_winter_Offers.":
              "వింటర్ ఆఫర్లతో మీ మొదటి రైడ్‌ను ప్రారంభించండి.",
          "happy_winter_offer_On_Your_first_ride,_enjoy_ride_With_best_offers._check_It_Now":
              "మీ మొదటి రైడ్‌పై హ్యాపీ వింటర్ ఆఫర్, బెస్ట్ ఆఫర్లతో రైడ్ చేస్తే ఆనందించండి. ఇప్పుడే తనిఖీ చేయండి",
          "2_Days_Ago": "2 రోజుల క్రితం",
//OrderCompletedView
          'ride_completed': 'రైడ్ పూర్తి',
          'great_job': 'బాగా చేసారు!',
          'ride_successfully_completed': 'రైడ్ యశస్వినిచ్చింది',
          'total_Distance : ': 'మొత్తం దూరం : ',
          'total_Ride_Time : ': 'మొత్తం రైడ్ సమయం : ',
          'amount : ': 'మొత్తం : ',
          'ready_for_next_order': 'తదుపరి ఆర్డర్ కోసం సిద్ధం',
//ProfileReview
          ' rejected': ' తిరస్కరించబడింది',
          'please_Contact_Admin_Support':
              'దయచేసి అడ్మిన్ మద్దతుకు సంప్రదించండి',
          "  your_Profile_Is_Under_Reviewing\nprocess._Please_Wait_2_To_4_Days":
              "  మీ ప్రొఫైల్ సమీక్షించబడుతోంది\nప్రక్రియలోనిది. దయచేసి 2 నుండి 4 రోజులకం వేచి ఉండండి",
          //ReferAndEarnView
          "refer_&_earn": "రిఫర్ అండ్ ఎర్న్",
          "refer_friends": "స్నేహితుని రిఫర్ చేయండి",
          "earn_Upto_₹50_Per_Friend_You_Invite":
              "మీరు ఆమంత్రిత చేసే ప్రతి స్నేహితుకు ₹50 వరకు సంపాదించవచ్చు",
          "my_rewards": "నా ప్రతిఫలాలు",
          "share_Your_Invite_Code": "మీ ఆమంత్రణ కోడ్‌ను భాగస్వామ్యం చేయండి",
          "when_Your_Friends_Sign_Up_This_Referral":
              "మీ స్నేహితులు ఈ రిఫరల్ ను సైన్ అప్ చేస్తే",
          "Code,_You_Can_Received_A_Free_Ride":
              "కోడ్, మీరు ఉచిత రైడ్ అంగీకరిస్తారు",
          'refer': 'సూచించండి',
//ReferalCodeView
          'hello,_skipper': 'హలో, స్కిపర్',
          'your_Account_Will_Be_Registered_With_This_Mobile_Number':
              'మీ ఖాతా ఈ మొబైల్ నంబర్‌తో నమోదు అవుతుంది',
          "have_a_referral_code?": "రిఫరల్ కోడ్ ఉందా?",
          'enter_referral_code': 'రిఫరల్ కోడ్ నమోదు చేయండి',
          'referal_Code_Must_Be_5_Digits': 'రిఫరల్ కోడ్ 5 అంకెల ఉండాలి',
//ReviewsView
          'rating_&_reviews': 'రేటింగ్ & సమీక్షలు',
          "rating": "రేటింగ్",
//RideHistoryView
          'training_tutorials': 'శిక్షణ ట్యుటోరియల్స్',
          'ride_history': 'రైడ్ చరిత్ర',
          'today': 'ఈ రోజు',
          "all": "అందరూ",
          "completed": "పూర్తయింది",
          "rejected": "తిరస్కరించబడింది",

          //RideHistoryCard
          'online_paid ': 'ఆన్ లైన్ చెల్లింపు',
          'yesterday': 'నిన్న',
          'week': 'వారం',
          'custom': 'ఆచారం',
          'Personal_Details': 'వ్యక్తిగత వివరాలు',
//homepage drawer
          'subscription': 'చందాదారిక',
          'earnings': 'సంపాదించడం',
          'order_history': 'క్రమ చరిత్ర',
          'rating_reviews': 'రేటింగ్ మరియు సమీక్ష',
          'notifications': 'ప్రకటన',
          'refer_earn': 'సంపాదించడాన్ని రిఫర్ చేయండి',
          //homepage earningcard
          'enable_location_to_get_nearby_rides':
              'స్థానాన్ని చేసుకొనడానికి స్థానాన్ని అనుమతించండి',
          'enable_location': 'లొకేషన్ ఎనేబుల్ చేయండి',
          'todays_earnings': 'ఈ రోజు ఆదాయం',
          'cash_collected': 'నగదు సంగ్రహించబడింది',
//homepage flutterripplewidget
          'go_online': 'ఆన్‌లైన్‌కి వెళ్ళండి',
          //homepage currentlyofflinecard
          'offine_message':
              'మీరు ప్రస్తుతం ఆఫ్ లైన్ లో ఉన్నారు, దయతో\nసంపాదన కోసం ఆన్ లైన్ కు వెళ్లండి',
          //homepage RoutingBooking
          'my_route_booking': 'నా రూట్ బుకింగ్',
          //riplepage widget
          'offline': 'ఆఫ్ లైన్',
          'online': 'ఆన్‌లైన్',
          //riplepage widget AccetedOrderCard
          'pickup': 'పికప్',
          'min_away': 'కనిష్టమిషం దూరం',
          'reject': 'నిరాకరించు',
          "accept_ride": 'ప్రయాణాన్ని అంగీకరించండి',
          'arrived': 'వచ్చేసింది',
          'complete_ride': 'పూర్తి రైడ్',
          'ride_id:': 'రైడ్ ఐడి:',
          'enter_otp': 'ఓటిపి ఎంటర్ చేయండి',
          'please_ask_otp_to_the_Customer': 'దయచేసి కస్టమర్ కు -OTP అడగండి',
          'otp_length_didn\'t_match': 'oTP సరిపోలలేదు',
          'start_ride': 'రైడ్ ప్రారంభించండి',
          'Go_to_drop_Location': 'లొకేషన్ డ్రాప్ చేయడానికి వెళ్లండి',
          'go_to_pick_up': 'పికప్ కు వెళ్లండి',
          //earningpage
          'today’s_earning': 'నేటి సంపాదన',
          'payout': 'చెల్లింపు',
          'history': 'చరిత్ర',

          //today earning
          'rides': 'సవారులు',
          'Km': 'కి.మీ.',
          'hours': 'గంటలు',
          'avg_rating': 'సగటు రేటింగ్',
          'reject_rides': 'సవారిలను తిరస్కరించు',
          'today\'s_earning': 'ఈ రోజు సంపాదించిన ధనం',
          "order_id :": 'ఆర్డర్ ID :',
//payout
          'online_collection': 'ఆన్‌లైన్ కలెక్షన్',
          'amount_to_Pay': 'చెల్లింపు మొత్తం',
          'total_collected_cash': 'మొత్తం కలెక్టెడ్ క్యాష్',
          'tax_charges': 'పన్ను ధరలు',
          'gst_payable_to_the_government.': 'ప్రభుత్వానికి చెల్లింపు చేయవచ్చు.',
          'platform_charge': 'ప్లాట్‌ఫారం ఛార్జీ',
          'outstation_rides': 'అవాస్తవ సవారులు',
          'Daily_one_time_fee.': 'డేలీ ఒక సమయం ఫీ.',
          'transaction_fees': 'లావాదేవీ ధరలు',
          'Towards_unavoidable_costs_for\noperating_the_app':
              'యాప్ యాపరేటింగ్ కోసం అటువంటి ఖర్చులకు',
          'payable_amount': 'చెల్లింపు చేయవచ్చే మొత్తం',
          'maximum_payout_limit_is ': 'అధికంగా చెల్లింపు పరిమితి ',
          'please_pay_below-charges': 'దయచేసి క్రింద చెల్లింపులను చెల్లించండి',
          'Immediately': 'తక్షణమే',
          'total_earnings': 'మొత్తం ఆదాయం',
          'rides)': 'సవారులు)',
//ride earning details
          'ride_details': 'సవారి వివరాలు',
          'time_fare ': 'సమయ కిరాయ',
          'distance_fare ': 'దూరం కిరాయ',
          'surge': 'తరంగా',
          'your_earnings': 'మీ ఆదాయం',
// ride details
          'ride_id': 'సవారి ID',
          'date': 'తేదీ',
          'distance': 'దూరం',
          'Mins': 'నిమిషాలు',
          'duration': 'వర్తన',
          'pickup_location': 'పికప్ స్థానం',
          'drop_location': 'డ్రాప్ స్థానం',
//ride details-total rechargrcard
          'ride_amount': 'సవారి మొత్తం',
          'amount_pay_to_company': 'కంపెనీకి చెల్లించే మొత్తం',
          //profile
          'profile': 'ప్రొఫైల్',

          'vehicle': 'వాహనం',
          'bank_details': 'బ్యాంకు వివరాలు',
          //profile- personaldetails
          'FirstName_cant_be_empty': 'పొరపాటు పేరు ఖాళీ ఉండకూడదు',
          'FirstName_must_be_minimum_1_digits':
              'పొరపాటు పేరు కనిష్ఠమైన 1 అంకం ఉండాలి',
          'mobile_number': 'మొబైల్ నంబర్',
          'mobile_number_cant_be_empty': 'మొబైల్ నంబర్ ఖాళీ ఉండకూడదు',
          'mobile_number_must_be_minimum_10_digits':
              'మొబైల్ నంబర్ కనిష్ఠమైన 10 అంకాలు ఉండాలి',
          'email': 'ఇమెయిల్',
          'gender': 'లింగం',
          'others': 'ఇతర',
//profile-liceience
          'upload_rc_back_side': 'ఆర్సీ బ్యాక్ సైడ్ అప్‌లోడ్ చేయండి',
          'please_enter_license_number': 'దయచేసి లైసెన్స్ నంబర్ నమోదు చేయండి',
          'please_enter_valid_driving_license':
              'దయచేసి మాన్యమైన డ్రైవింగ్ లైసెన్స్ నమోదు చేయండి',
          'update': 'నవీకరించు',

          'please_enter_rc_number': 'దయచేసి ఆర్సీ సంఖ్య నమోదు చేయండి',
          'please_enter_valid_rc_number':
              'దయచేసి మాన్యమైన ఆర్సీ సంఖ్య నమోదు చేయండి',
//profile-aadharcard

//profile-pancard
          'please_enter_pancard_number':
              'దయచేసి పాన్‌కార్డ్ నంబర్ నమోదు చేయండి',
          'please_enter_valid_pancard_number':
              'దయచేసి మాన్యమైన పాన్‌కార్డ్ నంబర్ నమోదు చేయండి',

//profile-bandetails
          'ifsc': 'ఐఎఫ్‌ఎస్సి',
          'please_enter_ifsc_number': 'దయచేసి IFSC నంబర్ నమోదు చేయండి',
          'please_enter_valid_ifsc_number':
              'దయచేసి మాన్యమైన IFSC నంబర్ నమోదు చేయండి',
          'please_enter_upi_number': 'దయచేసి UPI నంబర్ నమోదు చేయండి',
          'Please_enter_valid_upi_number':
              'దయచేసి మాన్యమైన UPI నంబర్ నమోదు చేయండి',

          // QR
          "Are_you_sure": "మీరు ఖచ్చితంగా కొనసాగాలనుకుంటున్నారా?",
          "Recharge_with_QR":
              "క్రింద ఉన్న QR కోడ్ లేదా UPI ఐడి ఉపయోగించి మీ వాలెట్‌ను రీచార్జ్ చేయండి",
          "Send_Screenshot":
              "దయచేసి పూర్తి చెల్లించిన చెల్లింపు స్క్రీన్‌షాట్‌ను ఈ వాట్సాప్ సంఖ్యకు పంపండి: +91 7893653899",
          "Once_Confirmed": "భుగతానం ఖచ్చితంగా సమర్పించబడితే",
          "Subscription_Active": "మీ చందా ప్రణాళి సక్రియం అవుతుంది",

          //Alert
          'Subscription_NotActive':
              'Alert! \nమీ చందాదారి సక్రియం కాదు. రైడ్‌లు పొందడానికి దయచేసి సభ్యత్వం పొందండి'
        },
      };
}
// <<< END    class LanguageTranslations

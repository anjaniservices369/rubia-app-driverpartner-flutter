// @dart=2.9
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/providers/background_locator.dart';
import 'package:base_project_flutter/providers/earningsProvider.dart';
import 'package:base_project_flutter/providers/globalFunctionProvider.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/providers/locationProvider.dart';
import 'package:base_project_flutter/providers/notifactionProvider.dart';
import 'package:base_project_flutter/providers/themeProvider.dart';
import 'package:base_project_flutter/views/joiningfees/joining%20_fees.dart';
import 'package:base_project_flutter/views/locationError/locationError.dart';
import 'package:base_project_flutter/views/onBoardingpage/onBoardingPage.dart';
import 'package:base_project_flutter/views/profile_review/profile_review.dart';
import 'package:base_project_flutter/views/rider_Details/add_Details.dart';
import 'package:base_project_flutter/views/translate.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'constants/imageConstant.dart';
import 'views/rider_details/componants/bank_details.dart';
import 'views/rider_details/componants/documents/documents.dart';
import 'views/rider_details/componants/emergency_Contacts.dart';
import 'views/rider_details/componants/personal_Details.dart';
import 'views/rider_details/componants/vehicle_Types.dart';

//
bool personalDetails = false;
bool isEmergencyContactDetails = false;
bool isVehicleTypes = false;
bool isDocumentsVerification = false;
bool isBankDetails = false;
bool isAllDetailsFilled = false;
bool isPaidJoiningFee = false;
var isProfileVerified;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.notification} ');
}

AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await initialize(); // Ensure you have defined or imported the 'initialize' function
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var authCode = sharedPreferences.getString('authCode');
  var checkAuth = '1';
  var checkMail;

  if (authCode != null) {
    var check = await UserAPI().checkApi(authCode);
    print("authCode>>>>> " + authCode);
    print(check);
    print("CheckAuthcode");
    if (check != null && check['status'] == 'OK') {
      if (check['detail']['email'] != null) {
        checkMail = '2';
        checkAuth = '1';
        personalDetails = check['detail']['personal_details'];
        isEmergencyContactDetails = check['detail']['driver_emergency_contacts'];
        isVehicleTypes = check['detail']['driver_vehicle_types'];
        isDocumentsVerification = check['detail']['document_verification'];
        isBankDetails = check['detail']['driver_bank_details'];
        isAllDetailsFilled = check['detail']['all_submit'];
        isPaidJoiningFee = check['detail']['is_paid_joining_fee'];
        isProfileVerified = check['detail']['profile_verified'];
        print("CheckMail");
        print(checkMail);
      } else {
        checkMail = null;
        print("CheckMail");
        print(checkMail);
      }
    } else {
      checkAuth = '';
    }
  } else {
    checkAuth = '';
  }

  sharedPreferences.remove('service_type');
  pref.remove('serviceType');
  print("checkAuth>>>>> " + checkAuth);

  runApp(
    MyApp(
      checkAuth: checkAuth,
      personalDetails: personalDetails,
      isEmergencyContactDetails: isEmergencyContactDetails,
      isVehicleTypes: isVehicleTypes,
      isDocumentsVerification: isDocumentsVerification,
      isBankDetails: isBankDetails,
      isAllDetailsFilled: isAllDetailsFilled,
      isPaidJoiningFee: isPaidJoiningFee,
      isProfileVerified: isProfileVerified,
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  const MyApp({
    Key key,
    this.checkAuth,
    this.personalDetails,
    this.isEmergencyContactDetails,
    this.isVehicleTypes,
    this.isDocumentsVerification,
    this.isBankDetails,
    this.isAllDetailsFilled,
    this.isPaidJoiningFee,
    this.isProfileVerified,
  }) : super(key: key);

  final checkAuth;
  final personalDetails;
  final isEmergencyContactDetails;
  final isVehicleTypes;
  final isDocumentsVerification;
  final isBankDetails;
  final isAllDetailsFilled;
  final isPaidJoiningFee;
  final isProfileVerified;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<GlobalFunctionProvider>(
          create: (context) => GlobalFunctionProvider(),
        ),
        ChangeNotifierProvider<HomePageProvider>(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (context) => LocationProvider(),
        ),
        ChangeNotifierProvider<EarningsProvider>(
          create: (context) => EarningsProvider(),
        ),
        ChangeNotifierProvider<MyNotifactionProvider>(
          create: (context) => MyNotifactionProvider(),
        ),
        ChangeNotifierProvider<BackgroundLocationProvider>(
          create: (context) => BackgroundLocationProvider(),
        ),
      ],
      child: Sizer(builder: (context, orientation, screenType) {
        return GetMaterialApp(
          color: tPrimaryColor,
          title: 'Rubia Driver',
          defaultTransition: Transition.native,
          translations: LanguageTranslations(),
          locale: const Locale('en', "US"),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.muliTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.blue,
          ),
          home: AnimatedSplashScreen(
            duration: 1000,
            splash: Image.asset(Images.DRIVERLOGO),
            splashIconSize: 300,
            nextScreen: widget.checkAuth == null || widget.checkAuth == ''
                ? OnboardingPage()
                : personalDetails == false
                    ? PersonalDetails()
                    : isEmergencyContactDetails == false
                        ? EmergencyContact()
                        : isVehicleTypes == false
                            ? VechileSelection()
                            : isDocumentsVerification == false
                                ? Documents()
                                : isBankDetails == false
                                    ? BankDetails()
                                    : isAllDetailsFilled == false
                                        ? AddDetailsView()
                                        : isPaidJoiningFee == false
                                            ? JoiningFees()
                                            : isProfileVerified != profile_verified_yes
                                                ? ProfileReview()
                                                : LocationErrorScreen(),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white,
          ),
          // localizationsDelegates:  [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          supportedLocales: const [
            Locale('en', 'US'),
          ],
        );
      }),
    );
  }
}

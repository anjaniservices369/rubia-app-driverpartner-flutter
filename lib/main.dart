// ----------------------------------------------------------------------
// App entry point
//
// Starts the driver app: sets up push notifications, checks whether the
// driver is already logged in, and decides which screen to show first
// (login, the next unfinished registration step, or the home screen).
//
// Developer note: Routing order is in MyApp.build. Contains MyHttpOverrides
// which accepts ANY TLS certificate - remove before release.
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// App entry point
//
// Starts the driver app: sets up push notifications, checks whether the
// driver is already logged in, and decides which screen to show first
// (login, the next unfinished registration step, or the home screen).
//
// Developer note: Routing order is in MyApp.build. The saved language is
// re-applied here (see _savedLocale). MyHttpOverrides (accepts any TLS
// certificate) is installed in DEBUG builds only.
// ----------------------------------------------------------------------
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/api_services/pushService.dart';
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
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/joiningfees/joining%20_fees.dart';
import 'package:base_project_flutter/views/location_popup_page.dart';
import 'package:base_project_flutter/views/onBoardingpage/onBoardingPage.dart';
import 'package:base_project_flutter/views/profile_review/profile_review.dart';
import 'package:base_project_flutter/views/rider_Details/add_Details.dart';
import 'package:base_project_flutter/views/translate.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
import 'globalFuctions/globalFunctions.dart';
import 'views/rider_details/componants/bank_details.dart';
import 'views/rider_details/componants/documents/documents.dart';
import 'views/rider_details/componants/emergency_Contacts.dart';
import 'views/rider_details/componants/personal_Details.dart';
import 'views/rider_details/componants/vehicle_Types.dart';
import 'dart:io';

//
bool personalDetails = false;
bool isEmergencyContactDetails = false;
bool isVehicleTypes = false;
bool isDocumentsVerification = false;
bool isBankDetails = false;
bool isAllDetailsFilled = false;
bool isPaidJoiningFee = false;
var isProfileVerified;

AndroidNotificationChannel? channel;
AndroidNotificationChannel? channel1;
AndroidNotificationChannel? channel2;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
// >>> START  main()  -  app entry point
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Debug builds only: lets the app talk to a local self-signed test server.
  // Release builds keep normal HTTPS certificate checking.
  if (kDebugMode) {
    HttpOverrides.global = MyHttpOverrides();
  }



  if (!kIsWeb && Platform.isAndroid) {
    channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.none,
    );

    channel1 = AndroidNotificationChannel(
      'new_booking_alert', // id
      'New Booking Alert', // title
      sound: RawResourceAndroidNotificationSound('noti6x'),
      importance: Importance.high,
    );

    channel2 = AndroidNotificationChannel(
      'other_high_importance_channel', // id
      'Other High Importance Notifications', // title
      sound: RawResourceAndroidNotificationSound('music'),
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
    flutterLocalNotificationsPlugin
        ?.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(channel!);
    await androidPlugin?.createNotificationChannel(channel1!);
    await androidPlugin?.createNotificationChannel(channel2!);


  }


  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Push (OneSignal). Background/terminated delivery is handled by the SDK.
  await PushService.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await _startApp();
}
// <<< END    main()

// >>> START  _startApp()  -  start app
/// Reads the saved login, asks the server how far the driver is in registration and
/// shows the app. If the server cannot be reached it shows a retry screen, so a
/// logged-in driver is not sent back to onboarding just because of bad network.
Future<void> _startApp() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var authCode = sharedPreferences.getString('authCode');
  var checkAuth = '1';
  var checkMail;

  if (authCode != null) {
      var check = await UserAPI().checkApi(authCode);
      if (check == null) {
        // No answer (offline / server error): do not treat this as 'logged out'.
        runApp(_StartupRetryApp(onRetry: _startApp));
        return;
      }
      print("authCode>>>>> " + authCode);
      if (check != null && check['status'] == 'OK') {
        if (check['detail']['email'] != null) {
          checkMail = '2';
          checkAuth = '1';
          personalDetails = check['detail']['personal_details'];
          isEmergencyContactDetails =
          check['detail']['driver_emergency_contacts'];
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
        // Old/expired/revoked auth_code: forget it so the user logs in again.
        if (ApiHelper.isSessionInvalid(check, uri: 'auth_code')) {
          await sharedPreferences.remove('authCode');
        }
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
      locale: _savedLocale(sharedPreferences.getString('language_code')),
    ),
  );
}
// <<< END    _startApp()

// >>> START  _savedLocale()  -  saved locale
/// Turns the saved `language_code` ("hi_IN", "tl_in" ...) back into a [Locale].
/// Only languages that have translations in translate.dart are honoured; anything
/// else falls back to English.
Locale _savedLocale(String? code) {
  const translated = {'en', 'hi', 'tl'};
  final parts = (code ?? '').split('_');
  if (parts.length != 2 || !translated.contains(parts[0].toLowerCase())) {
    return const Locale('en', 'US');
  }
  return Locale(parts[0].toLowerCase(), parts[1].toUpperCase());
}
// <<< END    _savedLocale()


// >>> START  class MyApp
/// Root widget: registers the providers and picks the first screen from the driver's registration progress.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  const MyApp({
    Key? key,
    this.checkAuth,
    this.personalDetails,
    this.isEmergencyContactDetails,
    this.isVehicleTypes,
    this.isDocumentsVerification,
    this.isBankDetails,
    this.isAllDetailsFilled,
    this.isPaidJoiningFee,
    this.isProfileVerified,
    this.locale,
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
  final Locale? locale;

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}
// <<< END    class MyApp

// >>> START  class _MyAppState
class _MyAppState extends State<MyApp> {
  // >>> START  _MyAppState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
  }
  // <<< END    _MyAppState.initState()

  // >>> START  _MyAppState.build()  -  draws this screen / widget (its layout)
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
          // Phones on Android 15+ draw apps edge to edge, so the on-screen navigation bar sits on top of the bottom of every
          // screen (buttons such as Next, Cancel Ride and Later were half hidden). Keep the whole app above it, and take the
          // same amount off the keyboard inset so screens with a keyboard still fit.
          builder: (context, child) {
            final mq = MediaQuery.of(context);
            final navBar = mq.viewPadding.bottom;
            if (child == null) return const SizedBox.shrink();
            if (navBar <= 0) return child;
            return Padding(
              padding: EdgeInsets.only(bottom: navBar),
              child: MediaQuery(
                data: mq.copyWith(
                  padding: mq.padding.copyWith(bottom: 0),
                  viewPadding: mq.viewPadding.copyWith(bottom: 0),
                  viewInsets: mq.viewInsets.copyWith(
                      bottom: (mq.viewInsets.bottom - navBar) < 0 ? 0 : mq.viewInsets.bottom - navBar),
                ),
                child: child,
              ),
            );
          },
          defaultTransition: Transition.native,
          translations: LanguageTranslations(),
          locale: widget.locale ?? const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.mulishTextTheme(
              Theme.of(context).textTheme,
            ),
            primarySwatch: Colors.blue,
          ),
          home: ConnectivityWrapper(
            child: AnimatedSplashScreen(
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
                  : isProfileVerified !=
                  profile_verified_yes
                  ? ProfileReview()
                  : LocationPopUpPage(),
              splashTransition: SplashTransition.scaleTransition,
              backgroundColor: Colors.white,
            ),
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
  // <<< END    _MyAppState.build()
}
// <<< END    class _MyAppState

// >>> START  class ConnectivityWrapper
/// Shows a 'No internet' screen instead of the app whenever the phone is offline.
class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _ConnectivityWrapperState createState() => _ConnectivityWrapperState();
}
// <<< END    class ConnectivityWrapper

// >>> START  class _ConnectivityWrapperState
class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late ConnectivityResult _connectivityResult = ConnectivityResult.none;
  // >>> START  _ConnectivityWrapperState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    checkConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }
  // <<< END    _ConnectivityWrapperState.initState()

  // >>> START  _ConnectivityWrapperState.checkConnectivity()  -  check connectivity
  void checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = connectivityResult;
    });
  }
  // <<< END    _ConnectivityWrapperState.checkConnectivity()

  // >>> START  _ConnectivityWrapperState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return _connectivityResult == ConnectivityResult.none
        ? NoInternetDialog()
        : widget.child;
  }
  // <<< END    _ConnectivityWrapperState.build()
}
// <<< END    class _ConnectivityWrapperState

// >>> START  class NoInternetDialog
class NoInternetDialog extends StatelessWidget {

  const NoInternetDialog({Key? key}) : super(key: key);

  // >>> START  NoInternetDialog.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBlue,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.willpopAlert(context);
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Column(
                  children: [
                    Image.asset(
                      Images.Logo,
                      scale: 2,
                    ),
                  ],

                ),
              ),
            ),
            // Alert Dialog
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: AlertDialog(
                  backgroundColor: tWhite,
                  insetPadding: EdgeInsets.symmetric(horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  title: Text(
                    'No Internet Connection',
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: isTab(context) ? 14.sp : 16.sp,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Turn on mobile data or Wi-Fi to access the app.',
                        style: GoogleFonts.mulish(
                          fontSize: isTab(context) ? 9.sp : 13.sp,
                          fontWeight: FontWeight.w400,
                          color: tbrown,
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    // You can add actions if needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // <<< END    NoInternetDialog.build()
}
// <<< END    class NoInternetDialog


// >>> START  class MyHttpOverrides
/// Accepts every TLS certificate (turns off HTTPS verification). Only installed in
/// debug builds (see main()); never active in a release build.
class MyHttpOverrides extends HttpOverrides {
  // >>> START  MyHttpOverrides.createHttpClient()  -  create http client
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
  // <<< END    MyHttpOverrides.createHttpClient()
}
// <<< END    class MyHttpOverrides

// >>> START  class _StartupRetryApp
/// Shown at launch when the server cannot be reached.
class _StartupRetryApp extends StatelessWidget {
  final Future<void> Function() onRetry;

  const _StartupRetryApp({required this.onRetry});

  // >>> START  _StartupRetryApp.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off, size: 56),
                const SizedBox(height: 16),
                const Text(
                  "Can't reach Rubia right now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please check your internet connection and try again.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Try again'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // <<< END    _StartupRetryApp.build()
}
// <<< END    class _StartupRetryApp

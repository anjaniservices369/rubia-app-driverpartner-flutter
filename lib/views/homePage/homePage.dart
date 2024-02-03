import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/main.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/homePage/componats/notifactionPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/imageConstant.dart';
import '../../providers/notifactionProvider.dart';
import '../profile_review/profile_block.dart';
import 'componats/earning_card.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:audioplayers/audioplayers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.status}) : super(key: key);
  final status;
  _HomePageState createState() => _HomePageState();
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  GoogleMapController? mapController;
  LatLng? startLocation;
  @override
  void dispose() {
    mapController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // //    WidgetsBinding.instance!.addPostFrameCallback((_) {
    // // AwesomeNotifications().displayedStream.listen((receivedNotification) {
    // //     String? createdSourceText =
    // //         AwesomeAssertUtils.toSimpleEnumString(receivedNotification.createdSource);
    // //  print('object..........');

    // //   });
    // // });
    // // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    // //   if (isAllowed) {
    // //     print('vijaya');
    // //     // This is just a basic example. For real apps, you must show some
    // //     // friendly dialog box before call the request method.
    // //     // This is very important to not harm the user experience
    // //     AwesomeNotifications().requestPermissionToSendNotifications();
    // //   }
    // // });
    // FirebaseMessaging.instance.getInitialMessage();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null && !kIsWeb) {
    //     // addNotification(message.notification.title, message.notification.body,
    //     //     message.notification.android.imageUrl);
    //     const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    //       'channel!.id',
    //       'channel!.name',
    //       channelDescription: 'your other channel description',
    //       importance: Importance.max,
    //       priority: Priority.high,
    //       icon: '@mipmap/ic_launcher',
    //       enableLights: true,
    //       sound: RawResourceAndroidNotificationSound('noti'),
    //     );
    //     final NotificationDetails notificationDetails = NotificationDetails(
    //       android: androidNotificationDetails,
    //       // iOS: darwinNotificationDetails,
    //       // macOS: darwinNotificationDetails,
    //       // linux: linuxPlatformChannelSpecifics,
    //     );
    //     await flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       notificationDetails,
    //     );
    //     // flutterLocalNotificationsPlugin!.show(
    //     // notification.hashCode,
    //     // notification.title,
    //     // notification.body,
    //     // NotificationDetails(
    //     //   android: AndroidNotificationDetails(
    //     // channel!.id,
    //     // channel!.name,
    //     //     playSound: true,
    //     //     sound: RawResourceAndroidNotificationSound('noti'),
    //     //     // sound: 'resource://raw/noti',
    //     //     // channel!.description,
    //     //     // TODO add a proper drawable resource to android, for now using
    //     //     //      one that already exists in example app.
    //     //     icon: 'launch_background',
    //     //     importance: Importance.max,
    //     //     priority: Priority.high,
    //     //   ),
    //     // ));

    //     print('Message data: ${message.data}');
    //     if (message.notification != null) {
    //       print('Message also contained a notification: ${message.notification}');
    //       print('onMessageOpenedApp --2');
    //     }
    //   }
    // });

    void handleNewBookingNotification(RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String soundName = 'noti6x';
        print('Sound name : $soundName');
        print("channel1 id home : ${channel1?.id}");
        AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          channel1!.id,
          channel1!.name,
          channelDescription: 'your other channel description',
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          enableLights: true,
          enableVibration: true,
          playSound: true,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(soundName),
        );

        final NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
        );

        await flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );

        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
          print('onMessageOpenedApp --2');
        }
      }
    }

    void handleOtherNotifications(RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String soundName = 'music';
        print('Sound name : $soundName');
        print("channel2 id home: ${channel2?.id}");

        AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          channel2!.id,
          channel2!.name,
          channelDescription: 'your other channel description',
          icon: '@mipmap/ic_launcher',
          importance: Importance.max,
          enableLights: true,
          enableVibration: true,
          playSound: true,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound(soundName),
        );

        final NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
        );

        await flutterLocalNotificationsPlugin?.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails,
        );

        print('Message data: ${message.data}');
        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
          print('onMessageOpenedApp --2');
        }
      }
    }

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null && !kIsWeb) {
        if (notification.title == 'New Booking') {

          handleNewBookingNotification(message);
        } else {
          handleOtherNotifications(message);
        }
      }
    });

    fetchDriverExactLocation();
    FirebaseMessaging.instance.getInitialMessage();
    fetchCheckDetails();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    // TODO: implement initState

    super.initState();
    print("Started listening");
  }

  var driverLat;
  var driverLng;

  fetchDriverExactLocation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      driverLat = sharedPreferences.getDouble('lattitude');
      driverLng = sharedPreferences.getDouble('longitude');
    });
  }

  var onlineStatus;
  var statusNOK;
  var checkDetails;
  fetchCheckDetails() async {
    print('i have startd exicuting');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var authCode = pref.getString('authCode');
    var check = await UserAPI().checkApi(authCode!);
    if (check != null && check['status'] == 'OK') {
      if (check['detail']['status'] == 0) {
        Twl.navigateTo(context, ProfileBlock());
      }
      setState(() {
        onlineStatus = check['detail']['online_status'];
        checkDetails = check['detail'];
      });

    } else {
      setState(() {
        statusNOK = check['status'];
      });
    }
  }

  var userId;
  var userName;
  var driverContact;
  var vechileNumber;

  // var checkDetails;
  var vechileType;
  var _locationData;
  getlatlong() {
    print('object');
    print(_locationData!.latitude.toString());
    print(_locationData!.longitude.toString());
    startLocation = LatLng(_locationData!.latitude, _locationData!.longitude);
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Geoflutterfire geo = Geoflutterfire();
  // PermissionStatus? _permissionGranted;

  Location location = new Location();
  late Stream<List<DocumentSnapshot>> stream;
  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;

    setState(() {});
  }

  Set<Marker> markers = Set();
  addMarkers() async {
    BitmapDescriptor markerbitmapdrop = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/icons/back.png',
    );
    print('lat lng');
    print(_locationData!.latitude.toString());
    print(_locationData!.longitude.toString());
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation!, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'location',
        snippet: '',
      ),
      icon: markerbitmapdrop,
    ));
  }

  int id = 0;

  void _showNotificationCustomSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel2!.id,
      channel2!.name,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableLights: true,
      sound: RawResourceAndroidNotificationSound("noti"),
      enableVibration: true,
      playSound: true,
    );

    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin?.show(
      0,
      'Notification Title',
      'Notification Body',
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }

  var status = 0;
  MyNotifactionProvider myNotificationProvider = MyNotifactionProvider();
  @override
  Widget build(BuildContext context) {
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: onlineStatus == null
          ? statusNOK == 'NOK'
              ? Container(
                  child: Text('Something went wrong'),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text('Fetching online status'),
                )
          : Stack(
              children: [
                onlineStatus == online_status_no
                    ? Container()
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          GoogleMap(
                            liteModeEnabled: false,
                            mapType: MapType.normal,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            compassEnabled: true,
                            mapToolbarEnabled: true,
                            tiltGesturesEnabled: true,
                            zoomControlsEnabled: true,
                            markers: markers,
                            onTap: (tapped) {
                              markers;
                            },
                            onMapCreated: (GoogleMapController controller) {
                              setState(() {
                                mapController = controller;
                              });
                            },
                            onCameraMove: null,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(driverLat, driverLng),
                              zoom: 16.0,
                            ),
                          ),
                          Positioned(
                            bottom: 15.h,
                            right: 10.0,
                            child: FloatingActionButton(
                              onPressed: () {
                                mapController?.animateCamera(
                                  CameraUpdate.newLatLngZoom(
                                    LatLng(driverLat, driverLng),
                                    14.0,
                                  ),
                                );
                              },
                              child: Icon(Icons.my_location),
                            ),
                          ),
                        ],
                      ),
                GestureDetector(
                  onTap: () {
                    print('hi');

                    Twl.forceNavigateTo(context, Notifactionpage(boolnotificationPage: true));
                    // _showNotificationCustomSound();
                  },
                  child:
                      //  Container(
                      //   alignment: Alignment.topRight,
                      //   margin: EdgeInsets.only(top: 5),
                      //   child: Padding(
                      //     padding:
                      //         EdgeInsets.symmetric(horizontal: 5.h, vertical: 4.h),
                      //     child: Image.asset(
                      //       Images.NOTIFICATIO2N,
                      //       scale: isTab(context) ? 2.5 : 3.5,
                      //     ),
                      //   ),
                      // ),
                      Container(
                          alignment: Alignment.topRight,
                          // margin: EdgeInsets.only(top: 5),
                          child: myNotificationProvider.myNotificationList.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 50, right: 40),
                                  child: Image.asset(
                                    Images.NOTIFICATION,
                                    scale: 4,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(top: 50, right: 40),
                                  child: Badge(
                                      isLabelVisible: true,
                                      backgroundColor: tRed,
                                      child: Image.asset(
                                        Images.NOTIFICATION,
                                        scale: 4,
                                      )),
                                )),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      onlineStatus == online_status_no
                          ? Container()
                          : FlutterSwitch(
                              width: 30.w,
                              height: 40.0,
                              valueFontSize: 12.sp,
                              toggleSize: 45.0,
                              value: true,
                              borderRadius: 30.0,
                              padding: 8.0,
                              activeColor: tPrimaryColor,
                              inactiveColor: tRed,
                              activeText: 'Online',
                              inactiveText: 'Offline',
                              activeTextColor: tWhite,
                              inactiveTextColor: tWhite,
                              showOnOff: true,
                              onToggle: (state) async {
                                print('hiiii');
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Are you sure you want to go offline?',
                                        style:
                                            GoogleFonts.mulish(color: tBlack, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 12.sp : 14.sp),
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Twl.navigateBack(context);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 1, color: tPrimaryColor), borderRadius: BorderRadius.circular(6)),
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.mulish(color: tPrimaryColor, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                print('object');
                                                Map<String, String> param = {'status': online_status_no.toString()};
                                                var res = await DriverDetailsApi().fetchOnlineStatusDriver(context, param);
                                                if (res != null && res['status'] == 'OK') {
                                                  setState(() {
                                                    onlineStatus = res['details']['online'];
                                                    fetchCheckDetails();
                                                    Twl.navigateBack(context);
                                                  });
                                                } else {
                                                  Twl.createAlert(context, 'Oops..!', res['error'].toString());
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(vertical: 3.8, horizontal: 15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(width: 1, color: tPrimaryColor), borderRadius: BorderRadius.circular(6)),
                                                child: Text(
                                                  'Ok',
                                                  style: GoogleFonts.mulish(color: tPrimaryColor, fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                      onlineStatus == online_status_no ? SizedBox(height: 6.h) : SizedBox(height: 4.h),
                      Align(alignment: Alignment.center, child: EarningsCard()),
                    ],
                  ),
                ),
                onlineStatus == online_status_yes
                    ? Container()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                                decoration: BoxDecoration(
                                  color: tAppbarColor,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [tBoxShadow],
                                ),
                                child: Text('Youre Currently offline please\n   go online to start earning',
                                    style: TextStyle(color: tBlack, fontSize: isTab(context) ? 10.sp : 12.sp, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        ],
                      ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: onlineStatus == online_status_yes
                          ? Container()
                          : AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: child,
                                );
                              },
                              child: GestureDetector(
                                onTap: checkDetails['booking_eligibility'] == true
                                    ? () async {
                                        print('object');
                                        Map<String, String> param = {'status': online_status_yes.toString()};
                                        var res = await DriverDetailsApi().fetchOnlineStatusDriver(context, param);
                                        if (res != null && res['status'] == 'OK') {
                                          setState(() {
                                            onlineStatus = res['details']['online'];
                                            fetchCheckDetails();
                                          });
                                          Twl.forceNavigateTo(
                                              context,
                                              BottomNavigation(
                                                tabIndexType: 0,
                                                tabIndexId: 1,
                                              ));
                                        } else {
                                          Twl.createAlert(context, 'Oops..!', res['error'].toString());
                                        }
                                      }
                                    : () async {
                                        Twl.wallateShowDailogBox(context, checkDetails);
                                      },
                                child: Container(
                                  height: 17.8.h,
                                  width: 17.8.h,
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Color.fromARGB(255, 51, 187, 56), width: 2),
                                      color: tWhite.withOpacity(0.4)),
                                  child: Container(
                                    height: 16.9.h,
                                    width: 16.9.h,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Color.fromARGB(255, 51, 187, 56), width: 2),
                                        color: tWhite.withOpacity(0.4)),
                                    child: Container(
                                      height: 16.h,
                                      width: 16.h,
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromARGB(255, 51, 187, 56)),
                                      child: Center(
                                        child: Text(
                                          'go_online'.tr,
                                          style:
                                              TextStyle(fontSize: isTab(context) ? 10.sp : 14.sp, color: Colors.white, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}

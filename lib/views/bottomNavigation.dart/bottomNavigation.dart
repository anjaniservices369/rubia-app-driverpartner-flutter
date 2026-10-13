import 'package:base_project_flutter/main.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/wallet/walletpage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../constants/constants.dart';
import 'package:sizer/sizer.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../bookingsPage/bookingPage.dart';
import '../homePage/homePage.dart';
import '../profilePage/profilePage.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
    this.tabIndexId,
    this.selectedType,
    this.tabIndexType,
  }) : super(key: key);

  final tabIndexId;
  final selectedType;
  final tabIndexType;

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var tabIndexs = 0;

  void _onItemTapped(int index) {
    setState(() {
      tabIndexs = index;
      print(index);
    });
  }

  void checkBottomIndex() {
    setState(() {
      tabIndexs = widget.tabIndexId != null ? widget.tabIndexId : 0;
    });
  }

  @override
  void initState() {
    super.initState();
    checkBottomIndex();
    //fetchFireBaseValues();

    // FirebaseMessaging.instance.getInitialMessage();
    // super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null && !kIsWeb) {
    //     flutterLocalNotificationsPlugin!.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           channel!.id,
    //           channel!.name,
    //           importance: Importance.max,
    //           priority: Priority.high,
    //           icon: '@mipmap/ic_launcher',
    //           enableLights: true,
    //           enableVibration: true,
    //           // sound: RawResourceAndroidNotificationSound('clock'),
    //           playSound: true,
    //           sound: RawResourceAndroidNotificationSound('noti.mp3'),
    //
    //         ),
    //       ),
    //     );
    //     if (message.notification != null) {
    //       print(
    //           'Message also contained a notification: ${message.notification}');
    //       print('onMessageOpenedApp --2');
    //       // Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
    //     }
    //     // showNotification();
    //   }
    // });
  }



  loadCams() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
  }

  void showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channel!.id,
      channel!.name,
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      enableLights: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound("noti"),
      //// Replace with your custom sound file name
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

  @override
  Widget build(BuildContext context) {
    Image home(int index) =>
        tabIndexs == index
            ? Image.asset(
          Images.SELECT_HOME,
          width: isTab(context) ? 40 : 22,
        )
            : Image.asset(
          Images.HOME,
          width: isTab(context) ? 35 : 22,
        );
    Image nearby(int index) =>
        tabIndexs == index
            ? Image.asset(
          Images.SELECT_BOOKINGS,
          width: isTab(context) ? 38 : 25,
        )
            : Image.asset(
          Images.BOOKINGS,
          width: isTab(context) ? 38 : 25,
        );
    Image orders(int index) =>
        tabIndexs == index
            ? Image.asset(
          Images.SELECT_WALLET,
          width: isTab(context) ? 40 : 22,
        )
            : Image.asset(
          Images.WALLET,
          width: isTab(context) ? 40 : 22,
        );
    Image profile(int index) =>
        tabIndexs == index
            ? Image.asset(
          Images.SELECT_PROFILE,
          width: isTab(context) ? 36 : 18,
        )
            : Image.asset(
          Images.PROFILE,
          width: isTab(context) ? 36 : 18,
        );
    return WillPopScope(
      onWillPop: () async {
        // Check if the current page is not the home page
        if (tabIndexs != 0) {
          // Switch to the home page and prevent the app from exiting
          _onItemTapped(0);
          return false;
        }

        // Allow the app to exit if on the home page
        return Twl.willpopAlert(context);
      },
      child: Scaffold(
        backgroundColor: tBackground,
        body: IndexedStack(
          children: [
            IndexedStack(
              index: tabIndexs,
              children: [
                HomePage(),
                MyBookingHistory(tabIndexType: widget.tabIndexType,index : tabIndexs),
                WalletPage(
                  selectedType: widget.selectedType,
                ),
                ProfilePage(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            boxShadow: [tBoxShadow],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            child: BottomNavigationBar(
              unselectedItemColor: tGray,
              selectedItemColor: tSecondaryColor,
              onTap: _onItemTapped,
              currentIndex: tabIndexs,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedFontSize: 11.sp,
              unselectedFontSize: 11.sp,
              type: BottomNavigationBarType.fixed,
              backgroundColor: tWhite,
              elevation: 8,
              items: [
                _bottomNavigationBarItem(
                  icon: home(0),
                  label: 'Home',
                ),
                _bottomNavigationBarItem(
                  icon: nearby(1),
                  label: 'Bookings',
                ),
                _bottomNavigationBarItem(
                  icon: orders(2),
                  label: 'Wallet',
                ),
                _bottomNavigationBarItem(
                  icon: profile(3),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomNavigationBarItem({required icon, required String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
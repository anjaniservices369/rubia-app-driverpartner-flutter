// ----------------------------------------------------------------------
// Main tabs
//
// The bottom bar: Home, Bookings, Wallet, Profile.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/main.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/wallet/walletpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../constants/constants.dart';
import 'package:sizer/sizer.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../bookingsPage/bookingPage.dart';
import '../homePage/homePage.dart';
import '../profilePage/profilePage.dart';


// >>> START  class BottomNavigation
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
// <<< END    class BottomNavigation

// >>> START  class _BottomNavigationState
class _BottomNavigationState extends State<BottomNavigation> {
  var tabIndexs = 0;

  // >>> START  _BottomNavigationState._onItemTapped()  -  on item tapped
  void _onItemTapped(int index) {
    setState(() {
      tabIndexs = index;
      print(index);
    });
  }
  // <<< END    _BottomNavigationState._onItemTapped()

  // >>> START  _BottomNavigationState.checkBottomIndex()  -  check bottom index
  void checkBottomIndex() {
    setState(() {
      tabIndexs = widget.tabIndexId != null ? widget.tabIndexId : 0;
    });
  }
  // <<< END    _BottomNavigationState.checkBottomIndex()

  // >>> START  _BottomNavigationState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    checkBottomIndex();

  }
  // <<< END    _BottomNavigationState.initState()



  // >>> START  _BottomNavigationState.loadCams()  -  load cams
  loadCams() async {
  }
  // <<< END    _BottomNavigationState.loadCams()

  // >>> START  _BottomNavigationState.showNotification()  -  show notification
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
  // <<< END    _BottomNavigationState.showNotification()

  // >>> START  _BottomNavigationState.build()  -  draws this screen / widget (its layout)
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Check if the current page is not the home page
        if (tabIndexs != 0) {
          // Switch to the home page and prevent the app from exiting
          _onItemTapped(0);
          return;
        }

        // Ask before exiting if on the home page
        Twl.willpopAlert(context);
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
  // <<< END    _BottomNavigationState.build()

  _bottomNavigationBarItem({required icon, required String label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
// <<< END    class _BottomNavigationState
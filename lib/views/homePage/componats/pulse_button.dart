import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/bookings/bookings.dart';
import 'package:base_project_flutter/views/homePage/componats/regestrtion_dialogBox.dart';
import 'package:base_project_flutter/views/profilePage/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../responsive.dart';
import '../../bookingsPage/bookingPage.dart';
import '../../bottomNavigation.dart/bottomNavigation.dart';

class PulseButton extends StatefulWidget {
  const PulseButton({Key? key}) : super(key: key);

  @override
  _PulseButtonState createState() => _PulseButtonState();
}

class _PulseButtonState extends State<PulseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
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
    super.initState();
  }

  var onlineStatus;
  var statusNOK;
  fetchCheckDetails() async {
    print('i have startd exicuting');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var authCode = pref.getString('authCode');
    var check = await UserAPI().checkApi(authCode!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        onlineStatus = check['detail']['online_status'];
      });
    } else {
      setState(() {
        statusNOK = check['status'];
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  var status = 0;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return onlineStatus == null
        ? statusNOK == 'NOK'
            ? Container(
                child: Text('Something went wrong'),
              )
            : Container(
                alignment: Alignment.center,
                child: Text('Fetching online status'),
              )
        : Center(
            child: onlineStatus == online_status_yes
                ? Text('hi')
                : AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onTap: () async {
                        print('object');
                      },
                      child: Container(
                        height: 17.8.h,
                        width: 17.8.h,
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Color.fromARGB(255, 51, 187, 56),
                                width: 2),
                            // color: Color.fromARGB(255, 51, 187, 56),
                            color: tWhite.withOpacity(0.4)),
                        child: Container(
                          height: 16.9.h,
                          width: 16.9.h,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Color.fromARGB(255, 51, 187, 56),
                                  width: 2),
                              color: tWhite.withOpacity(0.4)),
                          child: Container(
                            height: 16.h,
                            width: 16.h,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 51, 187, 56)),
                            child: Center(
                              child: Text(
                                'go_online'.tr,
                                style: TextStyle(
                                    fontSize: isTab(context) ? 10.sp : 14.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
  }
}

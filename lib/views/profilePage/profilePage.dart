import 'dart:io';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/providers/locationProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/appLanguage/chooseAppLanguage.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/homePage/componats/notifactionPage.dart';
import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:base_project_flutter/views/profilePage/earnings/earnings.dart';
import 'package:base_project_flutter/views/profilePage/notifications/notifications.dart';
import 'package:base_project_flutter/views/profilePage/referearn/referearn.dart';
import 'package:base_project_flutter/views/profilePage/reviews/reviews.dart';
import 'package:base_project_flutter/views/profilePage/ridehistory/ridehistory.dart';
import 'package:base_project_flutter/views/profilePage/subscription/subscription.dart';
import 'package:base_project_flutter/views/profilePage/support/support.dart';
import 'package:base_project_flutter/views/profilePage/tutorials/tutorialspage.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    fetchCheckDetails();
    // TODO: implement
    super.initState();
  }

  var authCode;
  var checkDetails;
  var check;
  fetchCheckDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authCode = sharedPreferences.getString('authCode');
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkDetails = check['detail'];
        print('checkDetailsgggggggggg');
        print(checkDetails);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        backgroundColor: tYellow,
        // leading: GestureDetector(
        //   onTap: () {
        //     Twl.navigateTo(context, BottomNavigation());
        //   },
        //   child: Container(
        //     margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        //     decoration: BoxDecoration(
        //         color: tWhite,
        //         boxShadow: [tBoxShadow],
        //         borderRadius: BorderRadius.circular(6)),
        //     child: Icon(
        //       Icons.arrow_back_ios_new_outlined,
        //       color: tBlue,
        //       size: 16,
        //     ),
        //   ),
        // ),
        centerTitle: false,
        title: Text('profile'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              checkDetails == null
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: SpinKitRotatingCircle(
                        color: tAppbarColor,
                      ),
                    )
                  : Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 70),
                          padding: EdgeInsets.symmetric(
                            vertical: isTab(context) ? 120 : 70,
                          ),
                          decoration: BoxDecoration(
                              boxShadow: [tProfileBack],
                              borderRadius: BorderRadius.circular(15),
                              color: tYellow),
                          child: Center(
                            child: checkDetails['first_name'] != null
                                ? Text(
                                    checkDetails['first_name'],
                                    style: GoogleFonts.mulish(
                                      color: tBlue,
                                      fontSize: isTab(context) ? 15.sp : 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                : Text(
                                    'No name ',
                                    style: GoogleFonts.mulish(
                                      color: tBlue,
                                      fontSize: isTab(context) ? 15.sp : 15.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                        Align(
                          heightFactor: isTab(context) ? 0.6 : 0.7,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [tProfileShadow],
                                      color: tWhite,
                                      borderRadius: BorderRadius.circular(100),
                                      border:
                                          Border.all(color: tYellow, width: 5)),
                                  child: Container(
                                    height: isTab(context) ? 150 : 105,
                                    width: isTab(context) ? 150 : 105,
                                    decoration: BoxDecoration(
                                      color: tWhite,
                                      border:
                                          Border.all(color: tWhite, width: 2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Container(
                                      height: isTab(context) ? 145 : 95,
                                      width: isTab(context) ? 145 : 95,
                                      child: checkDetails['selfie'] != null
                                          ? CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  checkDetails['selfie']),
                                              backgroundColor: tWhite,
                                              radius: isTab(context) ? 20 : 30,
                                            )
                                          : CircleAvatar(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: isTab(context) ? 3.7 : 3.6,
                          child: Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isTab(context) ? 50 : 31,
                                    vertical: 18),
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [tBoxShadow]),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color:
                                              Color.fromARGB(255, 255, 193, 21),
                                          size: 18,
                                        ),
                                        checkDetails['rating_count'] == null
                                            ? Text('0',
                                                style: TextStyle(
                                                  color: tBlue,
                                                  fontFamily: "mulish",
                                                  fontSize: isTab(context)
                                                      ? 12.sp
                                                      : 14.sp,
                                                  fontWeight: FontWeight.w800,
                                                ))
                                            : Text(
                                                checkDetails['rating_count']
                                                    .toString(),
                                                style: TextStyle(
                                                  color: tBlue,
                                                  fontFamily: "mulish",
                                                  fontSize: isTab(context)
                                                      ? 12.sp
                                                      : 14.sp,
                                                  fontWeight: FontWeight.w800,
                                                )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('rating'.tr,
                                        style: TextStyle(
                                          color: tLightBrown,
                                          fontSize:
                                              isTab(context) ? 8.sp : 9.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isTab(context) ? 55 : 38,
                                    vertical: 18),
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [tBoxShadow]),
                                child: Column(
                                  children: [
                                    checkDetails['rides_count'] == null
                                        ? Text('0',
                                            style: TextStyle(
                                              color: tBlue,
                                              fontFamily: "mulish",
                                              fontSize: isTab(context)
                                                  ? 12.sp
                                                  : 14.sp,
                                              fontWeight: FontWeight.w800,
                                            ))
                                        : Text(
                                            checkDetails['rides_count']
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: "mulish",
                                              color: tBlue,
                                              fontSize: isTab(context)
                                                  ? 12.sp
                                                  : 14.sp,
                                              fontWeight: FontWeight.w800,
                                            )),
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text('rides'.tr,
                                        style: TextStyle(
                                          color: tLightBrown,
                                          fontSize:
                                              isTab(context) ? 8.sp : 9.sp,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          )),
                        )
                      ],
                    ),
              Card(
                shadowColor: tBoxShadow.color,
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Twl.forceNavigateTo(
                              context,
                              EarningPage(
                                tabindex: 0,
                              ));
                        },
                        leading: Image.asset(
                          Images.EARNING,
                          scale: 3.5,
                        ),
                        title: Text(
                          'earnings'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.navigateTo(context, Subscription());
                        },
                        leading: Image.asset(
                          Images.SUBSCRIPTION,
                          scale: 3.5,
                        ),
                        title: Text(
                          'subscription'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.remove('startDate');
                          sharedPreferences.remove('endDate');
                          Twl.navigateTo(context, MyRidesView());
                        },
                        leading: Image.asset(
                          Images.RIDE_HISTORY,
                          scale: 3.5,
                        ),
                        title: Text(
                          'ride_history'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.navigateTo(context, Reviews());
                        },
                        leading: Image.asset(
                          Images.RATING_REVIWES,
                          scale: 3.5,
                        ),
                        title: Text(
                          'rating_reviews'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.forceNavigateTo(context, TutorialsPage());
                        },
                        leading: Image.asset(
                          Images.TUTORIALS,
                          scale: 3.5,
                        ),
                        title: Text(
                          'training_tutorials'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.forceNavigateTo(context,
                              Notifactionpage(boolnotificationPage: false));
                        },
                        leading: Image.asset(
                          Images.NOTIFICATION,
                          scale: 3.5,
                        ),
                        title: Text(
                          'notifications'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.navigateTo(context, ReferAndEarnView());
                        },
                        leading: Image.asset(
                          Images.REFER_EARN,
                          scale: 3.5,
                        ),
                        title: Text(
                          "refer_&_earn".tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.forceNavigateTo(context,
                              ChooseAppLanguageView(isReferalPage: false));
                        },
                        leading: Image.asset(
                          Images.APP_LANGUAGE,
                          scale: 3.5,
                        ),
                        title: Text(
                          'app_language'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Twl.forceNavigateTo(context, Support());
                        },
                        leading: Image.asset(
                          Images.SUPPORT,
                          scale: 3.5,
                        ),
                        title: Text(
                          'support'.tr,
                          style: TextStyle(color: tBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Are you sure you want to Logout'),
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                      // gradient: tPrimaryGradientColor,
                                      border: Border.all(
                                          width: 1, color: tPrimaryColor),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: tPrimaryColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                height: 27,
                                width: 70,
                                child: PopupButton(
                                  color: tWhite,
                                  borderSide: BorderSide(
                                    color: tPrimaryColor,
                                  ),
                                  textcolor: tPrimaryColor,
                                  bottonText: 'Logout',
                                  onTap: (startLoading, stopLoading,
                                      btnState) async {
                                    startLoading();
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    var res = await UserAPI().logout(context);
                                    print(res);
                                    if (res != null && res['status'] == 'OK') {
                                      await sharedPreferences.clear();
                                      sharedPreferences.remove(authCode);
                                      Twl.navigateTo(context, LoginPageView());
                                    } else {
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          animType: AnimType.RIGHSLIDE,
                                          headerAnimationLoop: true,
                                          title: 'Logout Failed',
                                          desc: 'Please retry',
                                          btnOkOnPress: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) => MainScreen()));
                                          },
                                          btnOkIcon: Icons.cancel,
                                          btnOkColor: Colors.red);
                                    }
                                    stopLoading();
                                    // } else {
                                    //   // Twl.navigateTo(context, Login());
                                    // }
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: Container(
                    width: 40.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      boxShadow: [tBackbtnBoxShadow],
                      color: tWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.LOGOUT,
                          scale: isTab(context) ? 2 : 3,
                          color: tPrimaryColor,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                              // fontFamily: ,
                              color: tPrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

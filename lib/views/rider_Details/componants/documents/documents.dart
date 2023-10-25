import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';

import 'package:base_project_flutter/responsive.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../constants/constants.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../../globalWidgets/button.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../globalWidgets/leadingbackbtn.dart';
import '../../add_Details.dart';
import 'componants/aadhar_card.dart';
import 'componants/driving_licence.dart';
import 'componants/panCard.dart';
import 'componants/take_your_selfie.dart';

class Documents extends StatefulWidget {
  const Documents({
    Key? key,
  }) : super(key: key);
  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  var takasefie;
  @override
  void initState() {
    fetchCheck();
    super.initState();
  }

  var authCode;
  var checkDetails;
  var check;
  fetchCheck() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authCode = sharedPreferences.getString('authCode');
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkDetails = check['detail'];
        print(checkDetails);
      });
    }
  }

  @override
  bool isselie = false;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(context, AddDetailsView());
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: tWhite,
          leading: BackButtonLeading(
            onTap: () {
              Twl.forceNavigateTo(context, AddDetailsView());
            },
          ),
          centerTitle: false,
          title: Text('documents'.tr,
              style: TextStyle(
                  // fontFamily: 'Plus Jakarta Sans',
                  fontSize: isTab(context) ? 14.sp : 16.sp,
                  color: tSecondaryColor,
                  fontWeight: FontWeight.w700)),
        ),
        body: checkDetails == null
            ? Center(
                child: SpinKitThreeBounce(
                  color: tPrimaryColor,
                  size: 20.0,
                ),
              )
            : WillPopScope(
                onWillPop: () {
                  return Twl.forceNavigateTo(context, AddDetailsView());
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 36.w),
                                child: StepProgressIndicator(
                                  totalSteps: 4,
                                  currentStep: 3,
                                  size: 8,
                                  padding: 0,
                                  selectedColor: tSecondaryColor,
                                  unselectedColor: tlightGray,
                                  roundedEdges: Radius.circular(10),
                                ),
                              ),
                              SizedBox(
                                height: 2.3.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 16),
                                decoration: BoxDecoration(
                                    color: tLightOrange,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    // Icon(Icons. )
                                    Image.asset(
                                      Images.EXLAMENTORYICON,
                                      scale: 3,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'upload_All_documents,_required_For_Your_Verification.'
                                            .tr,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 7.sp : 9.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.3.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (checkDetails['profile_image'] == false) {
                                    Twl.navigateTo(context, TakeYourSelfie());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 14),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: tgreen,width: 1),
                                      color: tWhite,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [tBoxShadow]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'add_your_selfie'.tr,
                                        style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 10.sp : 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      checkDetails['profile_image'] == true
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (checkDetails['driving_license'] ==
                                      false) {
                                    Twl.navigateTo(context, DrivingLicense());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 14),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: tgreen,width: 1),
                                      color: tWhite,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [tBoxShadow]),
                                  child: Row(
                                    children: [
                                      Text(
                                        'driving_license'.tr,
                                        style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 10.sp : 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      checkDetails['driving_license'] == true
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (checkDetails['driver_aadhar_card'] ==
                                      false) {
                                    Twl.navigateTo(context, AdharCard());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 14),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: tWhite,
                                      // border: Border.all(color: tgreen,width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [tBoxShadow]),
                                  child: Row(
                                    children: [
                                      Text(
                                        'aadhar_card'.tr,
                                        style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 10.sp : 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      checkDetails['driver_aadhar_card'] == true
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (checkDetails['driver_pan_cards'] ==
                                      false) {
                                    Twl.navigateTo(context, PanCard());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 14),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: tWhite,
                                      // border: Border.all(color: tgreen,width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [tBoxShadow]),
                                  child: Row(
                                    children: [
                                      Text(
                                        'pan_card'.tr,
                                        style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 10.sp : 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      checkDetails['driver_pan_cards'] == true
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 1.8.h,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (checkDetails['driver_pan_cards'] ==
                                      true) {
                                    var res = await DriverDetailsApi()
                                        .policeVerificationAPi(context);
                                    if (res != null && res['status'] == 'OK') {
                                      Twl.forceNavigateTo(context, Documents());
                                    } else {
                                      Twl.createAlert(context, 'Oops',
                                          res['error'].toString());
                                    }
                                  } else {
                                    Twl.createAlert(
                                        context, 'Oops', 'Fill above details');
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 18, horizontal: 14),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: tgreen,width: 1),
                                      color: tWhite,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [tBoxShadow]),
                                  child: Row(
                                    children: [
                                      Text(
                                        "police_verification".tr,
                                        style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 10.sp : 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      checkDetails['police_verification'] ==
                                              true
                                          ? Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Button(
                      // height: 9.h,
                      // width: 55.w,
                      // color: checkDetails['document_steps'] == PAN_CARD
                      //     ? tBlack
                      //     : tGray,
                      textcolor: tWhite,
                      bottonText: 'next'.tr,
                      // borderSide: BorderSide(
                      //   color: checkDetails['document_steps'] == PAN_CARD
                      //       ? tBlack
                      //       : tGray,
                      // ),
                      // boxshadow: [tButtonBoxshadow],
                      onTap: (startLoading, stopLoading, btnState) {
                        checkDetails['police_verification'] == true
                            ? Twl.forceNavigateTo(context, AddDetailsView())
                            : Twl.createAlert(
                                context, 'Oops', 'Upload required documents');
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class VehicleRegistration {}

import 'dart:io';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/customTextFiled.dart';
import '../../responsive.dart';
// import '../chooseAppLanguage/appLanguaeg.dart';
import '../appLanguage/chooseAppLanguage.dart';
import '../location_popup_page.dart';
import '../otpPage/otpPage.dart';

class ReferalCodeView extends StatefulWidget {
  @override
  State<ReferalCodeView> createState() => _ReferalCodeViewState();
}

class _ReferalCodeViewState extends State<ReferalCodeView> {
  @override
  var referal = 0;
  final TextEditingController _referralCodecontroller = TextEditingController();

  final _formKey = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBlack,
      body: WillPopScope(
        onWillPop: () {
          return Twl.willpopAlert(context);
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: Image.asset(
                      Images.Logo,
                      scale: 1,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: tWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [tBoxShadow]),
                child: Column(
                  children: [
                    SizedBox(height: 3.7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 6, vertical: 6),
                            //     decoration: BoxDecoration(
                            //         color: tWhite,
                            //         boxShadow: [tBoxShadow],
                            //         borderRadius: BorderRadius.circular(8)),
                            //     child: Icon(
                            //       Icons.arrow_back_ios_new_rounded,
                            //       color: tBlack,
                            //     )),
                            // SizedBox(
                            //   width: 2.w,
                            // ),
                            Text(
                              'referral_code'.tr,
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: isTab(context) ? 10.sp : 20.sp,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () {
                              Twl.navigateTo(context,
                                  LocationPopUpPage());
                            },
                            child: Row(
                              children: [
                                Text(
                                  'skip'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTab(context) ? 10.sp : 12.sp,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: tPrimaryColor,
                                  size: 18,
                                  semanticLabel:
                                      'Text to announce in accessibility modes',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Enter Refer Code'.tr,
                            style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w500,
                              color: tbrown,
                              fontSize: isTab(context) ? 10.sp : 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.6.h,
                    ),
                    TextFormFieldWidgets(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "referral_code_can't_be_empty".tr;
                          //
                        }
                      },
                      keyboardTyp: TextInputType.text,
                      hinttext: 'Enter Code'.tr,
                      controller: _referralCodecontroller,
                    ),

                    // Container(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    //   decoration: BoxDecoration(
                    //     color: tbackground,
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         '+91 9008007006',
                    //         style: TextStyle(
                    //             color: tGray,
                    //             fontSize: isTab(context) ? 9.sp : 12.sp,
                    //             fontWeight: FontWeight.w700),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 3.h,
                    // ),
                    // referal == 0
                    //     ? GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             referal = 1;
                    //           });
                    //         },
                    //         child: Container(
                    //           child: Text(
                    //             "have_a_referral_code?".tr,
                    //             style: GoogleFonts.mulish(
                    //               color: tBlack,
                    //               fontWeight: FontWeight.w800,
                    //               fontSize: isTab(context) ? 8.sp : 11.sp,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //     : referal == 1
                    //         ? Column(
                    //             children: [
                    //               Text(
                    //                 'enter_referral_code'.tr,
                    //                 style: TextStyle(
                    //                     color: tGray,
                    //                     fontSize: isTab(context) ? 9.sp : 12.sp,
                    //                     fontWeight: FontWeight.w400),
                    //               ),
                    //               SizedBox(
                    //                 height: 2.h,
                    //               ),
                    //               Container(
                    //                 margin:
                    //                     EdgeInsets.symmetric(horizontal: 24.w),
                    //                 child: TextFormFieldWidgets(
                    //                   validator: (value) {
                    //                     if (value.length != 5 &&
                    //                         value.length < 5) {
                    //                       return 'referal_Code_Must_Be_5_Digits'
                    //                           .tr;
                    //                       //
                    //                     }
                    //                   },
                    //                   inputFormater: <TextInputFormatter>[
                    //                     FilteringTextInputFormatter.allow(
                    //                         RegExp(
                    //                       "[0-9]",
                    //                     )),
                    //                     LengthLimitingTextInputFormatter(5),
                    //                   ],
                    //                   keyboardTyp: TextInputType.number,
                    //                   hinttext: 'enter_referral_code'.tr,
                    //                   controller: null,
                    //                 ),
                    //               )
                    //             ],
                    //           )
                    //         : Container(),
                    SizedBox(height: tDefaultPadding * 3.5),

                    Button(
                      // height: 7.2.h,
                      // width: 60.w,
                      // color: tBlack,
                      textcolor: tWhite,
                      bottonText: 'next'.tr,
                      borderSide: BorderSide(
                        color: tPrimaryColor,
                      ),
                      // boxshadow: [tButtonBoxshadow],
                      onTap: (startLoading, stopLoading, btnState) async {
                        startLoading();
                        print(_referralCodecontroller.text);
                        if (_formKey.currentState!.validate()) {
                          print(_referralCodecontroller.text);
                          if (_formKey.currentState!.validate()) {
                            var res = await UserAPI().addReferralCode(
                                context, _referralCodecontroller.text);
                            if (res != null && res['status'] == 'OK') {
                              Twl.forceNavigateTo(context, LocationPopUpPage());
                            } else {
                              stopLoading();
                              Twl.createAlert(
                                  context, 'Oops', res['error'].toString());
                              stopLoading();
                            }
                            stopLoading();
                          }
                          stopLoading();
                        }
                        stopLoading();
                      },
                    ),
                    SizedBox(
                        height: isTab(context)
                            ? tDefaultPadding
                            : tDefaultPadding * 1),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

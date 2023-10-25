// import 'package:easygo_skipper_flutter/apiServices/userApi.dart';
// import 'package:easygo_skipper_flutter/constants/constants.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:nb_utils/nb_utils.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
// import '../../globalWidgets/textFormFieldWidget.dart';
import '../../globalWidgets/customTextFiled.dart';
import '../../responsive.dart';
import '../otpPage/otpPage.dart';

class LoginPageView extends StatefulWidget {
  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final TextEditingController _usernumbercontroller = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  late String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBlue,
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
                decoration: BoxDecoration(
                    color: tWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [tBoxShadow]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 28),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login".tr,
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w800,
                              fontSize: isTab(context) ? 10.sp : 21.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          TextFormFieldWidgets(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "mobile_Number_Can't_Be_Empty".tr;
                                //
                              } else if (value.length != 10 && value.length < 10) {
                                return "mobile_Number_Must_Be_10_Digits".tr;
                              }
                            },
                            onChanged: (text) {},
                            inputFormater: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(RegExp(
                                "[0-9]",
                              )),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardTyp: TextInputType.number,
                            hinttext: 'Enter Mobile Number'.tr,
                            controller: _usernumbercontroller,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: tDefaultPadding * 3.5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Button(
                        textcolor: tWhite,
                        bottonText: 'Login'.tr,
                        onTap: (startLoading, stopLoading, btnState) async {
                          startLoading();
                          if (_formKey.currentState!.validate()) {
                            print(_usernumbercontroller.text);
                            print('_usernumbercontroller');
                            Map<String, String> param = {'contact_no': _usernumbercontroller.text};
                            print(param.toString());
                            var res = await UserAPI().sendOtp(context, param);
                            if (res != null && res['status'] == 'OK') {
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                  "sessionId", res['details']['Details']);
                              print(sharedPreferences.getString('sessionId'));
                              Twl.navigateTo(context, OtpPageView(mobileNumber: _usernumbercontroller.text, sessionCode: res['details']['Details']));
                            } else {
                              stopLoading();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(res['error'].toString()),
                              ));
                              stopLoading();
                            }

                            stopLoading();
                          }
                          stopLoading();
                        },
                      ),
                    ),
                    SizedBox(height: tDefaultPadding * 1),
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

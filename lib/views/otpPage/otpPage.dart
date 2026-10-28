// ----------------------------------------------------------------------
// Enter SMS code (OTP)
//
// The driver enters the 4-digit SMS code to log in. The code is read from
// the SMS automatically (one tap to allow).
//
// Developer note: Autofill uses the SMS User Consent API (smart_auth). On
// success the JWT auth_code is stored in SharedPreferences.
// ----------------------------------------------------------------------
// import 'package:base_project_flutter/api_services/pushService.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/joiningfees/joining%20_fees.dart';
import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:base_project_flutter/views/profile_review/profile_review.dart';
import 'package:base_project_flutter/views/rider_details/add_Details.dart';
import 'package:base_project_flutter/views/rider_details/componants/bank_details.dart';
import 'package:base_project_flutter/views/rider_details/componants/documents/documents.dart';
import 'package:base_project_flutter/views/rider_details/componants/emergency_Contacts.dart';
import 'package:base_project_flutter/views/rider_details/componants/vehicle_Types.dart';
import 'package:base_project_flutter/api_services/pushService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../location_popup_page.dart';
import '../../responsive.dart';
import '../rider_Details/componants/personal_Details.dart';

// >>> START  class OtpPageView
/// OTP entry screen; reads the SMS code automatically via the Android SMS User Consent API.
class OtpPageView extends StatefulWidget {
  const OtpPageView({Key? key, this.mobileNumber, this.sessionCode}) : super(key: key);
  final mobileNumber;
  final sessionCode;
  @override
  State<OtpPageView> createState() => _OtpPageViewState();
}
// <<< END    class OtpPageView

// >>> START  class _OtpPageViewState
class _OtpPageViewState extends State<OtpPageView> {
  final TextEditingController _otpCodeController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  bool hasError = false;
  var deviceToken;
  final SmartAuth _smartAuth = SmartAuth.instance;

  // >>> START  _OtpPageViewState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fecthDeviceToken();
    _listenForOtpSms();
    // TODO: implement initState
    super.initState();
  }
  // <<< END    _OtpPageViewState.initState()

  // >>> START  _OtpPageViewState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _smartAuth.removeUserConsentApiListener();
    _otpCodeController.dispose();
    super.dispose();
  }
  // <<< END    _OtpPageViewState.dispose()

  // >>> START  _OtpPageViewState._listenForOtpSms()  -  listen for otp sms
  /// Reads the OTP SMS with Google's SMS User Consent API: no READ_SMS
  /// permission and no app hash in the message. Android shows a one-tap
  /// "allow this app to read this message" prompt, then the code is filled in.
  Future<void> _listenForOtpSms() async {
    try {
      // First standalone 4-digit group in the message (the OTP is 4 digits).
      final res = await _smartAuth.getSmsWithUserConsentApi(matcher: r'\b\d{4}\b');
      if (!mounted) return;

      if (res.hasData) {
        final sms = res.requireData;
        final code = sms.code;
        if (code != null && code.length == 4) {
          setState(() => _otpCodeController.text = code);
        }
      }
    } catch (e) {
      // Autofill is optional; manual entry remains available.
    }
  }
  // <<< END    _OtpPageViewState._listenForOtpSms()

  // >>> START  _OtpPageViewState.fecthDeviceToken()  -  fecth device token
  // OneSignal subscription id; may arrive a moment after the SDK starts.
  fecthDeviceToken() async {
    final token = await PushService.waitForSubscriptionId();
    if (!mounted) return;
    setState(() {
      deviceToken = token;
    });
  }
  // <<< END    _OtpPageViewState.fecthDeviceToken()

  // >>> START  _OtpPageViewState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    // HomePageProvider _providerData = Provider.of<HomePageProvider>(context);
    return Scaffold(
      backgroundColor: tBlue,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.navigateBack(context);
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
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [tBoxShadow],
                    color: tWhite,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                child: Padding(
                  padding: EdgeInsets.all(tDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OTP Verification',
                        style: GoogleFonts.mulish(
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: isTab(context) ? 10.sp : 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'Sent to' + " ",
                            style: TextStyle(
                              color: tbrown,
                              fontSize: isTab(context) ? 9.sp : 11.sp,
                            ),
                          ),
                          Text(
                            widget.mobileNumber.toString(),
                            style: TextStyle(
                              color: tPrimaryColor,
                              fontSize: isTab(context) ? 9.sp : 10.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              Twl.forceNavigateTo(context, LoginPageView());
                            },
                            child: Container(
                              width: 8.w,
                              height: 3.h,
                              child: Image.asset(
                                Images.EDITICON,
                                scale: isTab(context) ? 3 : 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: tDefaultPadding * 1,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 23,
                        ),
                        child: PinCodeTextField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(4),
                          ],
                          appContext: context,
                          textStyle: TextStyle(
                            color: tBlack,
                            fontSize: isTab(context) ? 9.sp : 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          pastedTextStyle: TextStyle(
                            color: tBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          obscureText: false,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 4 || v.length == 0) {
                              return "OTP length did not match";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            borderWidth: 1,
                            shape: PinCodeFieldShape.box,
                            activeColor: tgreen,
                            disabledColor: tgreen,
                            selectedColor: tgreen,
                            errorBorderColor: ttextfildfillcolor,
                            selectedFillColor: ttextfildfillcolor,
                            inactiveFillColor: ttextfildfillcolor,
                            inactiveColor: tgreen,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: isTab(context) ? 12.w : 14.5.w,
                            fieldWidth: isTab(context) ? 12.w : 14.5.w,
                            activeFillColor: hasError ? ttextfildfillcolor : ttextfildfillcolor,
                          ),
                          cursorColor: tBlack,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          controller: _otpCodeController,
                          keyboardType: TextInputType.number,
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't receive the code?",
                            style: GoogleFonts.mulish(
                              color: tBlue,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 8.sp : 10.sp,
                            ),
                          ),
                          ArgonTimerButton(
                              initialTimer: 30,
                              height: isTab(context) ? 50 : 50,
                              width: isTab(context) ? (70) : 35.w,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Resend (30s)',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                        color: tPrimaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 8.sp : 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              loader: (timeLeft) {
                                return Text(
                                  "$timeLeft",
                                  style: GoogleFonts.mulish(
                                    color: tBlack,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 8.sp : 12.sp,
                                  ),
                                );
                              },
                              onTap: (startTimer, btnState) async {
                                if (btnState == ArgonButtonState.idle) {
                                  startTimer(30);
                                  Map<String, String> param = {'contact_no': widget.mobileNumber.toString()};
                                  var res = await UserAPI().sendOtp(context, param);
                                  if (res != null && res['status'] == 'OK') {
                                    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                    sharedPreferences.setString("sessionId", res['details']['Details']);
                                    Twl.navigateTo(
                                        context,
                                        OtpPageView(
                                          mobileNumber: widget.mobileNumber.toString(),
                                          sessionCode: res['details']['Details'],
                                        ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        res == null
                                            ? 'Unable to send OTP. Please try again.'
                                            : (res['error']?.toString() ??
                                                'Unable to send OTP. Please try again.'),
                                      ),
                                    ));
                                  }
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 2.5.h,
                      ),
                      Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Button(
                            color: tPrimaryColor,
                            textcolor: tWhite,
                            bottonText: 'Next',
                            borderSide: BorderSide(
                              color: tPrimaryColor,
                            ),
                            onTap: (startLoading, stopLoading, btnState) async {
                              startLoading();
                              if (_formKey.currentState!.validate()) {
                                Map<String, String> param = {
                                  'contact_no': widget.mobileNumber.toString(),
                                  'session_code': widget.sessionCode.toString(),
                                  'otp_code': _otpCodeController.text,
                                  'device_token': (deviceToken ?? '').toString(),
                                  'device_type': '2',
                                };
                                var res = await UserAPI().verifyOtp(context, param);

                                if (res != null && res['status'] == 'OK') {
                                  setState(() {
                                    startLoading();
                                  });
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  sharedPreferences.setString("authCode", res['auth_code']);
                                  if (sharedPreferences.getString('authCode') != null) {
                                    var check = await UserAPI().checkApi(res['auth_code']);
                                    if (check != null && check['status'] == 'OK') {
                                      startLoading();

                                      check['detail']['personal_details'] == false
                                          ? Twl.navigateTo(context, PersonalDetails())
                                          : check['detail']['driver_emergency_contacts'] == false
                                              ? Twl.navigateTo(context, EmergencyContact())
                                              : check['detail']['driver_vehicle_types'] == false
                                                  ? Twl.navigateTo(context, VechileSelection())
                                                  : check['detail']['document_verification'] == false
                                                      ? Twl.navigateTo(context, Documents())
                                                      : check['detail']['driver_bank_details'] == false
                                                          ? Twl.navigateTo(context, BankDetails())
                                                          : check['detail']['all_submit'] == false
                                                              ? Twl.navigateTo(context, AddDetailsView())
                                                              : check['detail']['is_paid_joining_fee'] == false
                                                                  ? Twl.navigateTo(context, JoiningFees())
                                                                  : check['detail']['profile_verified'] != profile_verified_yes
                                                                      ? Twl.navigateTo(context, ProfileReview())
                                                                      : Twl.navigateTo(context, LocationPopUpPage());

                                      // Twl.navigateTo(
                                      //     context, ChooseAppLanguageView());
                                      stopLoading();
                                    } else {
                                      stopLoading();
                                      Twl.createAlert(
                                        context,
                                        'Oops!',
                                        'User not found',
                                      );
                                    }
                                  } else {
                                    stopLoading();
                                    Twl.createAlert(
                                      context,
                                      'oops!',
                                      'User not found',
                                    );
                                  }
                                } else {
                                  stopLoading();
                                  Twl.createAlert(
                                    context,
                                    'oops!',
                                    res == null
                                        ? 'Unable to verify OTP. Please try again.'
                                        : (res['error']?.toString() ??
                                            'Unable to verify OTP. Please try again.'),
                                  );
                                }

                                stopLoading();
                              }
                              stopLoading();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        // width: 100.w,
                        child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            "By login You agree to our" + " ",
                            style: GoogleFonts.mulish(
                              color: tbrown,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 8.sp : 10.sp,
                            ),
                          ),
                          Text(
                            "Terms & Conditions" + " ",
                            style: GoogleFonts.mulish(
                              color: tPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 8.sp : 10.sp,
                            ),
                          ),
                          Text(
                            "and",
                            style: GoogleFonts.mulish(
                              color: tbrown,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 8.sp : 10.sp,
                            ),
                          ),
                        ]),
                      ),
                      Center(
                          child: Text(
                        "Privacy Policy",
                        style: GoogleFonts.mulish(
                          color: tPrimaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: isTab(context) ? 8.sp : 10.sp,
                        ),
                      )),
                      // SizedBox(
                      //   height: tDefaultPadding,
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // <<< END    _OtpPageViewState.build()
  
}
// <<< END    class _OtpPageViewState

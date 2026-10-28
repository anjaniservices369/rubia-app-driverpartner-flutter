// ----------------------------------------------------------------------
// Registration: emergency contacts
//
// Two people to contact in an emergency.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/texfildtital.dart';
import '../../../globalWidgets/textfildcustom.dart';
import '../../../responsive.dart';
import '../add_Details.dart';

// >>> START  class EmergencyContact
class EmergencyContact extends StatefulWidget {
  EmergencyContact({
    Key? key,
    this.firstName,
    this.lastName,
    this.Email,
    this.DateOfBirth,
    this.gender,
    this.address,
  }) : super(key: key);
  final firstName;
  final lastName;
  final Email;
  final DateOfBirth;
  final gender;
  final address;

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}
// <<< END    class EmergencyContact

// >>> START  class _EmergencyContactState
class _EmergencyContactState extends State<EmergencyContact> {
  // >>> START  _EmergencyContactState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fectData();
    // TODO: implement initState
    super.initState();
  }
  // <<< END    _EmergencyContactState.initState()

  var gender1;

  final TextEditingController _personOneNameController =
      TextEditingController();
  final TextEditingController _personOneNumbreController =
      TextEditingController();
  final TextEditingController _personOneReletivenameController =
      TextEditingController();
  final TextEditingController _personOneAdharCardNumber =
      TextEditingController();

  final TextEditingController _personTwoNameController =
      TextEditingController();
  final TextEditingController _personTwoNumbreController =
      TextEditingController();
  final TextEditingController _personTwoReletivenameController =
      TextEditingController();
  final TextEditingController _personTwoAdharCardNumber =
      TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  bool isChecked = false;

  bool isdropdownOpwn = false;
  var dob;
  var yearDiff;
  var formattedTemporaryDate;

  // >>> START  _EmergencyContactState.fectData()  -  fect data
  fectData() {
    setState(() {});
  }
  // <<< END    _EmergencyContactState.fectData()

  String phoneNumber = '123456789';
  RegExp phoneNumberPattern = RegExp(r'^[0-9]{10}$');
  // >>> START  _EmergencyContactState.build()  -  draws this screen / widget (its layout)
  Widget build(BuildContext context) {
    final form = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: tWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [tBoxShadow],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                      child: Text('emergency_contacts'.tr,
                          style: TextStyle(
                              fontSize: isTab(context) ? 14.sp : 16.sp,
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w800)),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                        Text(
                          "Person".tr + " 1",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700,
                              color: tSecondaryColor,
                              fontSize: isTab(context) ? 16.sp : 18.sp),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 2),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: tWhite,
                                boxShadow: [tBoxShadow]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFildTital(
                                //   text: 'name'.tr,
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // TextFieldWidgets(
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'name_can_not_be_empty'.tr;
                                //     } else {
                                //       return null;
                                //     }
                                //   },
                                //   keyboardType: TextInputType.text,
                                //   readOnly: false,
                                //   hinttext: "Enter Your Full Name",
                                //   controller: _personOneNameController,
                                // ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'phone_number'.tr,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFieldWidgets(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "mobile_Number_Can't_Be_Empty".tr;
                                      //
                                    } else if (value.length != 10 &&
                                        value.length < 10) {
                                      return "mobile_Number_Must_Be_10_Digits"
                                          .tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(
                                      "[0-9]",
                                    )),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  keyboardType: TextInputType.number,
                                  readOnly: false,
                                  hinttext: 'Eg : XXXXXXXXX'.tr,
                                  controller: _personOneNumbreController,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFildTital(
                                //   text: 'relation_ship'.tr,
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // TextFieldWidgets(
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'relation_ship_can_not_be_empty'
                                //           .tr;
                                //     } else {
                                //       return null;
                                //     }
                                //   },
                                //   keyboardType: TextInputType.text,
                                //   readOnly: false,
                                //   hinttext: 'Eg: father'.tr,
                                //   controller: _personOneReletivenameController,
                                // ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFildTital(
                                //   text: 'aadhar_number'.tr,
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // TextFieldWidgets(
                                //   inputFormatters: <TextInputFormatter>[
                                //     FilteringTextInputFormatter.allow(RegExp(
                                //       "[0-9]",
                                //     )),
                                //     LengthLimitingTextInputFormatter(12),
                                //   ],
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "aadhar_number_Cant_Be_Empty".tr;
                                //     } else if (value.length != 12 &&
                                //         value.length < 12) {
                                //       return "aadhar_number_Must_Be_12_Digits"
                                //           .tr;
                                //     }
                                //   },
                                //   keyboardType: TextInputType.number,
                                //   readOnly: false,
                                //   hinttext: 'Eg: 1234 5678 9876'.tr,
                                //   controller: _personOneAdharCardNumber,
                                // ),
                                // SizedBox(
                                //   height: 2.h,
                                // ),
                              ],
                            )),
                        Text(
                          "Person".tr + " 2",
                          style: GoogleFonts.mulish(
                              fontWeight: FontWeight.w700,
                              color: tSecondaryColor,
                              fontSize: isTab(context) ? 16.sp : 18.sp),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 2),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: tWhite,
                                boxShadow: [tBoxShadow]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFildTital(
                                //   text: 'name'.tr,
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // TextFieldWidgets(
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'name_can_not_be_empty'.tr;
                                //     } else {
                                //       return null;
                                //     }
                                //   },
                                //   keyboardType: TextInputType.text,
                                //   readOnly: false,
                                //   hinttext: "Enter Your Full Name",
                                //   controller: _personTwoNameController,
                                // ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'phone_number'.tr,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                TextFieldWidgets(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "mobile_Number_Can't_Be_Empty".tr;
                                      //
                                    } else if (value.length != 10 &&
                                        value.length < 10) {
                                      return "mobile_Number_Must_Be_10_Digits"
                                          .tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(
                                      "[0-9]",
                                    )),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  keyboardType: TextInputType.number,
                                  readOnly: false,
                                  hinttext: 'Eg : XXXXXXXXX'.tr,
                                  controller: _personTwoNumbreController,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFildTital(
                                //   text: 'relation_ship'.tr,
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // TextFieldWidgets(
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'relation_ship_can_not_be_empty'
                                //           .tr;
                                //     } else {
                                //       return null;
                                //     }
                                //   },
                                //   keyboardType: TextInputType.text,
                                //   readOnly: false,
                                //   hinttext: 'Eg: father'.tr,
                                //   controller: _personTwoReletivenameController,
                                // ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFildTital(
                                //   text: 'aadhar_number'.tr,
                                // ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // TextFieldWidgets(
                                //   inputFormatters: <TextInputFormatter>[
                                //     FilteringTextInputFormatter.allow(RegExp(
                                //       "[0-9]",
                                //     )),
                                //     LengthLimitingTextInputFormatter(12),
                                //   ],
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return "aadhar_number_Cant_Be_Empty".tr;
                                //       //
                                //     } else if (value.length != 12 &&
                                //         value.length < 12) {
                                //       return "aadhar_number_Must_Be_12_Digits"
                                //           .tr;
                                //     }
                                //   },
                                //   keyboardType: TextInputType.number,
                                //   readOnly: false,
                                //   hinttext: 'Eg: 1234 5678 9876'.tr,
                                //   controller: _personTwoAdharCardNumber,
                                // ),
                                // SizedBox(
                                //   height: 2.h,
                                // ),
                              ],
                            )),
                    Button(
                  textcolor: tWhite,
                  bottonText: 'next'.tr,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  // boxshadow: [tButtonBoxshadow],
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();

                    if (_formKey.currentState!.validate()) {
                      Map<String, String> param = {
                        'person_name_one': _personOneNameController.text,
                        'person_phone_number_one':
                            _personOneNumbreController.text,
                        'person_relationship_one':
                            _personOneReletivenameController.text,
                        'person_name_two': _personTwoNameController.text,
                        'person_phone_number_two':
                            _personTwoNumbreController.text,
                        'person_relationship_two':
                            _personTwoReletivenameController.text,
                        'aadhar_number_one': _personOneAdharCardNumber.text,
                        'aadhar_number_two': _personTwoAdharCardNumber.text,
                      };
                      print(param.toString());
                      // Opened as a full page (startup / OTP) there is nothing to
                      // pop back to, so go to the hub; as a bottom sheet just close it.
                      final openedAsPage = ModalRoute.of(context) is PageRoute;
                      var res = await DriverDetailsApi()
                          .addEmergencyContactAPi(context, param);
                      if (res != null && res['status'] == 'OK') {
                        if (openedAsPage) {
                          Twl.forceNavigateTo(context, const AddDetailsView());
                        } else {
                          Twl.navigateBack(context);
                        }
                        stopLoading();
                      } else {
                        stopLoading();
                        Twl.createAlert(
                            context, 'Gibps', res['error'].toString());
                      }
                      //
                      stopLoading();
                    } else {
                      stopLoading();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('All fields are manditory'),
                      ));
                    }

                    // }
                  }),
                    SizedBox(
                      height: 2.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    // As a full page (startup / OTP) the fields need a Scaffold for their Material
    // ancestor; as a bottom sheet from the hub the sheet already provides it.
    if (ModalRoute.of(context) is PageRoute) {
      return Scaffold(
        backgroundColor: tWhite,
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: form),
      );
    }
    return form;
  }
  // <<< END    _EmergencyContactState.build()
}
// <<< END    class _EmergencyContactState

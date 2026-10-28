// ----------------------------------------------------------------------
// Document: driving licence
//
// Front and back photo of the licence.
// ----------------------------------------------------------------------
// ignore_for_file: unnecessary_null_comparison

import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/providers/globalFunctionProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/rider_details/componants/documents/documents.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../constants/constants.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../globalWidgets/button.dart';
import '../../../../../globalWidgets/leadingbackbtn.dart';
import '../../../../../globalWidgets/texfildtital.dart';
import '../../../../../globalWidgets/textfildcustom.dart';

// >>> START  class DrivingLicense
class DrivingLicense extends StatefulWidget {
  const DrivingLicense({Key? key}) : super(key: key);

  @override
  State<DrivingLicense> createState() => _DrivingLicenseState();
}
// <<< END    class DrivingLicense

// >>> START  class _DrivingLicenseState
class _DrivingLicenseState extends State<DrivingLicense> {
  TextEditingController _drivingLicenseNumberController =
      TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  TextEditingController _DOB = TextEditingController();

  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  DateTime selectedIssueDate = DateTime.now();
  DateTime initialIssueDate = DateTime.now();

  // >>> START  _DrivingLicenseState._selectIssueDate()  -  select issue date
  Future<void> _selectIssueDate(BuildContext context) async {
    selectedIssueDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: tPrimaryColor,
              onPrimary: tWhite,
              onSurface: tBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: tBlack,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedIssueDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );

    if (picked != null && picked != selectedIssueDate) {
      setState(() {
        print('selectedIssueDateeeeeeeeeee');
        print(selectedIssueDate);
        selectedIssueDate = picked;
        selectedIssuedDate = picked;
      });
    }
  }
  // <<< END    _DrivingLicenseState._selectIssueDate()

  var selectedExpiryDate;
  var selectedIssuedDate;
  // >>> START  _DrivingLicenseState._selectDate()  -  select date
  Future<void> _selectDate(BuildContext context) async {
    selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: tPrimaryColor,
              onPrimary: tWhite,
              onSurface: tBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: tBlack,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedExpiryDate = picked;
      });
      print('selectedExpiryDateeeeee');
      print(selectedExpiryDate);
    }
  }
  // <<< END    _DrivingLicenseState._selectDate()

  var formattedTemporaryDate;

  // >>> START  _DrivingLicenseState.DrivingValidate()  -  driving validate
  String? DrivingValidate(String value) {
    String p = "[A-Z]{2}[0-9]{2}[A-Z]{3}[0-9]{5}";

    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid pan number.';
    } else {
      // Twl.navigateTo(context, ConfirmDetails());
      return null;
    }

    // return regExp.hasMatch(em);
  }
  // <<< END    _DrivingLicenseState.DrivingValidate()

  var dlFrontImg;
  var dlBackImg;

  bool dlFrontImgLoading = false;
  bool dlBackImgLoading = false;
  // >>> START  _DrivingLicenseState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    // Keep rebuilding this widget when GlobalFunctionProvider changes.
    context.watch<GlobalFunctionProvider>();
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
        centerTitle: false,
        title: Text('driving_license'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 12.sp : 14.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                        decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadiusDirectional.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'upload_your_driving_license'.tr,
                              style: TextStyle(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context) ? 9.sp : 12.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 16),
                              decoration: BoxDecoration(
                                  color: tlightPink,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    Images.EXLAMENTORYICON,
                                    scale: isTab(context) ? 2.5 : 3.5,
                                    color: tSecondaryColor,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'learner’s_License_Not_Allowed.'.tr,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          color: tSecondaryColor,
                                          fontSize:
                                              isTab(context) ? 7.sp : 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.5.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'front_side'.tr,
                                      style: TextStyle(
                                          color: tSecondaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    dlFrontImgLoading == false
                                        ? GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                dlFrontImgLoading = true;
                                              });
                                              String imgUrl = await Twl()
                                                  .pickImage(context);
                                              if (imgUrl != null ) {
                                                print(
                                                    'Uploaded image URL: $imgUrl');
                                                setState(() {
                                                  dlFrontImg = imgUrl;
                                                });
                                              }
                                              setState(() {
                                                dlFrontImgLoading = false;
                                              });
                                            },
                                            child: Container(
                                              height: 13.h,
                                              width: 38.w,
                                              decoration: BoxDecoration(
                                                  color: tlightGray,
                                                  image: dlFrontImg == null
                                                      ? null
                                                      : DecorationImage(
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            dlFrontImg,
                                                          ),
                                                          fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          color: tWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Image.asset(
                                                        // Images.FRONTCAMERA,
                                                        Images.CAMERAICON,
                                                        scale: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6.w,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          color: tWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Image.asset(
                                                        // Images.FRONTCAMERA,
                                                        Images.DELEATEBTN,
                                                        scale: 2.6,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            child: SpinKitFadingCircle(
                                              color: tPrimaryColor,
                                              size: 20.0,
                                            ),
                                          ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'back_side'.tr,
                                      style: TextStyle(
                                          color: tSecondaryColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    dlBackImgLoading == false
                                        ? GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                dlBackImgLoading = true;
                                              });
                                              String dlImageUrl = await Twl()
                                                  .pickImage(context);

                                              if (dlImageUrl != null) {
                                                print(
                                                    'Uploaded image URL: $dlImageUrl');

                                                setState(() {
                                                  dlBackImg = dlImageUrl;
                                                });
                                                setState(() {
                                                  dlBackImgLoading = false;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 13.h,
                                              width: 38.w,
                                              decoration: BoxDecoration(
                                                  color: tlightGray,
                                                  image: dlBackImg == null
                                                      ? null
                                                      : DecorationImage(
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            dlBackImg,
                                                          ),
                                                          fit: BoxFit.cover),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          color: tWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Image.asset(
                                                        // Images.FRONTCAMERA,
                                                        Images.CAMERAICON,
                                                        scale: 3,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6.w,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          color: tWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Image.asset(
                                                        // Images.FRONTCAMERA,
                                                        Images.DELEATEBTN,
                                                        scale: 2.6,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            child: SpinKitFadingCircle(
                                              color: tPrimaryColor,
                                              size: 20.0,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            TextFildTital(
                              text: "driving_license_number".tr,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFieldWidgets(
                              textCapitalization:
                              TextCapitalization.characters,
                              // style: TextStyle(fontWeight: FontWeight.w600),
                              controller: _drivingLicenseNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'driving_License_Cant_Be_Empty'.tr;
                                }

                                // Remove leading and trailing whitespaces
                                String trimmedValue = value.trim();

                                // Check if the length is not 18 after removing spaces
                                if (trimmedValue.length>21) {
                                  return 'driving License Must Be 21 Characters'.tr;
                                }

                                // Check if the trimmed value is equal to the original value (no extra spaces in between)
                                if (value != trimmedValue) {
                                  return 'driving_License_Cant_Contain_Spaces'.tr;
                                }

                                return null;
                              },

                              keyboardType: TextInputType.text,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(21),
                              ],
                              readOnly: false,
                              hinttext: 'xxxxxxxxx',
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFildTital(
                              text: 'issued_date'.tr,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFieldWidgets(
                                controller: _DOB,
                                onTap: () => _selectIssueDate(context),
                                readOnly: true,
                                hintStyl: TextStyle(
                                    fontSize: isTab(context) ? 10.sp : 12.sp,
                                    color: selectedIssueDate == null
                                        ? tbrown
                                        : tSecondaryColor,
                                    fontWeight: FontWeight.w600),
                                hinttext: selectedIssueDate != null
                                    // ? '${selectedDate.toLocal()}'.split(' ')[0]
                                    ? '${selectedIssueDate.toLocal()}'
                                        .split(' ')[0]
                                    : "Enter Issue Date"
                                // color: isDateSelected ? tBlack : tGray,
                                ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFildTital(
                              text: 'expiry_date'.tr,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFieldWidgets(
                              // style: TextStyle(
                              //     fontSize: isTab(context) ? 10.sp : 12.sp,
                              //     color: tPrimaryColor,
                              //     fontWeight: FontWeight.w400),

                              controller: _DOB,
                              onTap: () => _selectDate(context),
                              readOnly: true,
                              // hintStyl: TextStyle(
                              //     fontSize: isTab(context) ? 10.sp : 12.sp,
                              //     color: tBlack,
                              //     fontWeight: FontWeight.w400),
                              hinttext: selectedDate != null
                                  // ? '${selectedDate.toLocal()}'.split(' ')[0]
                                  ? '${selectedDate.toLocal()}'.split(' ')[0]
                                  : "Enter Expiry Date",
                              // color: isDateSelected ? tBlack : tGray,
                              hintStyl: TextStyle(
                                  fontSize: isTab(context) ? 10.sp : 12.sp,
                                  color: selectedIssueDate == null
                                      ? tbrown
                                      : tSecondaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Button(
                // height: 7.h,
                // width: 55.w,
                // color: tBlack,
                textcolor: tWhite,
                bottonText: 'Save'.tr,
                borderSide: BorderSide(
                  color: tPrimaryColor,
                ),
                // boxshadow: [tButtonBoxshadow],
                onTap: (startLoading, stopLoading, btnState) async {
                  if (Uri.parse(dlFrontImg).isAbsolute && Uri.parse(dlBackImg).isAbsolute ) {
                    startLoading();
                    // The date boxes show today's date until a date is actually
                    // picked; formatting the unpicked (null) dates below threw an
                    // error and left the spinner running with no message.
                    if (selectedIssuedDate == null || selectedExpiryDate == null) {
                      stopLoading();
                      Twl.createAlert(context, 'Oops',
                          'Please select the issued date and the expiry date');
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> param = {
                        'driving_license_front': dlFrontImg.toString(),
                        'driving_license_back': dlBackImg.toString(),
                        'driving_license_number':
                        _drivingLicenseNumberController.text,
                        'issued_date':
                        Twl.dateFormate(selectedIssueDate).toString(),
                        'expire_date':
                        Twl.dateFormate(selectedExpiryDate).toString()
                      };
                      print(param);
                      if (selectedIssuedDate != null &&
                          selectedExpiryDate != null) {
                        if (dlFrontImg != null && dlBackImg != null) {
                          var res = await DriverDetailsApi()
                              .uploadDrivingLicenceApi(context, param);
                          if (res != null && res['status'] == 'OK') {
                            Twl.forceNavigateTo(context, Documents());
                          } else {
                            stopLoading();
                            Twl.createAlert(
                                context, 'Oops', res['error'].toString());
                          }
                        } else {
                          stopLoading();
                          Twl.createAlert(context, 'Oops', 'upload Image');
                        }
                        stopLoading();
                      } else {
                        stopLoading();
                        Twl.createAlert(
                            context, 'Oops', 'All fields are mandatory');
                      }
                      stopLoading();
                    } else {
                      // A failed validation used to leave the spinner running.
                      stopLoading();
                    }
                  }else{
                    Twl.createAlert(context, 'Invalid Image',
                        'Please Upload Correct image before saving..');
                  }
                }),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
  // <<< END    _DrivingLicenseState.build()
}
// <<< END    class _DrivingLicenseState

// ----------------------------------------------------------------------
// Registration checklist
//
// Shows the registration steps (personal, emergency, vehicle, documents,
// bank) with ticks and the final Submit button.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';

import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';

import '../joiningfees/joining _fees.dart';
import '../../models/booking_rules.dart';
import '../profile_review/profile_review.dart';
import '../location_popup_page.dart';
import '../../constants/stetuesConstant.dart';
import 'componants/bank_details.dart';
import 'componants/documents/documents.dart';
import 'componants/emergency_Contacts.dart';
import 'componants/personal_Details.dart';
import 'componants/vehicle_Types.dart';

// >>> START  class AddDetailsView
class AddDetailsView extends StatefulWidget {
  const AddDetailsView({Key? key}) : super(key: key);

  @override
  State<AddDetailsView> createState() => _AddDetailsViewState();
}
// <<< END    class AddDetailsView

// >>> START  class _AddDetailsViewState
class _AddDetailsViewState extends State<AddDetailsView> {
  // >>> START  _AddDetailsViewState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchCheck();
    super.initState();
  }
  // <<< END    _AddDetailsViewState.initState()

  var authCode;
  var checkDetails;
  var check;
  // >>> START  _AddDetailsViewState.fetchCheck()  -  fetch check
  fetchCheck() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authCode = sharedPreferences.getString('authCode');
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkDetails = check['detail'];
        print('checkDetailsgggggggggg');
        print(checkDetails);
        print('checkDetailsffffffffffffff');
      });
    }
  }
  // <<< END    _AddDetailsViewState.fetchCheck()

  bool ischeckbox = false;

  bool isjobdetails = false;
  // >>> START  _AddDetailsViewState.build()  -  draws this screen / widget (its layout)
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Twl.willpopAlert(context);
      },
      child: Scaffold(
        backgroundColor: tBackground,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: tWhite,
          leading: BackButtonLeading(
            onTap: () {
              Twl.willpopAlert(context);
            },
          ),
          title: Text('add_details'.tr,
              style: TextStyle(
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
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                decoration: BoxDecoration(
                                  color: tWhite,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [tBoxShadow],
                                ),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (checkDetails['personal_details'] ==
                                            false) {
                                          showModalBottomSheet(
                                            isScrollControlled: true,
                                            context: context,
                                            backgroundColor:
                                                Colors.transparent,
                                            builder: (context) =>
                                                PersonalDetails(),
                                          ).then((_) => fetchCheck());
                                        }
                                      },
                                      child: Container(
                                        color: tWhite,
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: tDeepBrown,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  Images.PERSONALDETAILS,
                                                  scale: 3,
                                                )),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              'personal_details'.tr,
                                              style: TextStyle(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            checkDetails['personal_details']
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
                                      height: 3.5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (checkDetails['personal_details'] ==
                                            true) {
                                          if (checkDetails[
                                                  'driver_emergency_contacts'] ==
                                              false) {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (context) =>
                                                  EmergencyContact(),
                                            ).then((_) => fetchCheck());
                                          }
                                        } else {
                                          Twl.createAlert(context, 'Alert',
                                              'Please fill the above personel details');
                                        }
                                      },
                                      child: Container(
                                        color: tWhite,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: tDeepBrown,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  Images.EMERGENCYCONTACT,
                                                  scale: 3,
                                                )),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              'emergency_contact_details'.tr,
                                              style: TextStyle(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            checkDetails[
                                                    'driver_emergency_contacts']
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
                                      height: 3.5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (checkDetails[
                                                'driver_emergency_contacts'] ==
                                            true) {
                                          if (checkDetails[
                                                  'driver_vehicle_types'] ==
                                              false) {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (context) =>
                                                  VechileSelection(),
                                            ).then((_) => fetchCheck());
                                          }
                                        } else {
                                          Twl.createAlert(context, 'Alert',
                                              'Please fill the above emergency details');
                                        }
                                      },
                                      child: Container(
                                        color: tWhite,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: tDeepBrown,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  Images.VEHICLETYPE,
                                                  scale: 3.5,
                                                )),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              'vehicle_types'.tr,
                                              style: TextStyle(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            checkDetails['driver_vehicle_types']
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
                                      height: 3.5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (checkDetails[
                                                'driver_vehicle_types'] ==
                                            true) {
                                          if (checkDetails[
                                                  'document_verification'] ==
                                              false) {
                                            Twl.forceNavigateTo(
                                                context, Documents());
                                          }
                                        } else {
                                          Twl.createAlert(context, 'Alert',
                                              'Please fill the above vehicle details');
                                        }
                                      },
                                      child: Container(
                                        color: tWhite,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: tDeepBrown,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  Images.DOCUMENTS,
                                                  scale: 3,
                                                )),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              'documents'.tr,
                                              style: TextStyle(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            checkDetails[
                                                    'document_verification']
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
                                      height: 3.5.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (checkDetails[
                                                'document_verification'] ==
                                            true) {
                                          if (checkDetails[
                                                  'driver_bank_details'] ==
                                              false) {
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              context: context,
                                              backgroundColor:
                                                  Colors.transparent,
                                              builder: (context) =>
                                                  BankDetails(),
                                            ).then((_) => fetchCheck());
                                          }
                                        } else {
                                          Twl.createAlert(context, 'Alert',
                                              'Please fill the above document details');
                                        }
                                      },
                                      child: Container(
                                        color: tWhite,
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            Container(
                                                height: 45,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                    color: tDeepBrown,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  Images.BANKDETAILS,
                                                  scale: 3,
                                                )),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              'bank_details'.tr,
                                              style: TextStyle(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 12.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            checkDetails['driver_bank_details']
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
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                Transform.scale(
                                    scale: 1.1,
                                    child: Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor: tPrimaryColor),
                                      child: Checkbox(
                                          activeColor: tPrimaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: BorderSide(
                                                  color: ischeckbox == true
                                                      ? tPrimaryColor
                                                      : tPrimaryColor,
                                                  width: 0.6)),
                                          value: ischeckbox,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              ischeckbox = value!;
                                            });
                                          }),
                                    )),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                  // onTap: () => launch(TERMS_AND_CONDITIONS),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'i_Agree_to_The'.tr,
                                      style: TextStyle(
                                          color: tSecondaryColor,
                                          fontSize:
                                              isTab(context) ? 9.sp : 12.sp),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: " " + 'terms_&_conditions'.tr,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(
                                                  0xFF3A50C2,
                                                ))),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Button(
                    textcolor: tWhite,
                    bottonText: 'next'.tr,
                    onTap: (startLoading, stopLoading, btnState) async {
                      if (!ischeckbox) {
                        Twl.createAlert(context, 'Message', 'Please accept terms and conditions');
                        return;
                      }
                      startLoading();
                      final prefs = await SharedPreferences.getInstance();
                      final code = prefs.getString('authCode');
                      final response = code == null ? null : await UserAPI().checkApi(code);
                      if (!mounted) return;
                      stopLoading();
                      if (response == null || response['status'] != 'OK' || response['detail'] is! Map) {
                        Twl.createAlert(context, 'Unable to continue',
                            response?['error']?.toString() ?? 'Could not refresh your registration. Please try again.');
                        return;
                      }
                      setState(() => checkDetails = response['detail']);
                      if (checkDetails['personal_details'] == true &&
                          checkDetails['driver_emergency_contacts'] == true &&
                          checkDetails['driver_vehicle_types'] == true &&
                          checkDetails['driver_bank_details'] == true &&
                          checkDetails['document_verification'] == true &&
                          checkDetails['driver_bank_details'] == true) {
                        try {
                          Twl.forceNavigateTo(context,
                              requiresJoiningFee(Map<String, dynamic>.from(checkDetails))
                                  ? JoiningFees()
                                  : checkDetails['profile_verified'] == profile_verified_yes
                                      ? LocationPopUpPage() : ProfileReview());
                        } on FormatException catch (error) {
                          Twl.createAlert(context, 'Unable to continue', error.message);
                        }
                      } else {
                        Twl.createAlert(context, 'Alert..!',
                            'Please complete all required registration details');
                      }
                      // Twl.forceNavigateTo(context, JoiningFees());
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
      ),
    );
  }
  // <<< END    _AddDetailsViewState.build()
}
// <<< END    class _AddDetailsViewState

// ignore_for_file: prefer_const_constructors

// import 'package:easygo_skipper_flutter/apiServices/userApi.dart';
// import 'package:easygo_skipper_flutter/globalFuctions/globalFunctions.dart';
// import 'package:easygo_skipper_flutter/responsive.dart';
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../constants/constants.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
// import '../../../globalWidgets/customTextFormFiels.dart';
import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../globalWidgets/texfildtital.dart';
import '../../../globalWidgets/textfildcustom.dart';
import '../../../responsive.dart';
import '../add_Details.dart';
// import '../add_details_view.dart';
// import '../riderDetails.dart';

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key}) : super(key: key);

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  String? UPIValidate(String value) {
    String p = "[a-zA-Z0-9]{3,}@upi";

    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      return 'enter_A_Valid_iFSC_Number.'.tr;
    } else {
      // Twl.navigateTo(context, ConfirmDetails());
      return null;
    }
  }

  TextEditingController _accountHolderNameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _branchNameController = TextEditingController();
  TextEditingController _IFSCController = TextEditingController();
  TextEditingController _UPIController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.forceNavigateTo(context, AddDetailsView());
          },
        ),
        centerTitle: false,
        title: Text('bank_details'.tr,
            style: TextStyle(
                // fontFamily: 'Plus Jakarta Sans',
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, AddDetailsView());
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 36.w),
                          // ignore: prefer_const_constructors
                          child: StepProgressIndicator(
                            totalSteps: 4,
                            currentStep: 4,
                            size: 8,
                            padding: 0,
                            selectedColor: tSecondaryColor,
                            unselectedColor: tSecondaryColor,
                            roundedEdges: Radius.circular(10),
                          ),
                        ),
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
                                vertical: 4.h, horizontal: 14),
                            decoration: BoxDecoration(
                                color: tWhite,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [tBoxShadow]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'add_your_bank_details'.tr,
                                  style: TextStyle(
                                      color: tSecondaryColor,
                                      fontSize: isTab(context) ? 9.sp : 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'account_holder_name'.tr,
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                TextFieldWidgets(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: tSecondaryColor),
                                  controller: _accountHolderNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter_bankholder_name_Cant_Be_Empty'
                                          .tr;
                                    } else if (value.length != 3 &&
                                        value.length < 3) {
                                      return 'enter_bankholder_name_Must_Be_Minimum_3_Characters'
                                          .tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  keyboardType: TextInputType.text,
                                  hinttext: 'enter_Bank_Holder_Name'.tr,
                                  readOnly: false,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'account_Number'.tr,
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                TextFieldWidgets(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: tSecondaryColor),
                                  controller: _accountNumberController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'account_Number_Cant_Be_Empty'.tr;
                                    } else if (value.length != 9 &&
                                        value.length < 9) {
                                      return 'account_Number_Must_Be_9_To_17_Digits'
                                          .tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  readOnly: false,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(
                                      "[0-9]",
                                    )),
                                    LengthLimitingTextInputFormatter(18),
                                  ],
                                  hinttext: 'xxxxxxxxx',
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'iFSC_Code'.tr,
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                TextFieldWidgets(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: tSecondaryColor),
                                  controller: _IFSCController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'ifsc_Code_Can_Not_Be_Empty.'.tr;
                                    } else if (value.length != 11 &&
                                        value.length < 11) {
                                      return 'enter_Valid_Ifsc_Code'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  readOnly: false,
                                  hinttext: 'enter_Ifsc_Code'.tr,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(11),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'bank_name'.tr,
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                TextFieldWidgets(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: tSecondaryColor),
                                  controller: _bankNameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'bank_Name_Can_Not_Be_Empty.'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  hinttext: 'enter_bank_Name'.tr,
                                  keyboardType: TextInputType.text,
                                  readOnly: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4.h, horizontal: 14),
                            decoration: BoxDecoration(
                                color: tWhite,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [tBoxShadow]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 0.6.h,
                                ),
                                Text(
                                  'add_your_uPI'.tr,
                                  style: TextStyle(
                                      color: tSecondaryColor,
                                      fontSize: isTab(context) ? 9.sp : 12.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextFildTital(
                                  text: 'uPI'.tr,
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                TextFieldWidgets(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: tSecondaryColor),
                                  controller: _UPIController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'uPI_Id_Can_Not_Be_Empty.'.tr;
                                    } else {
                                      return null;
                                    }
                                  },
                                  hinttext: 'xxxxxxxxx',
                                  readOnly: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
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
                bottonText: 'Next'.tr,
                borderSide: BorderSide(
                  color: tPrimaryColor,
                ),
                // boxshadow: [tButtonBoxshadow],
                onTap: (startLoading, stopLoading, btnState) async {
                  if (_formKey.currentState!.validate()) {
                    startLoading();
                    Map<String, String> param = {
                      'account_holder_name': _accountHolderNameController.text,
                      'bank_name': _bankNameController.text,
                      'account_number': _accountNumberController.text,
                      'ifsc_code': _IFSCController.text,
                      'upi_id': _UPIController.text,
                    };
                    var res = await DriverDetailsApi()
                        .addDriverBankDetails(context, param);
                    if (res != null && res['status'] == 'OK') {
                      Twl.forceNavigateTo(context, AddDetailsView());

                      stopLoading();
                    } else {
                      stopLoading();
                      Twl.createAlert(context, 'Oops', res['error'].toString());
                      stopLoading();
                    }
                    stopLoading();
                  } else {
                    stopLoading();
                  }
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

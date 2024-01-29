import 'dart:io';

import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import '../../../../../constants/constants.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../globalWidgets/button.dart';
import '../../../../../globalWidgets/leadingbackbtn.dart';
import '../../../../../globalWidgets/texfildtital.dart';
import '../../../../../globalWidgets/textfildcustom.dart';
import '../../../../../responsive.dart';
import '../documents.dart';

class PanCard extends StatefulWidget {
  const PanCard({Key? key, this.chasisNumber}) : super(key: key);
  final chasisNumber;

  @override
  State<PanCard> createState() => _PanCardState();
}

class _PanCardState extends State<PanCard> {
  TextEditingController _panNumberController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  String? panValidate(String value) {
    String p = "[A-Z]{5}[0-9]{4}[A-Z]{1}";

    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid pan number.';
    } else {
      // Twl.navigateTo(context, ConfirmDetails());
      return null;
    }

    // return regExp.hasMatch(em);
  }

  var panImg;
  bool panImgLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
        centerTitle: false,
        title: Text('pan_card'.tr,
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
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(12)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 16),
                          decoration: BoxDecoration(
                              color: tWhite,
                              boxShadow: [tBoxShadow],
                              borderRadius:
                                  BorderRadiusDirectional.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'upload_your_pan_card'.tr,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 9.sp : 12.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 2.5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      TextFildTital(
                                        text: 'front_side'.tr,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      panImgLoading == false
                                          ? GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  panImgLoading = true;
                                                });
                                                String imgUrl = await Twl()
                                                    .pickImage(context);
                                                print(
                                                    'Uploaded image URL: $imgUrl');
                                                setState(() {
                                                  panImg = imgUrl;
                                                });
                                                setState(() {
                                                  panImgLoading = false;
                                                });
                                              },
                                              child: Container(
                                                height: 13.h,
                                                width: 38.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    image: panImg == null
                                                        ? null
                                                        : DecorationImage(
                                                            image: NetworkImage(
                                                              panImg,
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
                                                                    .circular(
                                                                        4)),
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
                                                                    .circular(
                                                                        4)),
                                                        child: Image.asset(
                                                          // Images.FRONTCAMERA,
                                                          Images.DELEATEBTN,
                                                          scale: 2.5,
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
                                ],
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              TextFildTital(
                                text: 'pan_number'.tr,
                              ),

                              SizedBox(
                                height: 1.h,
                              ),
                              TextFieldWidgets(
                                textCapitalization:
                                    TextCapitalization.characters,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: tSecondaryColor),
                                controller: _panNumberController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'pan_number_can_not_be_empty.'.tr;
                                  } else {
                                    return panValidate(value);
                                  }
                                },
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                readOnly: false,
                                hinttext: 'enter_pan_number'.tr,
                              ),
                              // CustomTextFormField(
                              //   controllers: _panNumberController,
                              //   inputFormatters: <TextInputFormatter>[
                              //     LengthLimitingTextInputFormatter(10),
                              //   ],
                              // validators: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'PAN number can not be empty.';
                              //   } else {
                              //     return panValidate(value);
                              //   }
                              // },
                              //   hinttext: 'Enter PAN Number',
                              //   keyboardType: TextInputType.text,
                              //   hintstyle: TextStyle(
                              // color: tGray,
                              // fontSize: isTab(context) ? 9.sp : 12.sp,
                              // fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
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
              bottonText: 'save'.tr,
              borderSide: BorderSide(
                color: tPrimaryColor,
              ),
              // boxshadow: [tButtonBoxshadow],
              onTap: (startLoading, stopLoading, btnState) async {
                if (Uri.parse(panImg).isAbsolute) {
                startLoading();
                if (_formKey.currentState!.validate()) {
                  Map<String, String> param = {
                    'pan_number': _panNumberController.text,
                    'pan_front': panImg.toString()
                  };
                  print(param);
                  if (panImg != null) {
                    var res = await DriverDetailsApi()
                        .uploadPanCardApi(context, param);
                    if (res != null && res['status'] == 'OK') {
                      Twl.forceNavigateTo(context, Documents());
                      stopLoading();
                    } else {
                      stopLoading();
                      Twl.createAlert(context, 'Oops', res['error'].toString());
                    }
                  } else {
                    stopLoading();
                    Twl.createAlert(context, 'Oops', 'upload Image');
                  }
                  stopLoading();
                }
                stopLoading();
                }else{
                  Twl.createAlert(context, 'Invalid Image',
                      'Please Upload Correct image before saving..');
                }
              },
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// Document: Aadhaar card
//
// Front and back photo of the Aadhaar card.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../../constants/constants.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../globalWidgets/button.dart';
import '../../../../../globalWidgets/leadingbackbtn.dart';
import '../../../../../globalWidgets/texfildtital.dart';
import '../../../../../globalWidgets/textfildcustom.dart';
import '../../../../../responsive.dart';
import '../documents.dart';

// >>> START  class AdharCard
class AdharCard extends StatefulWidget {
  const AdharCard({Key? key, this.chasisNumber}) : super(key: key);
  final chasisNumber;

  @override
  State<AdharCard> createState() => _AdharCardState();
}
// <<< END    class AdharCard

// >>> START  class _AdharCardState
class _AdharCardState extends State<AdharCard> {
  TextEditingController _aadharNumberController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  // >>> START  _AdharCardState.panValidate()  -  pan validate
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
  // <<< END    _AdharCardState.panValidate()

  var aadharFrontImg;
  var aadharBackImg;
  bool aadharFrontImgLoading = false;
  bool aadharBackImgLoading = false;

  // >>> START  _AdharCardState.build()  -  draws this screen / widget (its layout)
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
        title: Text('aadhar_card'.tr,
            style: TextStyle(
                // fontFamily: 'Plus Jakarta Sans',
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
                                'upload_Your_Aadhar_Card'.tr,
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
                                      aadharFrontImgLoading == false
                                          ? GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  aadharFrontImgLoading = true;
                                                });
                                                String imgUrl = await Twl()
                                                    .pickImage(context);
                                                print(
                                                    'Uploaded image URL: $imgUrl');
                                                setState(() {
                                                  aadharFrontImg = imgUrl;
                                                });
                                                setState(() {
                                                  aadharFrontImgLoading = false;
                                                });
                                              },
                                              child: Container(
                                                height: 13.h,
                                                width: 38.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    image: aadharFrontImg ==
                                                            null
                                                        ? null
                                                        : DecorationImage(
                                                            onError: (_, __) {}, // missing/failed image -> blank
                                                            image: NetworkImage(
                                                              aadharFrontImg,
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
                                  Column(
                                    children: [
                                      TextFildTital(
                                        text: 'back_side'.tr,
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      aadharBackImgLoading == false
                                          ? GestureDetector(
                                              onTap: () async {
                                                setState(() {
                                                  aadharBackImgLoading = true;
                                                });
                                                String aadharImageUrl =
                                                    await Twl()
                                                        .pickImage(context);
                                                print(
                                                    'Uploaded image URL: $aadharImageUrl');

                                                setState(() {
                                                  aadharBackImg =
                                                      aadharImageUrl;
                                                });
                                                setState(() {
                                                  aadharBackImgLoading = false;
                                                });
                                              },
                                              child: Container(
                                                height: 13.h,
                                                width: 38.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    image: aadharBackImg == null
                                                        ? null
                                                        : DecorationImage(
                                                            onError: (_, __) {}, // missing/failed image -> blank
                                                            image: NetworkImage(
                                                              aadharBackImg,
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
                                text: 'aadhar_Number'.tr,
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              TextFieldWidgets(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: tSecondaryColor),
                                controller: _aadharNumberController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'aadhar_number_Cant_Be_Empty'.tr;
                                  } else if (value.length != 12) {
                                    return 'aadhar_number_Must_Be_12_Digits'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(
                                    "[0-9]",
                                  )),
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                hinttext: 'xxxxxxxxxx',
                                readOnly: false,
                              ),
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
              bottonText: 'Save'.tr,

              // boxshadow: [tButtonBoxshadow],
              onTap: (startLoading, stopLoading, btnState) async {
                if (Uri.parse(aadharFrontImg).isAbsolute && Uri.parse(aadharBackImg).isAbsolute ) {
                startLoading();
                if (_formKey.currentState!.validate()) {
                  Map<String, String> param = {
                    'aadhar_number': _aadharNumberController.text,
                    'aadhar_card_front': aadharFrontImg.toString(),
                    'aadhar_card_back': aadharBackImg.toString(),
                  };
                  print(param);
                  if (aadharFrontImg != null && aadharBackImg != null) {
                    var res = await DriverDetailsApi()
                        .uploadAadharCardApi(context, param);
                    if (res != null && res['status'] == 'OK') {
                      Twl.forceNavigateTo(context, Documents());
                    } else {
                      stopLoading();
                      Twl.createAlert(context, 'Oops', res['error'].toString());
                      stopLoading();
                    }
                    stopLoading();
                  } else {
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
            )
          ],
        ),
      ),
    );
  }
  // <<< END    _AdharCardState.build()
}
// <<< END    class _AdharCardState

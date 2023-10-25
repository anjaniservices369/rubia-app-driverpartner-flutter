import 'dart:io';

import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/providers/globalFunctionProvider.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../../constants/imageConstant.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../globalWidgets/leadingbackbtn.dart';
import '../../../../../responsive.dart';
import 'driving_licence.dart';

class TakeYourSelfie extends StatefulWidget {
  const TakeYourSelfie({Key? key, this.takasefie}) : super(key: key);
  final takasefie;

  @override
  State<TakeYourSelfie> createState() => _TakeYourSelfieState();
}

class _TakeYourSelfieState extends State<TakeYourSelfie> {
  var profileImage;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalFunctionProvider _data = Provider.of<GlobalFunctionProvider>(
      context,
    );
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
        centerTitle: false,
        title: Text('add_your_selfie'.tr,
            style: TextStyle(
                // fontFamily: 'Plus Jakarta Sans',
                fontSize: isTab(context) ? 12.sp : 14.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 23, horizontal: 12),
                              decoration: BoxDecoration(
                                color: tWhite,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [tBoxShadow],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'take_your_selfie'.tr,
                                    style: TextStyle(
                                        color: tSecondaryColor,
                                        fontSize:
                                            isTab(context) ? 11.sp : 14.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Center(
                                    child: Text(
                                      'we_Use_Your_Selfie_To_Compare_With_Your_id'
                                          .tr,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: tbrown,
                                          fontSize:
                                              isTab(context) ? 11.sp : 11.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  // _profileLoader
                                  //     ?
                                  isLoading == true
                                      ? Align(
                                          alignment: Alignment.center,
                                          child: CircularProgressIndicator(
                                            color: tAppbarColor,
                                          ))
                                      : Container(
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              image: profileImage == null
                                                  ? DecorationImage(
                                                      image: AssetImage(
                                                        Images.PERSONALDETAILS,
                                                      ),
                                                      fit: BoxFit.fill)
                                                  : DecorationImage(
                                                      image: NetworkImage(
                                                          profileImage),
                                                      fit: BoxFit.cover),
                                              color: tPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(150)),
                                        ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: tPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Center(
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                color: tWhite,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 7),
                                              child: Text(
                                                'good_Lighting'.tr,
                                                style: TextStyle(
                                                    color: tSecondaryColor,
                                                    fontSize: isTab(context)
                                                        ? 9.sp
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              'make_Sure_You_Are_In_A_Well_Lit_Area_And_Both_Ears_Are_Uncovered '
                                                  .tr,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: tbrown,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: tPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Center(
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                color: tWhite,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: 7),
                                              child: Text(
                                                'look_Straight'.tr,
                                                style: TextStyle(
                                                    color: tSecondaryColor,
                                                    fontSize: isTab(context)
                                                        ? 9.sp
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              'hold_Your_Phone_At_Eye_Level_And_Looks_Straight_To_The_Camera'
                                                  .tr,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: tbrown,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.5.h,
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
          profileImage != null
              ? Button(
                  bottonText: 'save'.tr,
                  textcolor: tWhite,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    Map<String, String> param = {
                      'profile_image': profileImage.toString()
                    };
                    print(param);

                    var res = await DriverDetailsApi()
                        .uploadProfileImageApi(context, param);
                    if (res != null && res['status'] == 'OK') {
                      Twl.navigateTo(context, DrivingLicense());
                      _data.clearSecondSelectedImage();
                      stopLoading();
                    } else {
                      stopLoading();
                      Twl.createAlert(context, 'Oops', res['error'].toString());
                    }
                    stopLoading();
                  })
              : Button(
                  textcolor: tWhite,
                  bottonText: 'open_camera'.tr,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  onTap: profileImage == null || profileImage == '1'
                      ? (startLoading, stopLoading, btnState) async {
                          setState(() {
                            isLoading = true;
                          });
                          String imageUrl = await Twl().uploadImage();
                          if (imageUrl != null) {
                            print('Uploaded image URL: $imageUrl');
                            setState(() {
                              profileImage = imageUrl;
                              isLoading = false;
                            });
                            if (_storedData.rideDetailImagesList
                                .contains({'type': 1, 'image': profileImage})) {
                              _storedData.rideDetailImagesList
                                  .remove({'type': 1, 'image': profileImage});
                            } else {
                              _storedData.rideDetailImagesList
                                  .add({'type': 1, 'image': profileImage});
                            }

                            print(_storedData.rideDetailImagesList.toString());
                          } else {
                            print('Image upload failed or no image selected.');
                            setState(() {
                              profileImage = null;
                              isLoading = false;
                            });
                          }
                        }
                      : (startLoading, stopLoading, btnState) async {
                          startLoading();
                          print(_storedData.rideDetailImagesList.toString());
                          Twl.forceNavigateTo(context, TakeYourSelfie());
                          stopLoading();
                        },
                ),
          SizedBox(
            height: 2.h,
          )
        ],
      ),
    );
  }
}

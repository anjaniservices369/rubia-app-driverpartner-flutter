import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalWidgets/button.dart';
import '../../../responsive.dart';
import '../../api_services/userApi.dart';
import '../ride_info/Car_RideEndingData/DriveEndVerification_popup.dart';
import '../ride_info/componants/verification_popup.dart';

class EndingOdometerDetails extends StatefulWidget {
  const EndingOdometerDetails({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<EndingOdometerDetails> createState() => _EndingOdometerDetailsState();
}

class _EndingOdometerDetailsState extends State<EndingOdometerDetails> {
  TextEditingController _odometerController = TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  var endImg;
  bool endImgLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
      },
      child: Form(
        key: _formKey,
        child: Dialog(
          backgroundColor: tWhite,
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  //
                  Center(
                    child: Text(
                      "Ending Odometer Details".tr,
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: isTab(context) ? 16.sp : 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),

                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        endImgLoading = true;
                      });
                      String imageUrl = await Twl().uploadImage();
                      print('Uploaded image URL: $imageUrl');
                      setState(() {
                        print('object');
                        endImg = imageUrl;
                        print(endImg);
                        endImgLoading = false;
                      });
                    },
                    child: endImg == null
                        ? endImgLoading == false
                            ? Container(
                                height: 13.h,
                                width: 38.w,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(4)),
                                        child: Image.asset(
                                          // Images.FRONTCAMERA,
                                          Images.CAMERAICON,
                                          scale: 3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  color: tAppbarColor,
                                ),
                              )
                        : Container(
                            height: 13.h,
                            width: 38.w,
                            decoration: BoxDecoration(
                                color: tlightGray,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      endImg,
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(4)),
                                    child: Image.asset(
                                      // Images.FRONTCAMERA,
                                      Images.CAMERAICON,
                                      scale: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),

                  SizedBox(
                    height: 4.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _odometerController,
                    maxLines: 1,
                    decoration: InputDecoration(
                        fillColor: tWhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1.5, color: tgreen)),
                        // hintText: 'Write Reason ( Optional )',
                        hintStyle: TextStyle(color: tGray, fontSize: isTab(context) ? 7.sp : 10.sp, fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(),
                        enabledBorder:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: tgreen, width: 1.5))),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Button(
                    color: tPrimaryColor,
                    textcolor: tWhite,
                    bottonText: 'End'.tr,
                    borderSide: BorderSide(
                      color: tPrimaryColor,
                    ),
                    onTap: (startLoading, stopLoading, btnState) async {
                      startLoading();
                      print(endImg.toString());
                      print(_odometerController.text);

                      // Map<String, String> param = {
                      //   'booking_id': widget.bookingDetails['id'].toString(),
                      //   'odometer_end': _odometerController.text,
                      //   'odometer_end_image': endImg.toString()
                      // };
                      // print(param);
                      // print('aaaa');
                      // var res = await UserAPI().Endodometer(context, param);
                      // if (_formKey.currentState!.validate()) {
                      //   if (res != null && res['status'] == 'OK') {
                      //     if (endImg != null || endImg != '') {
                      //       showDialog(
                      //           context: context,
                      //           builder: (ctx) => Column(
                      //                 mainAxisAlignment: MainAxisAlignment.center,
                      //                 children: [DriveEndVerificationPopUp(bookingDetails: widget.bookingDetails)],
                      //               ));
                      //     } else {
                      //       stopLoading();
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //         content: Text('image upload manditory'),
                      //       ));
                      //       stopLoading();
                      //     }
                      //   } else {
                      //     stopLoading();
                      //     Twl.createAlert(context, 'oops', res['error']);
                      //     stopLoading();
                      //   }

                      //   stopLoading();
                      // }
                      if (endImg != null) {
                        stopLoading();
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: true,
                            title: 'End odometer',
                            desc: 'This is a confirmation of End odometer reading',
                            btnOkOnPress: () async {
                              startLoading();

                              Map<String, String> param = {
                                'booking_id': widget.bookingDetails['id'].toString(),
                                'odometer_end': _odometerController.text,
                                'odometer_end_image': endImg.toString()
                              };
                              var res = await UserAPI().Endodometer(context, param);

                              if (res != null && res['status'] == 'OK') {
                                print(param);
                                print('aaaa');

                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Sucessfully Updated'),
                                ));
                                showDialog(
                                    context: context,
                                    builder: (ctx) => Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [DriveEndVerificationPopUp(bookingDetails: widget.bookingDetails)],
                                        ));
                              } else {
                                stopLoading();
                                Twl.createAlert(context, 'Oops', res['error'].toString());
                                stopLoading();
                              }
                            },
                            btnOkColor: tPrimaryColor,
                            btnCancelOnPress: () {
                              Twl.navigateBack(context);
                            },
                            btnOkIcon: Icons.done,
                            btnCancelIcon: Icons.cancel,
                            btnCancelColor: Colors.red)
                          ..show();
                      } else {
                        stopLoading();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('All fields are manditory'),
                        ));
                        stopLoading();
                      }
                    },
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

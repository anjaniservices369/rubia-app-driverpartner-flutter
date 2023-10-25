import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../responsive.dart';
import 'drive_end_car-sides.dart';

class DriverEndUploadSelfie extends StatefulWidget {
  const DriverEndUploadSelfie({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<DriverEndUploadSelfie> createState() => _DriverEndUploadSelfieState();
}

class _DriverEndUploadSelfieState extends State<DriverEndUploadSelfie> {
  var selfeImage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tBackground,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.navigateBack(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: tDefaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "take_selfie".tr,
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontWeight: FontWeight.w800,
                    fontSize: isTab(context) ? 18.sp : 20.sp,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Before you End ride please upload selfie".tr,
                  // "Before_you_start_ride_please_selfie_along".tr,
                  style: GoogleFonts.mulish(
                    color: tbrown,
                    fontWeight: FontWeight.w600,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                  ),
                ),
                Text(
                  "with_car_number_plate".tr,
                  style: GoogleFonts.mulish(
                    color: tbrown,
                    fontWeight: FontWeight.w600,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                selfeImage == null
                    ? isLoading == false
                        ? Container(
                            width: 100.w,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
                            child: Image.asset(Images.SELFIWITHCAR, scale: isTab(context) ? 1 : 1),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: tAppbarColor,
                            ),
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 100.w,
                          height: 30.h,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
                          child: CachedNetworkImage(
                            imageUrl: selfeImage,
                            height: 100.h,
                            width: 30.w,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) => Image.asset(Images.SELFIWITHCAR, scale: isTab(context) ? 1 : 1),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(color: tPrimaryColor, borderRadius: BorderRadius.circular(35)),
                      child: Center(
                        child: Text(
                          '1',
                          style: TextStyle(color: tWhite, fontSize: isTab(context) ? 9.sp : 12.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              'good_Lighting'.tr,
                              style: TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 9.sp : 12.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'make_Sure_You_Are_In_A_Well_Lit_Area_And_Both_Ears_Are_Uncovered '.tr,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(color: tbrown, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(color: tPrimaryColor, borderRadius: BorderRadius.circular(35)),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(color: tWhite, fontSize: isTab(context) ? 9.sp : 12.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              'Look straight'.tr,
                              style: TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 9.sp : 12.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Hold your phone at eye level and looks straight to the camera'.tr,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(color: tbrown, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Button(
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: selfeImage == null ? 'Open Camera' : 'Next'.tr,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  onTap: selfeImage == null
                      ? (startLoading, stopLoading, btnState) async {
                          startLoading();
                          setState(() {
                            isLoading = true;
                          });
                          _storedData.rideEndedImagesList.clear();
                          String imageUrl = await Twl().uploadImage();

                          if (imageUrl != null) {
                            print('Uploaded image URL: $imageUrl');
                            setState(() {
                              stopLoading();
                              selfeImage = imageUrl;
                              isLoading = false;
                            });

                            _storedData.rideEndedImagesList.add({
                              "booking_id": widget.bookingDetails['id'].toString(),
                              "image": selfeImage,
                              "image_type": image_type_selfie.toString(),
                              "type": type_after_ride.toString()
                            });

                            print(_storedData.rideEndedImagesList.toString());
                          } else {
                            print('Image upload failed or no image selected.');
                            setState(() {
                              stopLoading();
                              selfeImage = null;
                              isLoading = false;
                            });
                          }
                        }
                      : (startLoading, stopLoading, btnState) async {
                          startLoading();
                          print(_storedData.rideEndedImagesList.toString());
                          Twl.forceNavigateTo(context, DriveEndCarSides(bookingDetails: widget.bookingDetails));
                          stopLoading();
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

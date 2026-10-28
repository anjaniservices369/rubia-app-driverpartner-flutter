// ----------------------------------------------------------------------
// Before ride: car photos
//
// Four photos of the car plus optional damage photos, uploaded to the
// server.
//
// Developer note: Posts driver/vehicle-verification with media URLs.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/ride_info/carNumberadd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import '../../../api_services/rideBookingsApi.dart';
import '../../../constants/imageConstant.dart';
import '../../../constants/stetuesConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../providers/hoempageProvider.dart';
import '../../../responsive.dart';
import 'driverUploadSelfie.dart';

// >>> START  class AllSidesPictures
class AllSidesPictures extends StatefulWidget {
  const AllSidesPictures({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;

  @override
  State<AllSidesPictures> createState() => _AllSidesPicturesState();
}
// <<< END    class AllSidesPictures

// >>> START  class _AllSidesPicturesState
class _AllSidesPicturesState extends State<AllSidesPictures> {
  final _formKey = new GlobalKey<FormState>();
  var firstImg;
  var secoundImg;
  var thirdImg;
  var fourthImg;
  var fivthImg;
  var sixthImg;

  bool firstImgLoading = false;
  bool secoundImgLoading = false;
  bool thirdImgLoading = false;
  bool fourthImgLoading = false;
  bool fivthImgLoading = false;
  bool sixthImgLoading = false;

  // >>> START  _AllSidesPicturesState.build()  -  draws this screen / widget (its layout)
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
            Twl.forceNavigateTo(context, DriverUploadSelfie(bookingDetails: widget.bookingDetails));
          },
        ),
        centerTitle: false,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.forceNavigateTo(context, DriverUploadSelfie(bookingDetails: widget.bookingDetails));
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(12)),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                            decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadiusDirectional.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Take car pictures".tr,
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
                                  "Before you start ride upload images of car".tr,
                                  style: GoogleFonts.mulish(
                                    color: tbrown,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTab(context) ? 10.sp : 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              firstImgLoading = true;
                                            });
                                            String imageUrl = await Twl().uploadImage();
                                            print('Uploaded image URL: $imageUrl');
                                            setState(() {
                                              firstImg = imageUrl;
                                              firstImgLoading = false;
                                            });
                                            if (_storedData.rideDetailImagesList.contains({
                                              "booking_id": widget.bookingDetails['id'].toString(),
                                              "image": firstImg,
                                              "image_type": image_type_front.toString(),
                                              "type": type_before_ride.toString()
                                            })) {
                                              _storedData.rideDetailImagesList.remove({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": firstImg,
                                                "image_type": image_type_front.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            } else {
                                              _storedData.rideDetailImagesList.add({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": firstImg,
                                                "image_type": image_type_front.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            }
                                          },
                                          child: firstImg == null
                                              ? firstImgLoading == false
                                                  ? Container(
                                                      height: 13.h,
                                                      width: 38.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
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
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            firstImg,
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
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              secoundImgLoading = true;
                                            });
                                            String imageUrl = await Twl().uploadImage();
                                            print('Uploaded image URL: $imageUrl');
                                            setState(() {
                                              secoundImg = imageUrl;
                                              secoundImgLoading = false;
                                            });
                                            if (_storedData.rideDetailImagesList.contains({
                                              "booking_id": widget.bookingDetails['id'].toString(),
                                              "image": secoundImg,
                                              "image_type": image_type_back.toString(),
                                              "type": type_before_ride.toString()
                                            })) {
                                              _storedData.rideDetailImagesList.remove({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": secoundImg,
                                                "image_type": image_type_back.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            } else {
                                              _storedData.rideDetailImagesList.add({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": secoundImg,
                                                "image_type": image_type_back.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            }

                                            print(_storedData.rideDetailImagesList.toString());
                                          },
                                          child: secoundImg == null
                                              ? secoundImgLoading == false
                                                  ? Container(
                                                      height: 13.h,
                                                      width: 38.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
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
                                                      image: secoundImg == null
                                                          ? null
                                                          : DecorationImage(
                                                              onError: (_, __) {}, // missing/failed image -> blank
                                                              image: NetworkImage(
                                                                secoundImg,
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
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              thirdImgLoading = true;
                                            });
                                            String imageUrl = await Twl().uploadImage();
                                            print('Uploaded image URL: $imageUrl');
                                            setState(() {
                                              thirdImg = imageUrl;
                                              thirdImgLoading = false;
                                            });
                                            if (_storedData.rideDetailImagesList.contains({
                                              "booking_id": widget.bookingDetails['id'].toString(),
                                              "image": thirdImg,
                                              "image_type": image_type_side_one.toString(),
                                              "type": type_before_ride.toString()
                                            })) {
                                              _storedData.rideDetailImagesList.remove({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": thirdImg,
                                                "image_type": image_type_side_one.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            } else {
                                              _storedData.rideDetailImagesList.add({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": thirdImg,
                                                "image_type": image_type_side_one.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            }

                                            print(_storedData.rideDetailImagesList.toString());
                                          },
                                          child: thirdImg == null
                                              ? thirdImgLoading == false
                                                  ? Container(
                                                      height: 13.h,
                                                      width: 38.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
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
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            thirdImg,
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
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              fourthImgLoading = true;
                                            });
                                            String imageUrl = await Twl().uploadImage();
                                            print('Uploaded image URL: $imageUrl');
                                            setState(() {
                                              fourthImg = imageUrl;
                                              fourthImgLoading = false;
                                            });
                                            if (_storedData.rideDetailImagesList.contains({
                                              "booking_id": widget.bookingDetails['id'].toString(),
                                              "image": fourthImg,
                                              "image_type": image_type_side_two.toString(),
                                              "type": type_before_ride.toString()
                                            })) {
                                              _storedData.rideDetailImagesList.remove({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": fourthImg,
                                                "image_type": image_type_side_two.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            } else {
                                              _storedData.rideDetailImagesList.add({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": fourthImg,
                                                "image_type": image_type_side_two.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            }

                                            print(_storedData.rideDetailImagesList.toString());
                                          },
                                          child: fourthImg == null
                                              ? fourthImgLoading == false
                                                  ? Container(
                                                      height: 13.h,
                                                      width: 38.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
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
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            fourthImg,
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
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Take any Damage picture".tr,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: isTab(context) ? 18.sp : 20.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              fivthImgLoading = true;
                                            });
                                            String imageUrl = await Twl().uploadImage();
                                            print('Uploaded image URL: $imageUrl');
                                            setState(() {
                                              fivthImg = imageUrl;
                                              fivthImgLoading = false;
                                            });
                                            if (_storedData.rideDetailImagesList.contains({
                                              "booking_id": widget.bookingDetails['id'].toString(),
                                              "image": fivthImg,
                                              "image_type": image_type_front.toString(),
                                              "type": type_before_ride.toString()
                                            })) {
                                              _storedData.rideDetailImagesList.remove({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": fivthImg,
                                                "image_type": image_type_front.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            } else {
                                              _storedData.rideDetailImagesList.add({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": fivthImg,
                                                "image_type": image_type_damages.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            }

                                            print(_storedData.rideDetailImagesList.toString());
                                          },
                                          child: fivthImg == null
                                              ? fivthImgLoading == false
                                                  ? Container(
                                                      height: 13.h,
                                                      width: 38.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
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
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            fivthImg,
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
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              sixthImgLoading = true;
                                            });
                                            String imageUrl = await Twl().uploadImage();
                                            print('Uploaded image URL: $imageUrl');
                                            setState(() {
                                              sixthImg = imageUrl;
                                              sixthImgLoading = false;
                                            });
                                            if (_storedData.rideDetailImagesList.contains({
                                              "booking_id": widget.bookingDetails['id'].toString(),
                                              "image": sixthImg,
                                              "image_type": image_type_damages.toString(),
                                              "type": type_before_ride.toString()
                                            })) {
                                              _storedData.rideDetailImagesList.remove({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": sixthImg,
                                                "image_type": image_type_damages.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            } else {
                                              _storedData.rideDetailImagesList.add({
                                                "booking_id": widget.bookingDetails['id'].toString(),
                                                "image": sixthImg,
                                                "image_type": image_type_damages.toString(),
                                                "type": type_before_ride.toString()
                                              });
                                            }

                                            print(_storedData.rideDetailImagesList.toString());
                                          },
                                          child: sixthImg == null
                                              ? sixthImgLoading == false
                                                  ? Container(
                                                      height: 13.h,
                                                      width: 38.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15), border: Border.all(color: tlightGray, width: 2)),
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
                                                          onError: (_, __) {}, // missing/failed image -> blank
                                                          image: NetworkImage(
                                                            sixthImg,
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
                                        )
                                      ],
                                    ),
                                  ],
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
                  startLoading();
                  print(jsonEncode(_storedData.rideDetailImagesList));
                  Map<String, String> params = {'json_data': jsonEncode(_storedData.rideDetailImagesList).toString()};

                  var res = await RideBookingsApi().getVehicleVerficationDetails(context, params);

                  if (res != null && res['status'] == 'OK') {
                    _storedData.rideDetailImagesList.clear();
                    if (firstImg != '' && firstImg != null &&
                        secoundImg != '' && secoundImg != null &&
                        thirdImg != '' && thirdImg != null &&
                        fourthImg != '' && fourthImg != null) {
                      _storedData.carPictureStatus = '1';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Sucessfully Updated'),
                      ));
                      Twl.forceNavigateTo(context, AddCarNumber(bookingDetails: widget.bookingDetails));
                    } else {
                      stopLoading();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('All fields are manditory'),
                      ));
                      stopLoading();
                    }
                  } else {
                    stopLoading();
                    Twl.createAlert(context, 'Oops', res['error']);
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
  // <<< END    _AllSidesPicturesState.build()
}
// <<< END    class _AllSidesPicturesState

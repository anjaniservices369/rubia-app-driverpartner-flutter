// ----------------------------------------------------------------------
// Rate the customer
//
// Star rating and review sheet shown after cash is collected.
//
// Developer note: Calls driver/add-review.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../responsive.dart';
import '../../order_completed/order_completed.dart';

// >>> START  class DriverAddReviews
class DriverAddReviews extends StatefulWidget {
  const DriverAddReviews({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<DriverAddReviews> createState() => _DriverAddReviewsState();
}
// <<< END    class DriverAddReviews

// >>> START  class _DriverAddReviewsState
class _DriverAddReviewsState extends State<DriverAddReviews> {
  final _formKey = new GlobalKey<FormState>();
  var givenRating;
  final TextEditingController _ratingController = TextEditingController();
  // >>> START  _DriverAddReviewsState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 0.h),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            Text(
              'are_you_satisfied_with_our_service'.tr,
              style: GoogleFonts.mulish(
                color: tSecondaryColor,
                fontSize: isTab(context) ? 12.sp : 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
                child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              unratedColor: tlightGray,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: isTab(context) ? 60 : 40,
              itemPadding: EdgeInsets.symmetric(horizontal: 0.4.h),
              itemBuilder: (context, _) => Icon(
                Icons.star_rounded,
                color: Colors.orange,
              ),
              onRatingUpdate: (rating) {
                givenRating = rating;
                print(givenRating);
              },
            )),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'add_review'.tr,
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontSize: isTab(context) ? 12.sp : 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _ratingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: tlightGray),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'write_a_review_to_driver'.tr,
                  ),
                  maxLines: 4,
                  onChanged: (text) {
                    setState(() {});
                  },
                )),
            SizedBox(
              height: 5.h,
            ),
            ArgonButton(
              height: isTab(context) ? 7.h : 6.8.h,
              width: isTab(context) ? 78.w : 80.w,
              color: tPrimaryColor,
              borderRadius: 30,
              borderSide: BorderSide(color: tPrimaryColor),
              child: Text(
                "submit".tr,
                style: TextStyle(
                    color: tWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: isTab(context) ? 12.sp : 14.sp),
              ),
              loader: Container(
                padding: EdgeInsets.all(20),
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                // Stars and a written review are both compulsory before the driver can go on.
                if (givenRating == null || givenRating == 0 || _ratingController.text.trim().isEmpty) {
                  Twl.createAlert(context, 'Review needed', 'Please give a rating and write a review for the customer to continue.');
                  return;
                }
                startLoading();
                Map<String, String> param = {
                  'booking_id': widget.bookingDetails['id'].toString(),
                  'rating': givenRating.toString(),
                  'review': _ratingController.text.trim()
                };
                var res = await RideBookingsApi()
                    .getAddReviewsAndRatings(context, param);
                if (res != null && res['status'] == 'OK') {
                  Twl.forceNavigateTo(context,
                      OrderCompletd(bookingDetails: widget.bookingDetails));
                } else {
                  Twl.createAlert(context, 'Oops', res['error'].toString());
                }
              },
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
  // <<< END    _DriverAddReviewsState.build()
}
// <<< END    class _DriverAddReviewsState

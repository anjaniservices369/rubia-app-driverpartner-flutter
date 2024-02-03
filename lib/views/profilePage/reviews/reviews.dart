import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  double _currentSliderValue = 20;
  double _curveSliderValue = 15;
  double _curveValue = 10;
  double _curvesValue = 5;
  double _curves = 5;

  ScrollController _scrollController = ScrollController();
  List<dynamic> ratingList = [];
  bool showBottomSheet = false;
  int page = 0;
  int totalPages = 0;
  int totalCount = 0;

  bool isLoading = false;
  String errorMessage = '';

  var reviewDetails;
  var resNOK;

  Future<void> fetchDriverReviews() async {
    setState(() {
      isLoading = true;
    });

    try {
      dynamic data = await RideBookingsApi().fetchDriverReviws(
        context,
        page.toString(),
      );
      setState(() {
        resNOK = data['status'];
        print("Resnok : $resNOK");
      });
        final List<dynamic> newBookings = data['details'];
        print('newBookings');
        print('nnnnnnnnnnneeeeeeeee${newBookings.toString()}');
        print('newBookings');


        final paginationData = data['pagination'];
        final ratingsList = data['rating'];

        setState(() {
          ratingList.addAll(newBookings);
          totalPages = paginationData['total_pages'];
          totalCount = paginationData['total_count'];
          reviewDetails = ratingsList;
          resNOK = data['status'];

          page++;
          isLoading = false;
          errorMessage = '';

          print('hjkhkjhkjhkjhkjh${reviewDetails}');
        });


    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch bookings.';
      });
    }
  }

  @override
  void initState() {
    fetchDriverReviews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tYellow,
        leading: GestureDetector(
          onTap: () {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
                color: tWhite,
                boxShadow: [tBoxShadow],
                borderRadius: BorderRadius.circular(6)),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: tBlue,
              size: 16,
            ),
          ),
        ),
        centerTitle: false,
        title: Text('Rating & Reviews',
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: resNOK == 'NOK' ? Container(
        child: Center(
          child : Text(
            "No Ratings Found",style: GoogleFonts.mulish(
            color: tBlack,
            fontSize: isTab(context) ? 18.sp : 16.sp,
            fontWeight: FontWeight.w700,
          ),
          ),
        ),
      ) : WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              reviewDetails == null
                  ? resNOK == 'NOK'
                      ? Column(
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 5),
                            Container(
                              alignment: Alignment.center,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/NoRatings.png',
                                    scale: 8,
                                  )),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text('No reviews available',
                                style: TextStyle(
                                    fontSize: isTab(context) ? 14.sp : 16.sp,
                                    color: tBlue,
                                    fontWeight: FontWeight.w700)),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.all(10),
                          child: SpinKitRotatingCircle(color: tAppbarColor),
                        )
                  : Container(
                      decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Card(
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: tWhite,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 12),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Rating:',
                                          style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: tBlue,
                                              fontSize: isTab(context)
                                                  ? 11.sp
                                                  : 14.sp,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          reviewDetails['total_rating'],
                                          style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: tBlue,
                                              fontSize: isTab(context)
                                                  ? 14.sp
                                                  : 18.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        Images.STAR,
                                        scale: 3,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        '5',
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Container(
                                        width: 60.w,
                                        child: LinearPercentIndicator(
                                          width: 60.w,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10.0,
                                          percent: reviewTotal(
                                                  int.parse(reviewDetails[
                                                          'rating_five']
                                                      .toString()),
                                                  int.parse(reviewDetails[
                                                          'total_rating']
                                                      .toString())) /
                                              100,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tBlue,
                                          backgroundColor: tlightGray,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 2.w,
                                      // ),
                                      Text(
                                        reviewDetails['rating_five'],
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 9.sp : 10.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.6.h,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        Images.STAR,
                                        scale: 3,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        '4',
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Container(
                                        width: 60.w,
                                        child: LinearPercentIndicator(
                                          width: 60.w,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10.0,
                                          percent: reviewTotal(
                                                  int.parse(reviewDetails[
                                                          'rating_four']
                                                      .toString()),
                                                  int.parse(reviewDetails[
                                                          'total_rating']
                                                      .toString())) /
                                              100,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tBlue,
                                          backgroundColor: tlightGray,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 2.w,
                                      // ),
                                      Text(
                                        reviewDetails['rating_four'],
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 9.sp : 10.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.6.h,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        Images.STAR,
                                        scale: 3,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        '3',
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Container(
                                        width: 60.w,
                                        child: LinearPercentIndicator(
                                          width: 60.w,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10.0,
                                          percent: reviewTotal(
                                                  int.parse(reviewDetails[
                                                          'rating_three']
                                                      .toString()),
                                                  int.parse(reviewDetails[
                                                          'total_rating']
                                                      .toString())) /
                                              100,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tBlue,
                                          backgroundColor: tlightGray,
                                        ),
                                      ),
                                      Text(
                                        reviewDetails['rating_three'],
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.6.h,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        Images.STAR,
                                        scale: 3,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Container(
                                        width: 60.w,
                                        child: LinearPercentIndicator(
                                          width: 60.w,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10.0,
                                          percent: reviewTotal(
                                                  int.parse(reviewDetails[
                                                          'rating_two']
                                                      .toString()),
                                                  int.parse(reviewDetails[
                                                          'total_rating']
                                                      .toString())) /
                                              100,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tBlue,
                                          backgroundColor: tlightGray,
                                        ),
                                      ),
                                      Text(
                                        reviewDetails['rating_two'],
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 0.6.h,
                                  ),
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        Images.STAR,
                                        scale: 3,
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        '1',
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Container(
                                        // width: 60.w,
                                        child: LinearPercentIndicator(
                                          width: 60.w,
                                          animation: true,
                                          animationDuration: 1000,
                                          lineHeight: 10.0,
                                          percent: reviewTotal(
                                                  int.parse(reviewDetails[
                                                          'rating_one']
                                                      .toString()),
                                                  int.parse(reviewDetails[
                                                          'total_rating']
                                                      .toString())) /
                                              100,
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tBlue,
                                          backgroundColor: tlightGray,
                                        ),
                                      ),
                                      Text(
                                        reviewDetails['rating_one'],
                                        style: TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 11.sp : 12.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 9,
              ),
              Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: tWhite,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: ListView.builder(
                  itemCount: ratingList.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var reviewList = ratingList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 1.h, horizontal: 3.5.w),
                      child: Container(
                        decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ClipOval(
                                  //   child: SizedBox.fromSize(
                                  //     size: Size.fromRadius(25), // Image radius
                                  //     child: Image.asset(
                                  //       Images.REVIEWER,
                                  //       fit: BoxFit.fill,
                                  //     ),
                                  //   ),
                                  // ),
                                  reviewList['driver_details']['selfie'] != null
                                      ? Container(
                                          height: isTab(context) ? 145 : 50,
                                          width: isTab(context) ? 145 : 50,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                reviewList['driver_details']
                                                        ['selfie']
                                                    .toString()),
                                            backgroundColor: tWhite,
                                            radius: isTab(context) ? 20 : 30,
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reviewList['driver_details']
                                                    ['first_name']
                                                .toString() +
                                            ' ' +
                                            reviewList['driver_details']
                                                    ['last_name']
                                                .toString(),
                                        style: TextStyle(
                                            color: tBlue,
                                            fontSize:
                                                isTab(context) ? 10.sp : 13.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            Images.STAR,
                                            scale: 4,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            reviewList['rating'].toString(),
                                            style: TextStyle(
                                                color: tBlue,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    Twl.dateFormate(reviewList['created_on'])
                                        .toString(),
                                    style: TextStyle(
                                        color: tLightBrown,
                                        fontSize: isTab(context) ? 9.sp : 12.sp,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                reviewList['review'].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: tLightBrown,
                                    fontSize: isTab(context) ? 9.sp : 10.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static reviewTotal(var actualValue, var totalValue) {
    final totalPrecentage = (actualValue / totalValue) * 100;
    return totalPrecentage;
  }
}

import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
  int page = 1;
  int totalPages = 0;
  int totalCount = 0;

  bool isLoading = false;
  String errorMessage = '';

  var reviewDetails;
  var resNOK;

  Future<void> fetchDriverReviews() async {
    if (page > totalPages) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      dynamic data = await RideBookingsApi().fetchDriverReviws(
        context,
        page.toString(),
      );
      final List<dynamic> newBookings = data['details'];
      final paginationData = data['pagination'];
      final ratingsList = data['rating'];

      setState(() {
        ratingList.addAll(newBookings);
        totalPages = paginationData['total_pages'];
        totalCount = paginationData['total_count'];
        reviewDetails = ratingsList;

        page++;
        isLoading = false;
        errorMessage = '';
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
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchDriverReviews();
      }
    });
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
            Twl.navigateBack(context);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: tWhite,
              boxShadow: [tBoxShadow],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: tBlue,
              size: 16,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          'Rating & Reviews',
          style: TextStyle(
            fontSize: isTab(context) ? 14.sp : 16.sp,
            color: tBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        color: tBackground,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Overall Rating Section
              Container(
                margin: EdgeInsets.only(
                  top: 1.h,
                  left: isTab(context) ? 5.w : 3.w,
                  right: isTab(context) ? 5.w : 3.w,
                ),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Overall Rating',
                          style: TextStyle(
                              fontSize: isTab(context) ? 16.sp : 18.sp,
                              fontWeight: FontWeight.bold,
                              color: tSecondaryColor),
                        ),
                        SizedBox(height: 1.h),
                        reviewDetails != null
                            ? Column(
                                children: [
                                  Text(
                                    reviewDetails['avg_rating'].toString(),
                                    style: TextStyle(
                                      fontSize: isTab(context) ? 48.sp : 54.sp,
                                      fontWeight: FontWeight.bold,
                                      color: tBlue,
                                    ),
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'from ',
                                        style: TextStyle(
                                          fontSize:
                                              isTab(context) ? 14.sp : 16.sp,
                                          color: tLightBrown,
                                        ),
                                      ),
                                      Text(
                                        reviewDetails['total_reviews']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize:
                                              isTab(context) ? 14.sp : 16.sp,
                                          color: tLightBrown,
                                        ),
                                      ),
                                      Text(
                                        ' reviews',
                                        style: TextStyle(
                                          fontSize:
                                              isTab(context) ? 14.sp : 16.sp,
                                          color: tLightBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 3.0,
                                          animationDuration: 2000,
                                          percent: double.parse(
                                              reviewDetails['percentage']
                                                  ['5_star']),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tGreen,
                                          backgroundColor:
                                              tLightBrown.withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          reviewDetails['percentage']['5_star'],
                                          style: TextStyle(
                                              fontSize: isTab(context)
                                                  ? 14.sp
                                                  : 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: tSecondaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 4,
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 3.0,
                                          animationDuration: 2000,
                                          percent: double.parse(
                                              reviewDetails['percentage']
                                                  ['4_star']),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tGreen,
                                          backgroundColor:
                                              tLightBrown.withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          reviewDetails['percentage']['4_star'],
                                          style: TextStyle(
                                              fontSize: isTab(context)
                                                  ? 14.sp
                                                  : 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: tSecondaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 3.0,
                                          animationDuration: 2000,
                                          percent: double.parse(
                                              reviewDetails['percentage']
                                                  ['3_star']),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tYellow,
                                          backgroundColor:
                                              tLightBrown.withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          reviewDetails['percentage']['3_star'],
                                          style: TextStyle(
                                              fontSize: isTab(context)
                                                  ? 14.sp
                                                  : 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: tSecondaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 4,
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 3.0,
                                          animationDuration: 2000,
                                          percent: double.parse(
                                              reviewDetails['percentage']
                                                  ['2_star']),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tYellow,
                                          backgroundColor:
                                              tLightBrown.withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          reviewDetails['percentage']['2_star'],
                                          style: TextStyle(
                                              fontSize: isTab(context)
                                                  ? 14.sp
                                                  : 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: tSecondaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: LinearPercentIndicator(
                                          animation: true,
                                          lineHeight: 3.0,
                                          animationDuration: 2000,
                                          percent: double.parse(
                                              reviewDetails['percentage']
                                                  ['1_star']),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: tRed,
                                          backgroundColor:
                                              tLightBrown.withOpacity(0.1),
                                        ),
                                      ),
                                      SizedBox(width: 1.h),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          reviewDetails['percentage']['1_star'],
                                          style: TextStyle(
                                              fontSize: isTab(context)
                                                  ? 14.sp
                                                  : 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: tSecondaryColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : SizedBox(
                                height: 10.h,
                                child: Center(
                                  child: SpinKitThreeBounce(
                                    color: tBlue,
                                    size: 25.sp,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),

              // Reviews Section
              Expanded(
                child: ratingList.isNotEmpty
                    ? RefreshIndicator(
                      onRefresh: () {
                        return fetchDriverReviews();
                      },
                  color: tAppbarColor,
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: ratingList.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == ratingList.length) {
                              if (isLoading) {
                                return Container(
                                  padding: EdgeInsets.all(2.h),
                                  child: Center(
                                    child: SpinKitThreeBounce(
                                      color: tBlue,
                                      size: 20.sp,
                                    ),
                                  ),
                                );
                              } else if (errorMessage.isNotEmpty) {
                                return Container(
                                  padding: EdgeInsets.all(2.h),
                                  child: Center(
                                    child: Text(
                                      errorMessage,
                                      style: TextStyle(
                                        fontSize: isTab(context) ? 14.sp : 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: tRed,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }

                            final review = ratingList[index];

                            return Container(
                              margin: EdgeInsets.only(
                                top: 1.h,
                                left: isTab(context) ? 5.w : 3.w,
                                right: isTab(context) ? 5.w : 3.w,
                              ),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(3.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 4.5.h,
                                            onBackgroundImageError: (_, __) {},
                                            backgroundImage: NetworkImage(
                                                review['user_image']),
                                          ),

                                          // AssetImage(
                                          //           ImageConstant.profilePlaceholder,
                                          //         ),
                                          SizedBox(width: 2.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                review['user_name'],
                                                style: TextStyle(
                                                    fontSize: isTab(context)
                                                        ? 16.sp
                                                        : 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: tSecondaryColor),
                                              ),
                                              SizedBox(height: 0.5.h),
                                              Text(
                                                DateFormat.yMMMMd().format(
                                                  DateTime.parse(
                                                      review['created_at']),
                                                ),
                                                style: TextStyle(
                                                  fontSize: isTab(context)
                                                      ? 14.sp
                                                      : 16.sp,
                                                  color: tLightBrown,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        review['review'],
                                        style: TextStyle(
                                            fontSize:
                                                isTab(context) ? 16.sp : 18.sp,
                                            color: tSecondaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    )
                    : Container(
                  padding: EdgeInsets.all(2.0),
                  child: Center(
                    child: Text(
                      'No reviews available.',
                      style: TextStyle(
                        fontSize: isTab(context) ? 14.0 : 16.0,
                        fontWeight: FontWeight.bold,
                        color: tLightBrown,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

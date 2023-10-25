import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../../../../api_services/rideBookingsApi.dart';
import '../../../../api_services/userApi.dart';
import '../../../../constants/imageConstant.dart';
import '../../../../constants/stetuesConstant.dart';

class TodaysEarnings extends StatefulWidget {
  const TodaysEarnings({Key? key, this.status}) : super(key: key);
  final status;
  @override
  State<TodaysEarnings> createState() => _TodaysEarningsState();
}

class _TodaysEarningsState extends State<TodaysEarnings> {
  ScrollController _scrollController = ScrollController();
  List<dynamic> earningsData = [];
  List<dynamic> dashboardDetails = [];
  bool showBottomSheet = false;
  int page = 0;
  int totalPages = 0;
  int totalCount = 0;

  bool isLoading = false;
  String errorMessage = '';
  var resNOK;

  List<String> TEXTLIST = [
    "rides".tr,
    "Km".tr,
    "Hours",
    "avg_rating".tr,
    "reject_rides".tr,
  ];
  List<String> TEXTLISTTWO = [
    "13",
    "190",
    "8",
    "4.5",
    "00",
  ];
  List<String> imglist = [
    'assets/icons/rides_earning.png',
    'assets/icons/distance.png',
    'assets/icons/time.png',
    'assets/icons/rating.png',
    'assets/icons/reject_rides.png',
  ];

  @override
  void initState() {
    fetchEarnings();
    fetcDashboardDetails();

    _scrollController.addListener(_scrollListener);
    // getTotalEarnings();
    super.initState();
  }

  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (page < totalPages) {
        print('Api reHitted');
        fetchEarnings();
      }
    }
  }

  var earningList = [];
  var earning;

  DateTime current_date = DateTime.now();
  var date = new DateTime.now();

  bool _load = false;
  var startDate;
  var endDate;
  var dashboardData;
  var dashboardList = [];

  // fetcDashboardDetails() async {
  //   var res = await RideBookingsApi().fetchEarningsDashboard(
  //     context,
  //   );
  //   if (res != null && res['status'] == 'OK') {
  //     setState(() {
  //       dashboardData = res['details'];
  //       resNOK = res['status'];

  //     });
  //   } else {
  //     setState(() {
  //       resNOK = res['status'];
  //     });
  //   }
  fetcDashboardDetails() async {
    var res = await RideBookingsApi().fetchEarningsDashboard(
      context,
    );
    if (res != null && res['status'] == 'OK') {
      setState(() {
        dashboardData = res['details'];
      });
    } else {
      setState(() {
        resNOK = res['status'];
      });
    }

    // setState(() {
    //   isLoading = true;
    // });
  }
  // var dashboard;
  // getTotalEarnings() async {
  //   var newDate = new DateTime(date.year, date.month, date.day + 1);
  //   setState(() {
  //     _load = true;
  //   });
  //   //startDate = formatter.format(now);

  //   // startDate = sharedPreferences.getString('startDate') != null
  //   //     ? sharedPreferences.getString('startDate')
  //   //     : startDate;
  //   // endDate = sharedPreferences.getString('endDate') != null
  //   //     ? sharedPreferences.getString('endDate')
  //   //     : endDate;

  //   startDate = Twl.dateFormate(DateTime.now()) + ' 00:00:00';
  //   endDate =
  //       Twl.dateFormate(DateTime.now().add(Duration(days: 1))) + ' 00:00:00';
  //   Map<String, String> params = {
  //     "status": "",
  //     // "start_date": current_date.toString(),
  //     "start_date": "2023-01-24",
  //     "end_date": newDate.toString()
  //     // "start_date": startDate.toString(),
  //     // "end_date": endDate.toString()
  //   };
  //   var res = await UserAPI().getTotalEarnings(context, '', '');
  //   print('resresres' + res.toString());
  //   if (res['status'] == 'OK') {
  //     setState(() {
  //       earningList = res['details'];
  //       earning = res['earnings'];
  //       print('khjh${earning}');
  //       TEXTLISTTWO = [
  //         earning['rides'].toString(),
  //         earning['total_km'].toString(),
  //         earning['total_hours'].toString(),
  //         earning['avg_rating'].toString(),
  //         earning['reject_rides'].toString(),
  //       ];
  //     });
  //   }
  //   setState(() {
  //     _load = false;
  //   });
  // }
  Future<void> fetchEarnings() async {
    setState(() {
      isLoading = true;
    });

    try {
      dynamic data = await RideBookingsApi().fetchEarningsList(
        context,
        page.toString(),
      );
      fetcDashboardDetails();
      final List<dynamic> newEarnings = data['details'];
      // final List<dynamic> newDashboard = data['dashboard'];
      print('Earnings');
      resNOK = data['status'];
      print(newEarnings.toString());
      print('Earnings');
      final paginationData = data['pagination'];

      setState(() {
        // dashboardDetails.addAll(newDashboard);
        print(totalCount);
        print('sdfaasd >>>>>>>>>');
        print(totalPages);
        earningsData.addAll(newEarnings);
        totalPages = paginationData['total_pages'];
        totalCount = paginationData['total_count'];
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

  var checkDetails;
  var resNok;
  fetchEarningDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var checkRes = await UserAPI().checkApi(pref.getString('authCode')!);
    if (checkRes != null && checkRes['status'] == 'OK') {
      if (checkRes['detail'] != null) {
        setState(() {
          checkDetails = checkRes['detail'];
        });
      }
    } else {
      setState(() {
        resNok = checkDetails['status'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        //  _load
        //     ? Container(
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       )
        //     :
        dashboardData == null
            ? resNOK == 'NOK'
                ? Align(
                    alignment: Alignment.center,
                    child: Text('No data found'),
                  )
                : Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: tAppbarColor,
                    ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        decoration: BoxDecoration(
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadius.circular(8),
                            color: tAppbarColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                if (dashboardData == null) ...[
                                  Text(
                                    currencySymbol + '0',
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize:
                                            isTab(context) ? 16.sp : 16.sp),
                                  )
                                ] else
                                  Text(
                                    currencySymbol +
                                        dashboardData['earnings'].toString(),
                                    //00000000.0000000.toStringAsFixed(2),
                                    // currencySymbol +
                                    //     earning['total_earnings'].toString(),
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 15.sp : 20.sp),
                                  ),
                                Text(
                                  // "total_earnings".tr,
                                  widget.status == 0
                                      ? 'Today’s Earnings '
                                      : widget.status == 1
                                          ? 'Last 7days Earnings'
                                          : widget.status == 2
                                              ? 'Last 30days Earnings'
                                              : widget.status == 3
                                                  ? 'Custom Earnings'
                                                  : 'Today’s Earnings',
                                  style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 8.sp : 10.sp),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 7.h,
                              width: 0.5.w,
                              decoration: BoxDecoration(
                                color: tWhite,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 0.4.h,
                                ),
                                if (dashboardData == null) ...[
                                  Text(
                                    currencySymbol + '0',
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize:
                                            isTab(context) ? 14.sp : 16.sp),
                                  )
                                ] else
                                  Text(
                                    currencySymbol +
                                        dashboardData['cash_collected']
                                            .toString(),
                                    // currencySymbol +
                                    //     "${earning['cash_colledcted']}",
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 15.sp : 20.sp),
                                  ),
                                Text(
                                  'cash_collected'.tr,
                                  // "  " + "Cash Collected" + " ",
                                  style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 8.sp : 10.sp),
                                ),
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 160,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    boxShadow: [tBoxShadow],
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal:
                                                    isTab(context) ? 6 : 6),
                                            child: Image.asset(
                                                'assets/icons/rides_earning.png',
                                                scale:
                                                    isTab(context) ? 1.5 : 4)),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dashboardData['rides'].toString(),
                                              style: GoogleFonts.mulish(
                                                  color: tBlue,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: isTab(context)
                                                      ? 11.sp
                                                      : 13.sp),
                                            ),
                                            Text(
                                              'rides',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.mulish(
                                                  color: tBlue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isTab(context)
                                                      ? 8.sp
                                                      : 10.sp),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Container(
                                width: 165,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    boxShadow: [tBoxShadow],
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal:
                                                    isTab(context) ? 6 : 6),
                                            child: Image.asset(
                                                'assets/icons/distance.png',
                                                scale:
                                                    isTab(context) ? 1.5 : 4)),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                double.parse(dashboardData['km']
                                                        .toString())
                                                    .toStringAsFixed(2),
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.mulish(
                                                    color: tBlue,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: isTab(context)
                                                        ? 11.sp
                                                        : 13.sp),
                                              ),
                                              Text(
                                                'km',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.mulish(
                                                    color: tBlue,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 10.sp),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 160,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    boxShadow: [tBoxShadow],
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal:
                                                    isTab(context) ? 6 : 6),
                                            child: Image.asset(
                                                'assets/icons/time.png',
                                                scale:
                                                    isTab(context) ? 1.5 : 4)),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                double.parse(
                                                        dashboardData['hours']
                                                            .toString())
                                                    .toStringAsFixed(2),
                                                style: GoogleFonts.mulish(
                                                    color: tBlue,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: isTab(context)
                                                        ? 11.sp
                                                        : 13.sp),
                                              ),
                                              Text(
                                                'Hours / minutes',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.mulish(
                                                    color: tBlue,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 10.sp),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Container(
                                width: 165,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: tWhite,
                                    boxShadow: [tBoxShadow],
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6,
                                                horizontal:
                                                    isTab(context) ? 6 : 6),
                                            child: Image.asset(
                                                // 'assets/icons/rating.png',
                                                'assets/icons/rating.png',
                                                scale:
                                                    isTab(context) ? 1.5 : 4)),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                dashboardData['avg_rating']
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.mulish(
                                                    color: tBlue,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: isTab(context)
                                                        ? 11.sp
                                                        : 13.sp),
                                              ),
                                              Text(
                                                'Avg Rating',
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                style: GoogleFonts.mulish(
                                                    color: tBlue,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 10.sp),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            width: 175,
                            height: 80,
                            decoration: BoxDecoration(
                                color: tWhite,
                                boxShadow: [tBoxShadow],
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: isTab(context) ? 6 : 6),
                                        child: Image.asset(
                                            'assets/icons/reject_rides.png',
                                            scale: 4)),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dashboardData['reject_rides']
                                                .toString(),
                                            style: GoogleFonts.mulish(
                                                color: tBlue,
                                                fontWeight: FontWeight.w800,
                                                fontSize: isTab(context)
                                                    ? 11.sp
                                                    : 13.sp),
                                          ),
                                          Text(
                                            'Reject Rides',
                                            maxLines: 1,
                                            overflow: TextOverflow.clip,
                                            style: GoogleFonts.mulish(
                                                color: tBlue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: isTab(context)
                                                    ? 8.sp
                                                    : 10.sp),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        earningsData.length == 0
                            ? Align(
                                alignment: Alignment.center, child: Container())
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                child: Row(
                                  children: [
                                    Text(
                                      "earnings_by_orders".tr,
                                      style: GoogleFonts.mulish(
                                          color: tBlue,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              isTab(context) ? 13.sp : 15.sp),
                                    ),
                                    Text(
                                      '(' +
                                          earningsData.length.toString() +
                                          ')',
                                      style: GoogleFonts.mulish(
                                          color: tLightBrown,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 13.sp : 15.sp),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(height: 1.h),
                        ListView.builder(
                            itemCount: earningsData.length,

                            // earningList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == earningsData.length) {
                                if (page < totalPages) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return resNOK == 'NOK'
                                      ? Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'No Bookings found',
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: isTab(context)
                                                      ? 9.sp
                                                      : 12.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          'No data found',
                                          style: GoogleFonts.mulish(
                                            color: tSecondaryColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                isTab(context) ? 9.sp : 12.sp,
                                          ),
                                        );
                                }
                              }
                              if (errorMessage.isNotEmpty)
                                Positioned.fill(
                                  child: Container(
                                    color: tSecondaryColor,
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          errorMessage,
                                          style: TextStyle(
                                            color: tSecondaryColor,
                                            fontSize: 18.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              var driverEarnings = earningsData[index];
                              // var data = earningList[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 3.5.w),
                                child: GestureDetector(
                                    onTap: () {
                                      // Twl.navigateTo(context, RideInfo());
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: tWhite,
                                            boxShadow: [tBoxShadow],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 2.h,
                                                    bottom: 1.h,
                                                    left: 3.5.w,
                                                    right: 3.5.w),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      driverEarnings['id']
                                                          .toString(),
                                                      style: GoogleFonts.mulish(
                                                        color: tBlue,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: isTab(context)
                                                            ? 9.sp
                                                            : 14.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                        currencySymbol +
                                                            driverEarnings[
                                                                        'price_detail']
                                                                    [
                                                                    'estimatePrice']
                                                                .toString(),
                                                        style:
                                                            GoogleFonts.mulish(
                                                          color: tBlue,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize:
                                                              isTab(context)
                                                                  ? 12.sp
                                                                  : 14.sp,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                    vertical: 0.8.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      Twl.dateReverseFormate(
                                                                  driverEarnings[
                                                                      'pickup_date'])
                                                              .toString() +
                                                          ', ' +
                                                          driverEarnings[
                                                                  'pickup_time']
                                                              .toString(),
                                                      style: GoogleFonts.mulish(
                                                        color: tLightBrown,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: isTab(context)
                                                            ? 9.sp
                                                            : 11.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4.w,
                                                    vertical: 0.8.h),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      driverEarnings[
                                                                  'trip_type'] ==
                                                              TRIP_TYPE_INTERCITY
                                                          ? 'In city'
                                                          : 'Out station',
                                                      style: GoogleFonts.mulish(
                                                        color: tLightBrown,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: isTab(context)
                                                            ? 9.sp
                                                            : 11.sp,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      driverEarnings[
                                                                  'rider_type'] ==
                                                              RIDER_TYPE_ONEWAY
                                                          ? 'One way'
                                                          : 'Round trip',
                                                      style: GoogleFonts.mulish(
                                                        color: tBlue,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: isTab(context)
                                                            ? 9.sp
                                                            : 11.sp,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              Divider(
                                                color: tSecondaryDivider,
                                                height: 2.h,
                                                thickness: 0.5,
                                              ),
                                              driverEarnings['rider_type'] ==
                                                      RIDER_TYPE_ONEWAY
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .all(isTab(
                                                                              context)
                                                                          ? 12
                                                                          : 8),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          tBackground,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: Image
                                                                      .asset(
                                                                    Images
                                                                        .LOCATIONGREEN,
                                                                    scale: isTab(
                                                                            context)
                                                                        ? 2
                                                                        : 3,
                                                                  )),
                                                              DottedLine(
                                                                direction: Axis
                                                                    .vertical,
                                                                lineLength: 30,
                                                                lineThickness:
                                                                    1.0,
                                                                dashLength: 4.0,
                                                                dashColor:
                                                                    tDotted,
                                                                // dashGradient: [Colors.red, Colors.blue],
                                                                // dashRadius: 0.0,
                                                                dashGapLength:
                                                                    4.0,
                                                                // dashGapColor: Colors ansparent,
                                                                // dashGapGradient: [Colors.red, Colors.blue],
                                                                dashGapRadius:
                                                                    0.0,
                                                              ),
                                                              // Column(
                                                              //   children: [
                                                              //     Container(
                                                              //       height: 0.6.h,
                                                              //       width: 0.5.w,
                                                              //       decoration: BoxDecoration(
                                                              //           color: tBlack,
                                                              //           shape: BoxShape.circle),
                                                              //     ),
                                                              //     Container(
                                                              //       height: 0.6.h,
                                                              //       width: 0.5.w,
                                                              //       decoration: BoxDecoration(
                                                              //           color: tBlack,
                                                              //           shape: BoxShape.circle),
                                                              //     ),
                                                              //     Container(
                                                              //       height: 0.6.h,
                                                              //       width: 0.5.w,
                                                              //       decoration: BoxDecoration(
                                                              //           color: tBlack,
                                                              //           shape: BoxShape.circle),
                                                              //     ),
                                                              //     Container(
                                                              //       height: 0.6.h,
                                                              //       width: 0.5.w,
                                                              //       decoration: BoxDecoration(
                                                              //           color: tBlack,
                                                              //           shape: BoxShape.circle),
                                                              //     ),
                                                              //     Container(
                                                              //       height: 0.6.h,
                                                              //       width: 0.5.w,
                                                              //       decoration: BoxDecoration(
                                                              //           color: tBlack,
                                                              //           shape: BoxShape.circle),
                                                              //     ),
                                                              //     Container(
                                                              //       height: 0.6.h,
                                                              //       width: 0.5.w,
                                                              //       decoration: BoxDecoration(
                                                              //           color: tBlack,
                                                              //           shape: BoxShape.circle),
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                              Container(
                                                                  padding: EdgeInsets
                                                                      .all(isTab(
                                                                              context)
                                                                          ? 12
                                                                          : 8),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          tBackground,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child: Image
                                                                      .asset(
                                                                    Images
                                                                        .REDLOCATIONICON,
                                                                    scale: isTab(
                                                                            context)
                                                                        ? 2
                                                                        : 3,
                                                                  )),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  driverEarnings[
                                                                          'pickup_address']
                                                                      .toString(),
                                                                  // rideDetails.pickupAddress.toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      GoogleFonts
                                                                          .mulish(
                                                                    color:
                                                                        tBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: isTab(
                                                                            context)
                                                                        ? 9.sp
                                                                        : 11.sp,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                // VerticalDivider(
                                                                //   width: 10,
                                                                //   color: tRed,
                                                                //   indent: 30,
                                                                // ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              2.h),
                                                                  width: double
                                                                      .infinity,
                                                                  height: 0.1.h,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color:
                                                                              tlightGray),
                                                                ),
                                                                Container(
                                                                    child: Text(
                                                                  driverEarnings[
                                                                      'drop_address'],
                                                                  // rideDetails.dropAddress.toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style:
                                                                      GoogleFonts
                                                                          .mulish(
                                                                    color:
                                                                        tBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize: isTab(
                                                                            context)
                                                                        ? 9.sp
                                                                        : 11.sp,
                                                                  ),
                                                                )),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                          color: tWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          boxShadow: [
                                                            tBoxShadow
                                                          ]),
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Row(children: [
                                                            Container(
                                                                child:
                                                                    Image.asset(
                                                              Images
                                                                  .LOCATIONGREEN,
                                                              scale:
                                                                  isTab(context)
                                                                      ? 2
                                                                      : 3.5,
                                                            )),
                                                            SizedBox(
                                                                width: 3.w),
                                                            Container(
                                                              width: 30.h,
                                                              child: Text(
                                                                driverEarnings[
                                                                        'pickup_address']
                                                                    .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    GoogleFonts
                                                                        .mulish(
                                                                  color:
                                                                      tSecondaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: isTab(
                                                                          context)
                                                                      ? 9.sp
                                                                      : 11.sp,
                                                                ),
                                                                maxLines: 4,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                          ]))),

                                              SizedBox(
                                                height: 2.h,
                                              ),

                                              // if (index == 1)
                                              // Column(
                                              //   crossAxisAlignment: CrossAxisAlignment.center,
                                              //   children: [
                                              //     Center(
                                              //       child: SizedBox(
                                              //         width: isTab(context) ? 30.w : 40.w,
                                              //         height: isTab(context) ? 6.h : 6.h,
                                              //         child: ButtonWidget(
                                              //             borderSide: BorderSide(
                                              //               color: tPrimaryColor,
                                              //             ),
                                              //             // borderRadius: BorderRadius.circular(15),
                                              //             borderRadius: 8.0,
                                              //             color: tPrimaryColor,
                                              //             textcolor: Colors.black,
                                              //             child: Text(
                                              //               "Track_Rider".tr,
                                              //               style: TextStyle(
                                              //                   letterSpacing: 1,
                                              //                   color: tWhite,
                                              //                   fontWeight: FontWeight.w700,
                                              //                   fontSize: isTab(context)
                                              //                       ? 10.sp
                                              //                       : 11.sp),
                                              //             ),
                                              //             onTap: (startLoading, stopLoading,
                                              //                 btnState) async {
                                              //               Twl.forceNavigateTo(
                                              //                   context, NotificationPage());
                                              //               // startLoading();
                                              //               // if (_formKey.currentState!.validate()) {
                                              //               //   // if (isChecked == true) {
                                              //               //   Map<String, String> param = {
                                              //               //     'contact_no': _usernumbercontroller.text,
                                              //               //   };
                                              //               //   print(param);
                                              //               //   var res =
                                              //               //       await UserAPI().sendOtp(context, param);
                                              //               //   if (res != null && res['status'] == 'OK') {
                                              //               //     Twl.navigateTo(
                                              //               //         context,
                                              //               //         Otppage(
                                              //               //           mobileNumber:
                                              //               //               _usernumbercontroller.text,
                                              //               //           sessionCode: res['details']
                                              //               //               ['Details'],
                                              //               //         ));
                                              //               //   } else {
                                              //               //     stopLoading();
                                              //               //     Twl.createAlert(context, 'Oops',
                                              //               //         res['error'].toString());
                                              //               //     stopLoading();
                                              //               //   }
                                              //               //   stopLoading();
                                              //               //   // } else {
                                              //               //   //   stopLoading();
                                              //               //   //   // return _showDialog(context);
                                              //               //   // }

                                              //               // }
                                              //               // stopLoading();
                                              //             }),
                                              //       ),
                                              //     ),
                                              //     SizedBox(
                                              //       height: 2.h,
                                              //     ),
                                              //   ],
                                              // )
                                            ]))),
                              );
                            })
                      ],
                    )
                  ],
                ),
              );
  }
}

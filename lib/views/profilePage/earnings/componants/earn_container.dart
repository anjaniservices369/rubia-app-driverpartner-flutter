// ----------------------------------------------------------------------
// Earnings summary
//
// Totals and chart for the selected period.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/profilePage/earnings/componants/rideDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../../../../api_services/rideBookingsApi.dart';
import '../../../../api_services/userApi.dart';

// >>> START  class TodaysEarnings
class TodaysEarnings extends StatefulWidget {
  const TodaysEarnings({Key? key, this.status}) : super(key: key);
  final status;
  @override
  State<TodaysEarnings> createState() => _TodaysEarningsState();
}
// <<< END    class TodaysEarnings

// >>> START  class _TodaysEarningsState
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

  // >>> START  _TodaysEarningsState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchEarnings();
    fetcDashboardDetails();

    _scrollController.addListener(_scrollListener);
    // getTotalEarnings();
    super.initState();
  }
  // <<< END    _TodaysEarningsState.initState()
  num sumCancellation = 0;

  // >>> START  _TodaysEarningsState.calculateCancellationSum()  -  calculate cancellation sum
  void calculateCancellationSum() {
    for (var booking in earningsData) {
        sumCancellation += (booking['cancellation_charges'] ?? 0);
    }
    setState(() {
      this.sumCancellation = sumCancellation;
      print("sum cancellation : $sumCancellation");
    });
  }
  // <<< END    _TodaysEarningsState.calculateCancellationSum()


  // >>> START  _TodaysEarningsState.dispose()  -  cleanup when the screen closes
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  // <<< END    _TodaysEarningsState.dispose()

  // >>> START  _TodaysEarningsState._scrollListener()  -  scroll listener
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (page < totalPages) {
        print('Api reHitted');
        fetchEarnings();
      }
    }
  }
  // <<< END    _TodaysEarningsState._scrollListener()

  var earningList = [];
  var earning;

  DateTime current_date = DateTime.now();
  var date = new DateTime.now();

  var startDate;
  var endDate;
  var dashboardData;
  var dashboardList = [];
  bool showDriverEarnings = true;

  // fetcDashboardDetails() async {
  //   var res = await RideBookingsApi().fetchEarningsDashboard(
  //     context,
  //   );
  //   if (res != null && res['status'] == 'OK') {
  //     setState(() {
  //       dashboardData = res['details'];
  //       resNOK = res['status'];

  // >>> START  _TodaysEarningsState.fetcDashboardDetails()  -  fetc dashboard details
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
  // <<< END    _TodaysEarningsState.fetcDashboardDetails()
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

  // >>> START  _TodaysEarningsState.fetchEarnings()  -  fetch earnings
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
        calculateCancellationSum();
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch bookings.';
      });
    }
  }
  // <<< END    _TodaysEarningsState.fetchEarnings()



  var checkDetails;
  var resNok;
  // >>> START  _TodaysEarningsState.fetchEarningDetails()  -  fetch earning details
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
  // <<< END    _TodaysEarningsState.fetchEarningDetails()

  // >>> START  _TodaysEarningsState.build()  -  draws this screen / widget (its layout)
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
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadius.circular(8),
                            color: tAppbarColor
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: tWhite,width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                  color: showDriverEarnings ? Colors.white : tAppbarColor,
                              ),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDriverEarnings = true;
                                    });
                                  },
                                child: Column(
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
                              ),
                            ),
                            // Container(
                            //   alignment: Alignment.center,
                            //   height: 7.h,
                            //   width: 0.5.w,
                            //   decoration: BoxDecoration(
                            //     color: tWhite,
                            //   ),
                            // ),
                            Container(
                              padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: tWhite,width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                  color: !showDriverEarnings ? Colors.white : tAppbarColor
                              ),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    showDriverEarnings=false;
                                  });
                                },
                                child: Column(
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
                                            (dashboardData['cash_collected']+ sumCancellation).toString(),
                                            // (dashboardData['cash_collected']).toString(),
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
                                ),
                              ),
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
                    rideDetails(earningsData:earningsData,page:page,totalPages:totalPages,resNOK:resNOK,errorMessage:errorMessage,showDriverEarnings:showDriverEarnings,status:widget.status)
                  ],
                ),
              );
  }
  // <<< END    _TodaysEarningsState.build()
}
// <<< END    class _TodaysEarningsState

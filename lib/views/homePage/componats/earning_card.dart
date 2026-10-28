// ----------------------------------------------------------------------
// Today's earnings tiles
//
// Today's earnings and cash collected.
// ----------------------------------------------------------------------
// import 'package:taxigo_rider_flutter/apiServices/userApi.dart';
// import 'package:taxigo_rider_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../responsive.dart';

// >>> START  class EarningsCard
class EarningsCard extends StatefulWidget {
  const EarningsCard({Key? key}) : super(key: key);

  @override
  State<EarningsCard> createState() => _EarningsCardState();
}
// <<< END    class EarningsCard

// >>> START  class _EarningsCardState
class _EarningsCardState extends State<EarningsCard> {
  // >>> START  _EarningsCardState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchPayOuts();
    super.initState();
  }
  // <<< END    _EarningsCardState.initState()

  var dashBordDetails;
  var resNOK;
  // >>> START  _EarningsCardState.fetchPayOuts()  -  fetch pay outs
  fetchPayOuts() async {
    var res = await RideBookingsApi().getDashBoardDetails(context);
    if (res != null && res['status'] == 'OK') {
      setState(() {
        dashBordDetails = res['details'];
      });
    } else {
      setState(() {
        resNOK = res['status'];
      });
    }
  }
  // <<< END    _EarningsCardState.fetchPayOuts()

  DateTime current_date = DateTime.now();
  var date = new DateTime.now();

  // >>> START  _EarningsCardState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return dashBordDetails == null
        ? resNOK == 'NOK'
            ? Container(
                // width: 95.w,
                // margin: EdgeInsets.only(top: 6, left: 10),
                // padding: EdgeInsets.symmetric(
                //   vertical: 2.h,
                // ),
                decoration: BoxDecoration(
                    color: tAppbarColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "₹ 0",
                            style: GoogleFonts.mulish(
                                fontSize: isTab(context) ? 14.sp : 20.sp,
                                fontWeight: FontWeight.w800,
                                color: tBlack),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "todays_earnings".tr,
                            style: GoogleFonts.mulish(
                                fontSize: isTab(context) ? 7.sp : 9.sp,
                                fontWeight: FontWeight.w600,
                                color: tBlack),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: tlightGray,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 3.3.h, horizontal: 0.2.w),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "₹ 0",
                            style: GoogleFonts.mulish(
                                fontSize: isTab(context) ? 14.sp : 20.sp,
                                fontWeight: FontWeight.w800,
                                color: tBlack),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            "cash_collected".tr,
                            style: GoogleFonts.mulish(
                                fontSize: isTab(context) ? 7.sp : 9.sp,
                                fontWeight: FontWeight.w600,
                                color: tBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : SpinKitThreeBounce(
                size: 10,
                color: tSecondaryColor,
              )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              // width: 95.w,
              // margin: EdgeInsets.only(right: 60, top: 6, left: 10),
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              decoration: BoxDecoration(
                  color: tAppbarColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currencySymbol +
                              dashBordDetails['driver_earnings_today']
                                  .toString(),
                          style: GoogleFonts.mulish(
                              fontSize: isTab(context) ? 14.sp : 20.sp,
                              fontWeight: FontWeight.w800,
                              color: tBlack),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "todays_earnings".tr,
                          style: GoogleFonts.mulish(
                              fontSize: isTab(context) ? 7.sp : 9.sp,
                              fontWeight: FontWeight.w600,
                              color: tBlack),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: tlightGray,
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 3.3.h, horizontal: 0.2.w),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currencySymbol +
                              dashBordDetails['driver_earnings_today_cash']
                                  .toString(),
                          // currencySymbol +
                          //     payoutDetails['totalCashCollection']
                          //         .toString(),
                          style: GoogleFonts.mulish(
                              fontSize: isTab(context) ? 14.sp : 20.sp,
                              fontWeight: FontWeight.w800,
                              color: tBlack),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "cash_collected".tr,
                          style: GoogleFonts.mulish(
                              fontSize: isTab(context) ? 7.sp : 9.sp,
                              fontWeight: FontWeight.w600,
                              color: tBlack),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
  // <<< END    _EarningsCardState.build()
}
// <<< END    class _EarningsCardState

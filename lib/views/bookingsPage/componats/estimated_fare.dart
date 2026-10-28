// ----------------------------------------------------------------------
// Estimated fare breakdown
//
// Explains the estimated fare.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/bookingsPage/componats/price_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';

// >>> START  class EstimateWidget
class EstimateWidget extends StatefulWidget {
  EstimateWidget({Key? key, this.estimateDetails, this.billDetails})
      : super(key: key);

  final estimateDetails;
  final billDetails;

  @override
  State<EstimateWidget> createState() => EstimateWidgetState();
}
// <<< END    class EstimateWidget

// >>> START  class EstimateWidgetState
class EstimateWidgetState extends State<EstimateWidget> {
  List<String> texts = [
    'beyond_1km'.tr,
    '1min_extra'.tr,
    'night_charge'.tr,
    'final_fare'.tr,
    'cancellation_fee'.tr,
  ];

  // >>> START  EstimateWidgetState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
 // 22 is 10 o'clock at night
//     // final tripOptionsProvider = Provider.of<TripOptionsProvider>(context);

//     final pickupTimeFormat = DateFormat('HH:mm');

//     // Parse the pickupTime string into a DateTime object
//     final pickupTime = pickupTimeFormat.parse(tripOptionsProvider.pickupTime);

// // // Check if the pickup time is between 6:00 am and 10:00 pm
//     final isDayTime = pickupTime.hour >= 6 && pickupTime.hour < 22;

//     final baseCharge = 10;
//     final coupondiscount = tripOptionsProvider.couponDiscount;

    // String baseChargeTitle =
    // isDayTime ? 'Base Charge (Day)' : 'Base Charge (Night)';

    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            color: tWhite,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [tBoxShadow]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.15,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Twl.navigateBack(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.close,
                      color: tBlue,
                      size: 24.0,
                    ),
                  ),
                ),
                EstimatePriceHeadWidget(),
                Divider(
                  color: tGray,
                ),
                SizedBox(height: 1.h),
                Text(
                    'A Final fare for your ${widget.estimateDetails['usageHours']} Hrs Trip',
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: isTab(context) ? 6.sp : 10.sp,
                    )),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Final Fare Details',
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 8.sp : 13.sp,
                          )),
                    ],
                  ),
                ),
                priceListWidget(
                  title: 'base Fare',
                  value: widget.billDetails['baseFare'].toString(),
                  // tripOptionsProvider.baseFare
                ),
                priceListWidget(
                    title: 'Additional Charges',
                    value: widget.billDetails['additionalCharges'].toString()
                    // tripOptionsProvider.platFormCharges
                    ),
                priceListWidget(
                    title: "GST", value: widget.billDetails['gst'].toString()),
                // priceListWidget(title: 'GST', value: tripOptionsProvider.gst),
                priceListWidget(
                  title: 'Night Charges',
                  value:
                      // isNightTime
                      //     ?

                      widget.billDetails['nightCharge'].toString(),
                  // : '0'
                  // tripOptionsProvider.securedFee
                ),
                priceListWidget(
                    title: 'Secured Fee',
                    value: widget.billDetails['securedFee'].toString()
                    // tripOptionsProvider.securedFee
                    ),

                priceListWidget(
                    title: 'Platform Charges',
                    value: widget.billDetails['platformCharges'].toString()
                    // tripOptionsProvider.platFormCharges
                    ),

                // Padding(
                //   padding: const EdgeInsets.all(10.0),
                //   child: Row(
                //     children: [
                //       Text('Rounding Up',
                //           style: GoogleFonts.mulish(
                //             color: tSecondaryColor,
                //             fontWeight: FontWeight.w400,
                //             fontSize: isTab(context) ? 7.sp : 12.sp,
                //           )),
                //       Spacer(),
                //       Text(" $currencySymbol 0.49",
                //           style: GoogleFonts.mulish(
                //             color: tSecondaryColor,
                //             fontWeight: FontWeight.w500,
                //             fontSize: isTab(context) ? 7.sp : 12.sp,
                //           )),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: 1.h,
                ),
                Divider(
                  color: tGray,
                ),
                // SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Final Fare',
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 7.sp : 12.sp,
                          )),
                      Spacer(),
                      Text(
                          currencySymbol +
                              '${widget.estimateDetails['final_price'].toString()} ',
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 7.sp : 12.sp,
                          )),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 1.h,
                // ),
                Divider(
                  color: tGray,
                ),
                Expanded(
                  child: Container(
                    // height: 20.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 13.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: tBlack,
                                    width: 0.3.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    texts[index],
                                    style: TextStyle(
                                      color: tBlack,
                                      fontWeight: FontWeight.w400,
                                      fontSize: isTab(context) ? 6.sp : 9.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 1.h,
                // ),
                GestureDetector(
                  onTap: () {
                    Twl.navigateBack(context);
                  },
                  child: Container(
                    width: 40.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: tPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text('Got It',
                          style: GoogleFonts.mulish(
                            color: tWhite,
                            fontWeight: FontWeight.w500,
                            fontSize: isTab(context) ? 8.sp : 14.sp,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // <<< END    EstimateWidgetState.build()
}
// <<< END    class EstimateWidgetState

// >>> START  class EstimatePriceHeadWidget
class EstimatePriceHeadWidget extends StatelessWidget {
  const EstimatePriceHeadWidget({
    Key? key,
  }) : super(key: key);

  // >>> START  EstimatePriceHeadWidget.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Driver\'s Final Bill',
              style: GoogleFonts.mulish(
                color: tSecondaryColor,
                fontWeight: FontWeight.w700,
                fontSize: isTab(context) ? 10.sp : 16.sp,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Center(
              child: Container(
                child: Text('Professional,background-',
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: isTab(context) ? 8.sp : 12.sp,
                    )),
              ),
            ),
            Text('verified,trained and tested drivers',
                style: GoogleFonts.mulish(
                  color: tSecondaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: isTab(context) ? 8.sp : 12.sp,
                )),
          ],
        ),
      ),
    );
  }
  // <<< END    EstimatePriceHeadWidget.build()
}
// <<< END    class EstimatePriceHeadWidget

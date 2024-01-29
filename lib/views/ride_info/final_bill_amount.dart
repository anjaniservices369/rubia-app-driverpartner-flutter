import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/bookingsPage/componats/price_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';
import '../../constants/stetuesConstant.dart';

class FinalBillAmountWidget extends StatefulWidget {
  FinalBillAmountWidget({Key? key, this.estimateDetails, this.billDetails}) : super(key: key);

  final estimateDetails;
  final billDetails;
  @override
  State<FinalBillAmountWidget> createState() => FinalBillAmountWidgetState();
}

class FinalBillAmountWidgetState extends State<FinalBillAmountWidget> {
  var extraMin = 2;
  var nightCharges = 300;
  dynamic cancellationCharge = 100;
  late List<String> texts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cancellationCharge = widget.estimateDetails['driverCancellationCharge'];
    getCharges();
    texts = [
      'If the trip extends time,extra charges as $currencySymbol $extraMin per extra min applicable.',
      'Night Charge $currencySymbol $nightCharges on drives ending between 10:00PM & 05:59AM.',
      'Final Fare will be Charged on time basis.',
      'According to our Cancellation Policy,Charge of  $currencySymbol $cancellationCharge on Cancellation.',
      'Maximum driver\'s duty can be 12 hours.'
    ];

  }

  void getCharges() {
    if(widget.estimateDetails['trip_type'] == TRIP_TYPE_INTERCITY && widget.estimateDetails['rider_type'] == RIDER_TYPE_ROUNDTRIP){
      setState(() {
        extraMin = widget.estimateDetails['price_detail']['extraMinCharge'];
        nightCharges = widget.estimateDetails['night_charge'];
      });
    }else if(widget.estimateDetails['trip_type'] == TRIP_TYPE_INTERCITY && widget.estimateDetails['rider_type'] == RIDER_TYPE_ONEWAY){
      setState(() {
        extraMin = widget.estimateDetails['price_detail']['extraMinCharge'];
        nightCharges = widget.estimateDetails['night_charge'];
      });
    }else if(widget.estimateDetails['trip_type'] == TRIP_TYPE_OUTSTATION && widget.estimateDetails['rider_type'] == RIDER_TYPE_ROUNDTRIP){
      setState(() {
        extraMin = widget.estimateDetails['price_detail']['extraMinCharge'];
        nightCharges = widget.estimateDetails['night_charge'];
      });
    }else if(widget.estimateDetails['trip_type'] == TRIP_TYPE_OUTSTATION && widget.estimateDetails['rider_type'] == RIDER_TYPE_ONEWAY){
      setState(() {
        extraMin = widget.estimateDetails['price_detail']['extraMinCharge'];
        nightCharges = widget.estimateDetails['night_charge'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

    double? usageHours = double.parse(widget.estimateDetails['usage_hours']);

    String usageText;
    if (usageHours != null) {
      if (usageHours >= 1) {
        int wholeHours = usageHours.toInt();
        int wholeMinutes = ((usageHours - wholeHours) * 60).toInt();
        if (wholeMinutes > 0) {
          usageText = '$wholeHours hrs $wholeMinutes mins usage';
        } else {
          usageText = '$wholeHours hrs usage';
        }
      } else {
        int usageMinutes = (usageHours * 60).toInt();
        usageText = '$usageMinutes mins usage';
      }
    } else {
      usageText = 'Usage hours not available'; // Handle the case where 'usage_hours' is null
    }

    return SingleChildScrollView(
      child: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.all(Radius.circular(30)), boxShadow: [tBoxShadow]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.1,
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
                FinalPriceHeadWidget(),
                Divider(
                  color: tGray,
                ),
                SizedBox(height: 1.h),

                Text('A fare final amount for your ${usageText} Trip',
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: isTab(context) ? 6.sp : 10.sp,
                    )),

                SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                // if (widget.billDetails['estimatePrice'] > 0)
                //   priceListWidget(
                //     title: 'Estimate Price',
                //     value: currencySymbol +
                //         widget.billDetails['estimatePrice'].toString(),
                //   ),
                if (widget.billDetails['baseFare'] > 0)
                  priceListWidget(
                    title: 'Base Fare',
                    value: currencySymbol + widget.billDetails['baseFare'].toString(),
                  ),
                // if (widget.billDetails['baseHour'] > 0)
                //   priceListWidget(
                //     title: 'Base Hour',
                //     value: widget.billDetails['baseHour'].toString() + ' hours',
                //   ),
                if (widget.billDetails['additionalCharges'] > 0)
                  priceListWidget(
                    title: 'Additional Charges',
                    value: currencySymbol + widget.billDetails['additionalCharges'].toString(),
                  ),
                if (widget.estimateDetails['cancellation_charges'] !=null && widget.estimateDetails['cancellation_charges'] > 0)
                  priceListWidget(
                    title: 'Cancellation Charges',
                    value: currencySymbol + (widget.estimateDetails['cancellation_charges'] ?? 0).toStringAsFixed(0),
                  ),

                if (widget.billDetails['gst'] > 0)
                  priceListWidget(
                    title: 'GST',
                    value: currencySymbol + widget.billDetails['gst'].toString(),
                  ),
                if (widget.billDetails['securedFee'] != '0')
                  priceListWidget(
                    title: 'Secured Fee',
                    value: currencySymbol + widget.billDetails['securedFee'],
                  ),
                if (widget.billDetails['platformCharges'] != '0')
                  priceListWidget(
                    title: 'Platform Charges',
                    value: currencySymbol + widget.billDetails['platformCharges'],
                  ),
                if (widget.estimateDetails['coupon_discount'] > 0)
                  priceListWidget(
                    title: 'Coupon Discount',
                    value: '- ' + currencySymbol + widget.estimateDetails['coupon_discount'].toString(),
                  ),
                // if (widget.billDetails['baseKm'] > 0)
                //   priceListWidget(
                //     title: 'Base Kilometers',
                //     value: widget.billDetails['baseKm'].toString() + ' km',
                //   ),
                // if (widget.billDetails['extraKmCharge'] > 0)
                //   priceListWidget(
                //     title: 'Extra Kilometer Charge',
                //     value: currencySymbol +
                //         widget.billDetails['extraKmCharge'].toString(),
                //   ),
                // if (widget.billDetails['extraMinCharge'] > 0)
                //   priceListWidget(
                //     title: 'Extra Minute Charge',
                //     value: currencySymbol +
                //         widget.billDetails['extraMinCharge'].toString(),
                //   ),
                if (widget.billDetails['nightCharge'] > 0)
                  priceListWidget(
                    title: 'Night Charge',
                    value: currencySymbol + widget.billDetails['nightCharge'].toString(),
                  ),
                if (widget.billDetails['outStationCharge'] > 0)
                  priceListWidget(
                    title: 'Outstation Charge',
                    value: currencySymbol + widget.billDetails['outStationCharge'].toString(),
                  ),

                // if (widget.billDetails['estimatedDistance'] > 0)
                //   priceListWidget(
                //     title: 'Estimated Distance',
                //     value: widget.billDetails['estimatedDistance'].toString() +
                //         ' km',
                //   ),
                // if (widget.billDetails['isNightChargeApplicable'])
                //   priceListWidget(
                //     title: 'Night Charge Applicable',
                //     value: 'Yes',
                //   ),
                // if (widget.billDetails['usageHours'] > 0)
                //   priceListWidget(
                //     title: 'Usage Hours',
                //     value:
                //         widget.billDetails['usageHours'].toString() + ' hours',
                //   ),
                // priceListWidget(
                //   title: widget.billDetails['isNightChargeApplicable'] == false
                //       ? ''
                //       : 'Night Charges',
                //   value:
                //       // isNightTime
                //       //     ?
                //       widget.billDetails['isNightChargeApplicable'] == false
                //           ? ''
                //           : currencySymbol +
                //               widget.billDetails['nightCharge'].toString(),
                //   // : '0'
                //   // tripOptionsProvider.securedFee
                // ),
                SizedBox(
                  height: 0.5.h,
                ),
                Divider(
                  color: tGray,
                ),
                // SizedBox(height: 1.h),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Final Price',
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 7.sp : 12.sp,
                          )),
                      Spacer(),
                      Text(currencySymbol + '${((widget.estimateDetails['price_detail']['estimatePrice'] + (widget.estimateDetails['cancellation_charges'] ?? 0)).toStringAsFixed(0))} ',
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
                                height: 14.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: tBlack,
                                    width: 0.3.w,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
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

                SizedBox(
                  height: 1.h,
                ),
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
}

class FinalPriceHeadWidget extends StatelessWidget {
  const FinalPriceHeadWidget({
    Key? key,
  }) : super(key: key);

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
}

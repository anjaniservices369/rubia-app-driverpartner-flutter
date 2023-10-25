import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';

import 'package:base_project_flutter/responsive.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../constants/imageConstant.dart';

import '../../constants/stetuesConstant.dart';
import 'HistoryBottomSheet.dart';

class TransactionDetailsWidget extends StatefulWidget {
  const TransactionDetailsWidget({
    Key? key,
    this.selectedType,
  }) : super(key: key);
  final selectedType;
  @override
  _TransactionDetailsWidgetState createState() =>
      _TransactionDetailsWidgetState();
}

class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
  RideBookingsApi rideAPI = RideBookingsApi();
  List<dynamic> transactonData = [];
  bool isLoading = false;
  bool descTextShowFlag = false;
  int currentPage = 0;
  ScrollController _scrollController = ScrollController();
  bool selected = true;
  List imageView = [
    Images.DOWNRED,
    Images.UPGREEN,
    Images.DOWNRED,
    Images.UPGREEN,
  ];
  List title = ["Debit".tr, "Credit".tr, "Debit".tr, "Credit".tr];
  List amount = ["-₹4.0", "+₹100.0", "-₹4.0", "+₹100.0"];
  @override
  void initState() {
    super.initState();
    print('selected typr ' + widget.selectedType.toString());
    fetchTransaction();
    print('object');
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchTransaction();
      }
    });
  }

  Future<void> fetchTransaction() async {
    print('hhiii');
    if (isLoading) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      dynamic response = await RideBookingsApi()
          .walletTransactionWithoutModel(context, currentPage.toString());
      print('response');
      print(response);
      print('response');
      List<dynamic> newTransactionData = response['details'] ?? [];
      setState(() {
        transactonData.addAll(newTransactionData);
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching Transaction: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
              decoration: BoxDecoration(
                  color: tWhite,
                  boxShadow: [tBoxShadow],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Text(
                    "All_Transactions".tr,
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontSize: isTab(context) ? 13.sp : 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      print(widget.selectedType.toString());
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12))),
                          context: context,
                          builder: (context) => Container(
                                height: isTab(context) ? 40.h : 40.h,
                                child: HistoryBottomSheet(
                                  walletTranscation: true,
                                ),
                              ));
                    },
                    child: Row(
                      children: [
                        Text(
                          widget.selectedType == null
                              ? 'Today'.tr
                              : widget.selectedType.toString(),
                          style: GoogleFonts.mulish(
                            color: tPrimaryColor,
                            fontSize: isTab(context) ? 12.sp : 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          selected
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          size: isTab(context) ? 45 : 30,
                          color: tPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.h,
        ),
        ListView.builder(
            controller: _scrollController,
            itemCount: transactonData.length + 1,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              if (index == transactonData.length) {
                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }
              var transcationDetail = transactonData[index];
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.5.h, vertical: 0.3.h),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: tWhite, borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 1.h),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: tBackground),
                                  child: transcationDetail['payment_type'] ==
                                          payment_type_credit
                                      ? Image.asset(
                                          Images.UPGREEN,
                                          color: tGreen,
                                          scale: 3,
                                        )
                                      : Image.asset(
                                          Images.DOWNRED,
                                          color: tRed,
                                          scale: 3,
                                        )),
                              SizedBox(
                                width: 1.h,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    transcationDetail['payment_type'] ==
                                            payment_type_debit
                                        ? Text(
                                            'Debit'.tr,
                                            style: GoogleFonts.mulish(
                                                fontSize: isTab(context)
                                                    ? 10.sp
                                                    : 13.sp,
                                                fontWeight: FontWeight.w700,
                                                color: tSecondaryColor),
                                          )
                                        : Text(
                                            'Credit'.tr,
                                            style: GoogleFonts.mulish(
                                                fontSize: isTab(context)
                                                    ? 10.sp
                                                    : 13.sp,
                                                fontWeight: FontWeight.w700,
                                                color: tSecondaryColor),
                                          ),
                                    SizedBox(height: 0.5.h),
                                    Text(
                                      Twl.dateFormate(
                                              transcationDetail['updated_on'])
                                          .toString(),
                                      style: GoogleFonts.mulish(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: tSecondaryColor),
                                    ),
                                    SizedBox(height: 0.5.h),
                                    Text(
                                      transcationDetail['method_reason'],
                                      maxLines: 3,
                                      overflow: TextOverflow.visible,
                                      style: GoogleFonts.mulish(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                          color: tSecondaryColor),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 1.h,
                                  ),
                                  transcationDetail['payment_type'] ==
                                          payment_type_credit
                                      ? Text(
                                          currencySymbol +
                                              '+' +
                                              transcationDetail['amount']
                                                  .toString(),
                                          style: GoogleFonts.mulish(
                                            fontSize:
                                                isTab(context) ? 9.sp : 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: tGreen,
                                          ))
                                      : Text(
                                          currencySymbol +
                                              '-' +
                                              transcationDetail['amount']
                                                  .toString(),
                                          style: GoogleFonts.mulish(
                                            fontSize:
                                                isTab(context) ? 9.sp : 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: tRed,
                                          )),
                                ],
                              )
                            ],
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
            })
      ],
    );
  }
}

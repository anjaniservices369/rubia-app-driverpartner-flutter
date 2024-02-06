import 'package:base_project_flutter/views/wallet/walletpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api_services/DriverDetailApis.dart';
import '../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../responsive.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';
import '../collect_payment.dart/componants/collect_cash_botomsheet.dart';
import '../profile_review/profile_review.dart';
import 'AmountReview.dart';
import 'components.dart';


class QRPayment extends StatefulWidget {
  const QRPayment({Key? key}) : super(key: key);

  get bookingDetails => null;

  @override
  State<QRPayment> createState() => _QRPayment();
}




class _QRPayment extends State<QRPayment> {

  void _launchDialer(String phoneNumber) async {
    final url = 'tel://$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showContactInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Information', style: GoogleFonts.mulish(
            color: tBlack,
            fontSize: isTab(context) ? 16.sp : 14.sp,
            fontWeight: FontWeight.w800,
          ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Phone: +91 78936 53899',style: GoogleFonts.mulish(
                color: tBlack,
                fontSize: isTab(context) ? 16.sp : 14.sp,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 10),
              Text('Email: rubia.services@gmail.com',style: GoogleFonts.mulish(
                color: tBlack,
                fontSize: isTab(context) ? 14.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 10),
              Text('Address:  Rubia Services(OPC) Pvt.Ltd Lig 60/5, 4th Phase, KPHB Colony, Hyderabad, 500085' ,style: GoogleFonts.mulish(
                color: tBlack,
                fontSize: isTab(context) ? 14.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    child: Button(
                      color: tPrimaryColor,
                      textcolor: tWhite,
                      bottonText: 'Call'.tr,
                      borderSide: BorderSide(color: tPrimaryColor),
                      onTap: (startLoading, stopLoading, btnState) async {
                        launch(
                            "tel://+917893653899"
                        );
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Button(
                      color: tPrimaryColor,
                      textcolor: tWhite,
                      bottonText: 'Location'.tr,
                      borderSide: BorderSide(color: tPrimaryColor),
                      onTap: (startLoading, stopLoading, btnState) async {
                        MapsLauncher.launchCoordinates(17.4739803, 78.3886243);
                      },
                    ),
                  ),
                ],
              ),

            ],
          ),
          actions: [
            Center(
              child: Container(
                child: Button(
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: 'OK'.tr,
                  borderSide: BorderSide(color: tPrimaryColor),
                  onTap: (startLoading, stopLoading, btnState) async{
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SizedBox(
              height:2.h,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tYellow,
        leading: GestureDetector(
          onTap: () {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
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
        title: Text('QR Payment'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
        },
        child: SingleChildScrollView(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 2.h),
              Center(

                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Recharge_with_QR".tr,
                    style: GoogleFonts.mulish(
                      color: tBlack,
                      fontSize: isTab(context) ? 16.sp : 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Image.asset(
                Images.JOINING_QR_CODE,
                scale: 2,
              ),
              SizedBox(height: 2.h),
              Text(
                "UPI id : 9490845226@yesbank",
                style: GoogleFonts.mulish(
                  color: tBlack,
                  fontSize: isTab(context) ? 16.sp : 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 2.h),
              Center(

                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Send_Screenshot".tr,
                    style: GoogleFonts.mulish(
                      color: tBlack,
                      fontSize: isTab(context) ? 16.sp : 14.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Column(
                children: [
                  Center(
                    child: Button(
                      borderSide: BorderSide(
                        color: tPrimaryColor,
                      ),
                      textcolor: tWhite,
                      color: tPrimaryColor,
                      bottonText: "Contact Us".tr,
                      onTap: (startLoading, stopLoading, btnState) {
                        _showContactInfoDialog(context);
                      },
                    ),
                  ),

                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Button(
                      borderSide: BorderSide(
                        color: tPrimaryColor,
                      ),
                      textcolor: tWhite,
                      color: tPrimaryColor,
                      bottonText: "Continue".tr,
                      onTap: (startLoading, stopLoading, btnState) {
                        Twl.forceNavigateTo(context, AmountReview());
                      },
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
    );

  }

}










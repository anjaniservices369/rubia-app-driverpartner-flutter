// ----------------------------------------------------------------------
// Subscription by QR
//
// Pay a plan by QR and confirm with support.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/views/profilePage/subscription/subscription.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_services/DriverDetailApis.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../responsive.dart';
import 'SubscriptionReview.dart';



// >>> START  class QRSubscriptionPage
class QRSubscriptionPage extends StatefulWidget {
  const QRSubscriptionPage({Key? key,this.price}) : super(key: key);
  final price;

  get bookingDetails => null;

  @override
  State<QRSubscriptionPage> createState() => _QRSubscriptionPageState();
}
// <<< END    class QRSubscriptionPage


// >>> START  _showContactInfoDialog()  -  show contact info dialog
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
                      launchUrl(Uri.parse("tel://+917893653899"));
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
// <<< END    _showContactInfoDialog()


// >>> START  class _QRSubscriptionPageState
class _QRSubscriptionPageState extends State<QRSubscriptionPage> {

  // >>> START  _QRSubscriptionPageState.showConfirmationDialog()  -  show confirmation dialog
  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation",style: GoogleFonts.mulish(
            color: tBlack,
            fontSize: isTab(context) ? 16.sp : 14.sp,
            fontWeight: FontWeight.w800,
          ),),
          content: Text("Are_you_sure".tr),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    // gradient: tPrimaryGradientColor,
                      border: Border.all(
                          width: 1, color: tPrimaryColor),
                      borderRadius: BorderRadius.circular(6)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Cancel", style: TextStyle(color: tPrimaryColor)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    // gradient: tPrimaryGradientColor,
                      border: Border.all(
                          width: 1, color: tPrimaryColor),
                      borderRadius: BorderRadius.circular(6)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("OK", style: TextStyle(color: tPrimaryColor)),
                  ),
                ),
              ],
            ),

          ],
        );
      },
    );
  }
  // <<< END    _QRSubscriptionPageState.showConfirmationDialog()

  // >>> START  _QRSubscriptionPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tYellow,
        leading: GestureDetector(
          onTap: () {
            Twl.forceNavigateTo(context, Subscription());
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
        title: Text('QR Subscription'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.forceNavigateTo(
              context, Subscription());
        },
        child: SingleChildScrollView(
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6.h),
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
              Center(
                child: Column(
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
                    Button(
                      borderSide: BorderSide(
                        color: tPrimaryColor,
                      ),
                      textcolor: tWhite,
                      color: tPrimaryColor,
                      bottonText: "Continue".tr,

                      onTap:
                          (startLoading, stopLoading, btnState) async {
                            startLoading();
                        print('object');
                        Map<String, String> param = {
                          'order_amount': widget.price
                        };
                        var res = await DriverDetailsApi()
                            .createSubscriptionOrderApi(context, param);
                        if (res != null && res['status'] == 'OK') {
                          Map<String, String> param = {
                            'orderId': res['details']['order_id'],
                          };
                          print("order id: >>>>>>>>>>>>>>>>>>> $param ");
                          Twl.forceNavigateTo(context, SubscriptionReview(param:param));


                          // var ress = await DriverDetailsApi().getDriverSubscription(context, param);
                          // if (ress != null && ress['status'] == 'OK') {
                          //   Twl.forceNavigateTo(context, Subscription());
                          // } else {
                          //   stopLoading();
                          //   Twl.createAlert(context, 'Oops', ress['error'].toString());
                          // }
                          // stopLoading();

                        } else {
                          stopLoading();
                          Twl.createAlert(
                              context, 'Oops', res['error'].toString());
                          stopLoading();
                        }
                      },
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }
  // <<< END    _QRSubscriptionPageState.build()
}
// <<< END    class _QRSubscriptionPageState










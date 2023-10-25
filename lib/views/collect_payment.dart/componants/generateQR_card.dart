import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
// import 'package:base_project_flutter/globalWidgets/buttonEG.dart';
// import 'package:base_project_flutter/views/easyGo/collectPayment/components/paymentunderProcess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../responsive.dart';
import '../../../globalWidgets/button.dart';

class GenerateQR extends StatelessWidget {
  const GenerateQR({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: tWhite,
            boxShadow: [tBoxShadow],
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.asset(
                  Images.QRGENERATOR,
                  scale: isTab(context) ? 3 : 4.5,
                )),
            ArgonButton(
              height: isTab(context) ? 70 : 50,
              width: 50.w,
              color: tPrimaryColor,
              borderRadius: 30,
              borderSide: BorderSide(color: tPrimaryColor),
              child: Text(
                "Generate QR Code",
                style: TextStyle(
                    color: tWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: isTab(context) ? 10.sp : 12.sp),
              ),
              loader: Container(
                padding: EdgeInsets.all(20),
                child: SpinKitRotatingCircle(
                  color: Colors.white,
                ),
              ),
              onTap: (startLoading, stopLoading, btnState) {},
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
}

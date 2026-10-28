// ----------------------------------------------------------------------
// Location problem page
//
// Shown when the driver's location details are missing; going back returns
// to the location explainer.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../location_popup_page.dart';
import '../../responsive.dart';

// >>> START  class LocationErrorPage
class LocationErrorPage extends StatefulWidget {
  const LocationErrorPage({Key? key, this.Locationdetails}) : super(key: key);
  final Locationdetails;
  @override
  State<LocationErrorPage> createState() => _LocationErrorPageState();
}
// <<< END    class LocationErrorPage

// >>> START  class _LocationErrorPageState
class _LocationErrorPageState extends State<LocationErrorPage> {
  // >>> START  _LocationErrorPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Twl.forceNavigateTo(context, LocationPopUpPage());
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: tDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Lottie.asset(
                      'assets/lottie/location_layer.json',
                      height: 28.h,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(color: tPrimaryColor, borderRadius: BorderRadius.circular(12), boxShadow: [tBoxShadow]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Center(
                                //   child: Text(
                                //     'Location error'.tr,
                                //     style: GoogleFonts.mulish(
                                //         fontSize: isTab(context) ? 10.sp : 12.sp, fontWeight: FontWeight.w700, color: tSecondaryColor),
                                //   ),
                                // ),
                                Text(
                                  "Failed to execute background location.Please enable your location permission to always use allow all the time ".tr,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.mulish(fontSize: isTab(context) ? 9.sp : 13.sp, fontWeight: FontWeight.w400, color: tWhite),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Button(
                  textcolor: tWhite,
                  bottonText: 'Go back'.tr,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    Twl.forceNavigateTo(context, LocationPopUpPage());

                    // Twl.forceNavigateTo(
                    //     context,
                    //     BottomNavigation(
                    //       tabIndexId: 1,
                    //     ));
                  }),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // <<< END    _LocationErrorPageState.build()
}
// <<< END    class _LocationErrorPageState

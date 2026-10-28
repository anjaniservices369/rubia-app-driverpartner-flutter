// ----------------------------------------------------------------------
// Profile blocked
//
// Shown when the account has been blocked by the admin.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';

import '../location_popup_page.dart';

// >>> START  class ProfileBlock
class ProfileBlock extends StatefulWidget {
  const ProfileBlock({Key? key}) :
        super(key: key);


  @override
  State<ProfileBlock> createState() => _ProfileBlockState();
}
// <<< END    class ProfileBlock

// >>> START  class _ProfileBlockState
class _ProfileBlockState extends State<ProfileBlock> {

  // >>> START  _ProfileBlockState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchCheck();
    super.initState();
  }
  // <<< END    _ProfileBlockState.initState()

  var authCode;
  var checkStatus;
  var check;
  // >>> START  _ProfileBlockState.fetchCheck()  -  fetch check
  fetchCheck() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authCode = sharedPreferences.getString('authCode');
    var check =
    await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkStatus = check['detail']['status'];
        print('checkDetailsgggggggggg');
        print(checkStatus);
        print('checkDetailsffffffffffffff');
      });
    }
  }
  // <<< END    _ProfileBlockState.fetchCheck()


  // >>> START  _ProfileBlockState._showContactInfoDialog()  -  show contact info dialog
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
  // <<< END    _ProfileBlockState._showContactInfoDialog()

  // Future<void> launchURL(Uri _url) async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }


  // >>> START  _ProfileBlockState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.willpopAlert(context);
          },
        ),
      ),
      backgroundColor: tBackground,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.willpopAlert(context);
        },
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      margin:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBoxShadow],
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                           Image.asset(
                              Images.USER_BLOCK,
                              height: 25.h,
                            ),

                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Your Profile is blocked".tr,
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        isTab(context) ? 11.sp : 13.sp),
                                  ),
                                  Text(
                                    "Contact admin for more information".tr,
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        isTab(context) ? 11.sp : 13.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   child: Text(
                    //     messg,
                    //     style: GoogleFonts.mulish(
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.w800,
                    //         fontSize:
                    //         isTab(context) ? 14.sp : 16.sp),
                    //   ),
                    // ),
                  ],
                ),

              ),

              Center(
                child: Container(
                  child: Button(
                    // height: 7.h,
                    // width: 55.w,
                    color: tPrimaryColor,
                    textcolor: tWhite,
                    bottonText: 'Contact us'.tr,
                    borderSide: BorderSide(color: tPrimaryColor),
                    // boxshadow: [
                    //   tButtonBoxshadow
                    // ],
                    onTap: (startLoading, stopLoading, btnState) async {
                      _showContactInfoDialog(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Container(
                  child: Button(
                    textcolor: tWhite,
                    bottonText: 'Check Status'.tr,
                    onTap: (startLoading, stopLoading, btnState) async {
                      startLoading();
                      await fetchCheck();
                      if (checkStatus.toString() == '10') {
                        stopLoading();
                          Twl.forceNavigateTo(
                              context, LocationPopUpPage());
                        }else{
                        stopLoading();
                        Twl.createAlert(context, 'Oops',
                            'Your profile is still blocked');
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ),
      ),
    );
  }
  // <<< END    _ProfileBlockState.build()
}
// <<< END    class _ProfileBlockState

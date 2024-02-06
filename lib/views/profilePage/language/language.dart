import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/responsive.dart';
// import 'package:base_project_flutter/views/bottomNavigation/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/profilePage.dart';
import 'package:google_fonts/google_fonts.dart';
 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';


 

class ChooseLanguageView extends StatefulWidget {
  @override
  State<ChooseLanguageView> createState() => _ChooseLanguageViewState();
}

enum Fruit { English, Hindi, Kannada, Telugu, Tamil, Gujarati }

class _ChooseLanguageViewState extends State<ChooseLanguageView> {
  Fruit? _fruit = Fruit.English;

  bool isChecked = false;
  bool hasError = false;
  var resultHolder = 'Checkbox is UN-CHECKED';
  void toggleCheckbox(bool value) {
    if (isChecked == false) {
      setState(() {
        isChecked = true;
        resultHolder = 'Checkbox is CHECKED';
      });
    } else {
      setState(() {
        isChecked = false;
        resultHolder = 'Checkbox is UN-CHECKED';
      });
    }
  }

  @override
  List<String> language = [
    'english'.tr,
    'hindi'.tr,
    'kannada'.tr,
    'telugu'.tr,
    'tamil'.tr,
    'gujarati'.tr,
  ];
  List<String> languageoverview = [
    'Good morning',
    'शुभ प्रभात',
    'ಶುಭೋದಯ',
    'శుభోదయం',
    'காலை வணக்கம்',
    'સુપ્રભાત'.tr,
  ];

  @override
  void initState() {
    getAppLang();
    // TODO: implement initState
    super.initState();
  }

  getAppLang() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      switch (sharedPreferences.getString('language_code')) {
        // case 'en_US':

        //   // sharedPreferences.setString('language_code', '');

        //   break;
        case 'hi_IN':
          lang = 1;

          break;
        case 'kn_in':
          lang = 2;
          break;
        case 'tl_in':
          lang = 3;
          break;
        case 'ta_in':
          lang = 4;
          break;
        case 'gu_in':
          lang = 5;
          break;
        default:
          lang = 0;
      }
    });
  }

  var lang;
  Widget build(BuildContext context) {
    return   Scaffold(
            appBar: AppBar(
          elevation: 0.5,
          backgroundColor: tYellow,
          leading: GestureDetector(
            onTap: () {
              Twl.navigateTo(context,ProfilePage());
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
          title: Text('Choose App Language',
              style: TextStyle(
                  // fontFamily: 'Plus Jakarta Sans',
                  fontSize: isTab(context) ? 14.sp : 16.sp,
                  color: tBlue,
                  fontWeight: FontWeight.w700)),
        ),
            body: Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(horizontal: 10),
                      //    child: 
                      // Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "changee".tr,
                      //         style: GoogleFonts.mulish(
                      //             color: tGray,
                      //             fontWeight: FontWeight.w600,
                      //             fontSize: isTab(context) ? 16.sp : 16.sp),
                      //       ),
                      //       Text(
                      //         "app_languagee".tr,
                      //         style: GoogleFonts.mulish(
                      //             color: tWhite,
                      //             fontWeight: FontWeight.w600,
                      //             fontSize: isTab(context) ? 16.sp : 19.sp),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // mainAxisExtent: 10,
                                  childAspectRatio: 1 / 0.9,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20),
                          itemCount: language.length,
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                print('object');
                                setState(() {
                                  lang;
                                });

                                switch (index) {
                                  case 0:
                                    setState(() {
                                      _fruit = Fruit.English;
                                    });

                                    break;
                                  case 1:
                                    setState(() {
                                      _fruit = Fruit.Hindi;
                                    });

                                    break;
                                  case 2:
                                    setState(() {
                                      _fruit = Fruit.Kannada;
                                    });
                                    break;
                                  case 3:
                                    setState(() {
                                      _fruit = Fruit.Telugu;
                                    });
                                    break;
                                  case 4:
                                    setState(() {
                                      _fruit = Fruit.Tamil;
                                    });
                                    break;
                                  case 5:
                                    setState(() {
                                      _fruit = Fruit.Gujarati;
                                    });
                                    break;

                                  default:
                                }

                                setState(() {
                                  lang = index;
                                });
                              },
                              child: Card(
                            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13.0),
    ),
                                elevation: 1,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 16),
                                  // margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    // color: lang == index ? tSecondary : tWhite,
                                      // color:   tSecondaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                    // boxShadow: [
                                    //   lang == index
                                    //       ? BoxShadow(
                                    //           color: Color(0x23000000),
                                    //           blurRadius: 4,
                                    //           offset: Offset(0, 1),
                                    //         )
                                    //       : BoxShadow(
                                    //           color: tWhite,
                                    //           blurRadius: 0,
                                    //           offset: Offset(0, 1))
                                    // ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        languageoverview[index].toString(),
                                        style: TextStyle(
                                          color: tBlue,
                                            // color: lang == index ? tWhite : tGray,
                                            fontSize:
                                                isTab(context) ? 8.sp : 13.sp,
                                            fontWeight
                                                : FontWeight.w500),
                                      ),
                                      Text(
                                        language[index].toString(),
                                        style: TextStyle(
                                          color: tLightBrown,
                                            // color: lang == index ? tWhite : tGray,
                                            fontSize:
                                                isTab(context) ? 9.sp : 15.sp,
                                            fontWeight:
                                                 FontWeight.w600
                                                ),
                                      ),
                              
                                      Spacer(),
                                      lang == index
                                          ? GestureDetector(
                                              onTap: () {
                                                (Fruit? value) {
                                                  setState(() {
                                                    _fruit = value;
                                                  });
                                                };
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 2.2.w,
                                                    vertical: 0.4.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(6),
                                                    color: tDeepBrown),
                                                child: Text(
                                                  "Selected",
                                                  style: GoogleFonts.mulish(
                                                      color: tWhite,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: isTab(context)
                                                          ? 10.sp
                                                          : 12.sp),
                                                ),
                                              ))
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w,
                                                  vertical: 0.2.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  border: Border.all(
                                                      color: tPrimaryColor,
                                                      width: 1)),
                                              child: Text(
                                                "Select",
                                                style: GoogleFonts.mulish(
                                                    color: tPrimaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isTab(context)
                                                        ? 10.sp
                                                        : 12.sp),
                                              ),
                                            )
                                      // ? Container(
                                      //     child: Transform.scale(
                                      //       scale: 1.0,
                                      //       child: Checkbox(
                                      //         autofocus: true,
                              
                                      //         side: MaterialStateBorderSide
                                      //             .resolveWith(
                                      //           (states) => BorderSide(
                                      //             width: 1.0,
                                      //           ),
                                      //         ),
                                      //         focusColor: tGray,
                                      //         shape: RoundedRectangleBorder(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     1.80)),
                                      //         value: isChecked,
                              
                                      //         onChanged: (value) {
                                      //           toggleCheckbox(value!);
                                      //         },
                                      //         activeColor: tBlack,
                                      //         checkColor: Colors.white,
                              
                                      //       ),
                                      //     ),
                                      //   )
                                      // : Container()
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              )),
              Button(
                // height: isTab(context) ? 8.h : 6.5.h,
                // width: isTab(context) ? 55.w : 55.w,
                color: tPrimaryColor,
                textcolor: tWhite,
                bottonText: 'Next'.tr,
                borderSide: BorderSide(
                  color: tWhite,
                ),
                
                onTap: (startLoading, stopLoading, btnState) async {
                  // Twl.createAlert(context, 'sasasadsa', _fruit.toString());
                  // print("vsdvcdscdscds");
                  print(_fruit);
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();

                  // Twl.navigateTo(context, ReferToFriend());
                  switch (_fruit) {
                    case Fruit.English:
                      Get.updateLocale(const Locale('en', 'US'));
                      sharedPreferences.setString('language_code', 'en_US');

                      break;
                    case Fruit.Hindi:
                      Get.updateLocale(const Locale('hi', 'IN'));
                      sharedPreferences.setString('language_code', 'hi_IN');
                      break;
                    case Fruit.Kannada:
                      Get.updateLocale(const Locale('kn', 'IN'));
                      sharedPreferences.setString('language_code', 'kn_in');
                      break;
                    case Fruit.Telugu:
                      Get.updateLocale(const Locale('tl', 'IN'));
                      sharedPreferences.setString('language_code', 'tl_in');
                      break;
                    case Fruit.Tamil:
                      Get.updateLocale(const Locale('ta', 'IN'));
                      sharedPreferences.setString('language_code', 'ta_in');
                      break;
                    case Fruit.Gujarati:
                      Get.updateLocale(const Locale('gu', 'IN'));
                      sharedPreferences.setString('language_code', 'gu_in');
                      break;

                    default:
                  }
                  Twl.navigateTo(context,ProfilePage());
                  // Twl.navigateTo(context, HomePageView());
                },
              ),
              SizedBox(
                height: 2.h,
              )
            ]));
  }
}

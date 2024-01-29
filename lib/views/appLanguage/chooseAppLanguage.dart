// import 'package:base_project_flutter/views/bottomNavigation/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/profilePage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../providers/bookingProvider.dart';
import '../../responsive.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';
import '../rider_details/add_Details.dart';

class ChooseAppLanguageView extends StatefulWidget {
  @override
  const ChooseAppLanguageView({
    Key? key,
    this.isReferalPage,
  }) : super(key: key);
  final isReferalPage;
  State<ChooseAppLanguageView> createState() => _ChooseAppLanguageViewState();
}

enum Fruit { English, Hindi, Kannada, Telugu, Tamil, Gujarati }

class _ChooseAppLanguageViewState extends State<ChooseAppLanguageView> {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: tBackground,
          leading: BackButtonLeading(
            onTap: () {
              Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
            },
          ),
          title: Text('Choose App Language',
              style: TextStyle(
                  fontSize: isTab(context) ? 10.sp : 14.sp,
                  color: tSecondaryColor,
                  fontWeight: FontWeight.w700)),
        ),
        body: WillPopScope(
          onWillPop: () {
            return Twl.forceNavigateTo(
                context, BottomNavigation(tabIndexId: 3));
          },
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 16),
                              decoration: BoxDecoration(
                                boxShadow: [tBoxShadow],
                                color: tWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    languageoverview[index].toString(),
                                    style: TextStyle(
                                        color: tBlue,
                                        fontFamily: "Poppins",
                                        fontSize: isTab(context) ? 8.sp : 13.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    language[index].toString(),
                                    style: TextStyle(
                                        color: tLightBrown,
                                        // color: lang == index ? tWhite : tGray,
                                        fontSize: isTab(context) ? 9.sp : 15.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
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
                                                    horizontal: 0.8.w,
                                                    vertical: 0.4.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: tDeepBrown),
                                                child: Text(
                                                  "Selected",
                                                  style: GoogleFonts.mulish(
                                                      color: tWhite,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: isTab(context)
                                                          ? 8.sp
                                                          : 10.sp),
                                                ),
                                              ))
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 1.5.w,
                                                  vertical: 0.2.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  border: Border.all(
                                                      color: tPrimaryColor,
                                                      width: 1)),
                                              child: Text(
                                                "Select",
                                                style: GoogleFonts.mulish(
                                                    color: tPrimaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 10.sp),
                                              ),
                                            ),
                                      index == 0
                                          ? Text(
                                              "Default",
                                              style: GoogleFonts.mulish(
                                                  color: tbrown,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: isTab(context)
                                                      ? 8.sp
                                                      : 10.sp),
                                            )
                                          : Text(""),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )),
            Button(
              color: tPrimaryColor,
              textcolor: tWhite,
              bottonText: 'Next'.tr,
              borderSide: BorderSide(
                color: tPrimaryColor,
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
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
                widget.isReferalPage == true
                    ? Twl.forceNavigateTo(context, AddDetailsView())
                    : Twl.forceNavigateTo(
                        context, BottomNavigation(tabIndexId: 3));
                print("object");
              },
            ),
            SizedBox(
              height: 2.h,
            )
          ]),
        ));
  }
}

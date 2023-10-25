import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../responsive.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var currentPage = 0;

  bool get isLastPage => currentPage == splashData.length - 1;

  var pageControll = PageController();

  late List<Map<String, String>> splashData = [
    {
      'title': 'Select your location',
      'suntitle':
          '"Navigate with Ease, Select Your Location, Book Your Ride!" ',
      'image': Images.SELECT_LOCATION,
    },
    {
      'title': 'Get best Drivers',
      'suntitle':
          '"Empowering Journeys with the Elite Get the Best Drivers, Elevate Your Ride!"',
      'image': Images.GET_DRIVER,
    },
    {
      'title': 'Get ready with your car',
      'suntitle':
          '"Rev up and Ride, Get Set with Your Car, Let the Journey Begin!"',
      'image': Images.GET_READY_WITH_CAR,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: (page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  controller: pageControll,
                  itemCount: splashData.length,
                  itemBuilder: (context, index) {
                    return OnboardingWidget(
                      title: splashData[index]['title'],
                      subtitle: splashData[index]['suntitle'],
                      image: splashData[index]['image'],
                      titlecolor: tBlack,
                      subtitlecolor: tbrown,
                      height: isTab(context) ? 50.w : 10.w,
                      index: index,
                    );
                  },
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: currentPage == 0
                          ? EdgeInsets.symmetric(horizontal: 20)
                          : EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      height: isTab(context) ? 10.h : 10.h,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            currentPage == 0
                                ? GestureDetector(
                                    onTap: () {
                                      Twl.forceNavigateTo(
                                          context, LoginPageView());
                                    },
                                    child: Text(
                                      'Skip Now',
                                      style: TextStyle(
                                        fontSize: isTab(context) ? 7.sp : 14.sp,
                                        color: tBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: isTab(context) ? 10.w : 16.5.w,
                                  ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  splashData.length,
                                  (index) => Container(
                                    margin: EdgeInsets.all(2.5),
                                    height: 8,
                                    width: currentPage == index ? 14 : 14,
                                    decoration: BoxDecoration(
                                      color: currentPage == index
                                          ? tBlack
                                          : tlightGray,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            currentPage == 0
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentPage = 1;
                                      });
                                      pageControll.nextPage(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.ease);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          isTab(context) ? 18 : 14),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: tPrimaryColor,
                                          boxShadow: [tBoxShadow]),
                                      child: Icon(
                                        Icons.arrow_forward_rounded,
                                        color: tWhite,
                                        size: isTab(context) ? 45 : 34,
                                      ),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.centerRight,
                                    // width: 30.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (currentPage == 1) {
                                          pageControll.nextPage(
                                              duration: Duration(seconds: 1),
                                              curve: Curves.ease);
                                          setState(() {
                                            currentPage = 2;
                                          });
                                        } else {
                                          Twl.forceNavigateTo(
                                              context, LoginPageView());
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            isTab(context) ? 18 : 14),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: tPrimaryColor,
                                            boxShadow: [tBoxShadow]),
                                        child: Icon(
                                          Icons.arrow_forward_rounded,
                                          color: tWhite,
                                          size: isTab(context) ? 45 : 34,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  const OnboardingWidget(
      {Key? key,
      this.title,
      this.subtitle,
      this.image,
      this.title2,
      this.titlecolor,
      this.height,
      this.index,
      this.subtitlecolor})
      : super(key: key);
  final String? title;
  final String? title2;
  final String? subtitle;
  final image;
  final titlecolor;
  final height;
  final subtitlecolor;
  final index;
  get tprimaryColor => null;

  @override
  Widget build(BuildContext context) {
    print(index);

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              // CustomPaint(
              //   size: Size(
              //     120.w,
              //     (54.h).toDouble(),
              //   ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              //   painter: RPSCustomPainter(),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 18.h),
                child: Align(
                  // child: Image.asset(
                  //   index == 0
                  //       ? Images.DISCOVERRESTORENT
                  //       : index == 1
                  //           ? Images.CHOUSE
                  //           : Images.PETS,
                  //   // height: 28.h,
                  //   // width: 70.w,
                  //   scale: isTab(context) ? 2.5 : 4,
                  // ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ],
          ),
          Image.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.30,
            // width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height / 12,
          // ),
          SizedBox(
            height: isTab(context) ? 16.h : 6.h,
          ),
          Text(
            title!,
            style: GoogleFonts.mulish(
              color: tBlack,
              fontWeight: FontWeight.w700,
              fontSize: isTab(context) ? 15.sp : 22.sp,
            ),
          ),
          SizedBox(
            height: isTab(context) ? height / 20 : height / 3,
          ),
          // index == 0
          //     ? Container(
          //         width: MediaQuery.of(context).size.width * 0.8,
          //         child:Text(
          //           subtitle!,
          //           style: TextStyle(
          //               color: subtitlecolor,
          //               height: 1.4,
          //               fontSize: isTab(context) ? 9.sp : 11.sp,
          //               fontWeight: FontWeight.w400),
          //           textAlign: TextAlign.center,
          //         ),
          //       )
          //     :
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              subtitle!,
              style: TextStyle(
                  color: subtitlecolor,
                  height: 1.4,
                  fontSize: isTab(context) ? 9.sp : 11.sp,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

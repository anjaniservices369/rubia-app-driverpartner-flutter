import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/profilePage/ridehistory/bottomsheet.dart';
import 'package:base_project_flutter/views/profilePage/ridehistory/ridetab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../bottomNavigation.dart/bottomNavigation.dart';

class MyRidesView extends StatefulWidget {
  const MyRidesView({Key? key, this.selectedType}) : super(key: key);
  final selectedType;
  @override
  State<MyRidesView> createState() => _MyRidesViewState();
}

class _MyRidesViewState extends State<MyRidesView> {
  var selectedindex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 7,
          leading: GestureDetector(
            onTap: () {
              Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
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
          title: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'ride_history'.tr,
              style: GoogleFonts.mulish(
                color: tBlue,
                fontWeight: FontWeight.w700,
                fontSize: isTab(context) ? 14.sp : 16.sp,
              ),
            ),
          ),
          backgroundColor: tYellow,
          actions: [
            GestureDetector(
                onTap: () {
                  print(widget.selectedType);
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      context: context,
                      builder: (context) => Container(
                            height: isTab(context) ? 40.h : 40.h,
                            child: HistoryBottomSheet(),
                          ));
                },
                child: Container(
                    child: Row(
                  children: [
                    Text(
                      widget.selectedType == null
                          ? 'Today'.tr
                          : widget.selectedType.toString(),
                      style: TextStyle(
                          color: tBlue,
                          fontSize: isTab(context) ? 9.sp : 11.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 0.4.w,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                      color: tBlue,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                  ],
                )))
          ]),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
        },
        child: DefaultTabController(
            length: 3,
            child: Column(children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                decoration:
                    BoxDecoration(color: tWhite, boxShadow: [tBoxShadow]),
                child: TabBar(
                    labelColor: tWhite,
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: 2, vertical: isTab(context) ? 10 : 4),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: tPrimaryColor,
                    indicator: BoxDecoration(
                        color: tPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    tabs: [
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("All Rides".tr,
                                style: TextStyle(
                                    fontSize: isTab(context) ? 22 : 16,
                                    color: tSecondaryColor)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Completed".tr,
                                style: TextStyle(
                                    fontSize: isTab(context) ? 22 : 16,
                                    color: tSecondaryColor)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Cancelled".tr,
                                style: TextStyle(
                                    fontSize: isTab(context) ? 22 : 16,
                                    color: tSecondaryColor)),
                          ),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    RideHistoryList(status: ''),
                    RideHistoryList(status: STATUS_RIDE_COMPLETED),
                    RideHistoryList(status: STATUS_CANCELLED),
                  ]),
                ),
              )
            ])),
      ),
    );
  }
}

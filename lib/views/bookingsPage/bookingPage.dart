import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../ride_info/ride_info.dart';
import 'componats/accepted_rides.dart';

import 'componats/avalableRIde.dart';

class MyBookingHistory extends StatefulWidget {
  const MyBookingHistory({Key? key, this.tabIndexType}) : super(key: key);
  final tabIndexType;
  @override
  State<MyBookingHistory> createState() => _MyBookingHistoryState();
}

class _MyBookingHistoryState extends State<MyBookingHistory> {
  var selectedindex;

  void checkBottomIndex() {
    setState(() {
      selectedindex = widget.tabIndexType != null ? widget.tabIndexType : 0;
    });
  }

  @override
  void initState() {
    checkBottomIndex();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);
    return WillPopScope(
      onWillPop: () {
        return Twl.navigateBack(context);
      },
      child: Scaffold(
        backgroundColor: tBackground,
        appBar: AppBar(
          backgroundColor: tAppbarColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 7,
          title: Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'bookings'.tr,
              style: GoogleFonts.mulish(
                color: tSecondaryColor,
                fontWeight: FontWeight.w700,
                fontSize: isTab(context) ? 10.sp : 17.sp,
              ),
            ),
          ),
        ),
        body: DefaultTabController(
            length: 2,
            initialIndex: widget.tabIndexType != null ? widget.tabIndexType : 0,
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                decoration:
                    BoxDecoration(color: tWhite, boxShadow: [tBoxShadow]),
                child: TabBar(
                    labelColor: tWhite,
                    labelPadding: EdgeInsets.symmetric(
                        horizontal: 2, vertical: isTab(context) ? 10 : 2),
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
                            child: Text("available_rides".tr,
                                style: TextStyle(
                                    fontSize: isTab(context) ? 22 : 16)),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("accepted_rides".tr,
                                style: TextStyle(
                                    // color: tBlack,
                                    fontSize: isTab(context) ? 22 : 16)),
                          ),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    AvalableRide(status: STATUS_WAITING_FOR_DRIVER),
                    AcceptedRides(status: STATUS_ACCEPTED_RIDES),
                  ]),
                ),
              )
            ])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: tPrimaryColor,
          onPressed: () {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
          },
          child: Icon(
            Icons.refresh,
          ),
        ),
      ),
    );
  }
}

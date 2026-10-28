// ----------------------------------------------------------------------
// Bookings (two tabs)
//
// Available rides, Accepted rides and Completed rides (paid and rated).
// ----------------------------------------------------------------------
import 'dart:developer';

import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/responsive.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';
import 'componats/accepted_rides.dart';
import '../profilePage/ridehistory/ridetab.dart';

import 'componats/avalableRIde.dart';

// >>> START  class MyBookingHistory
class MyBookingHistory extends StatefulWidget {
  const MyBookingHistory({Key? key, this.tabIndexType, this.index,}) : super(key: key);
  final tabIndexType;
  final index;
  @override
  State<MyBookingHistory> createState() => _MyBookingHistoryState();
}
// <<< END    class MyBookingHistory

// >>> START  class _MyBookingHistoryState
class _MyBookingHistoryState extends State<MyBookingHistory> {
  var selectedindex;

  // >>> START  _MyBookingHistoryState.checkBottomIndex()  -  check bottom index
  void checkBottomIndex() {
    setState(() {
      selectedindex = widget.tabIndexType != null ? widget.tabIndexType : 0;
    });
  }
  // <<< END    _MyBookingHistoryState.checkBottomIndex()

  // >>> START  _MyBookingHistoryState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    checkBottomIndex();
    // TODO: implement initState
    super.initState();
  }
  // <<< END    _MyBookingHistoryState.initState()

  // >>> START  _MyBookingHistoryState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    // Keep rebuilding this widget when HomePageProvider changes.
    context.watch<HomePageProvider>();
    return Scaffold(
        backgroundColor: tBackground,
        appBar: AppBar(
          backgroundColor: tAppbarColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 7,
          title: InkWell(
            onTap: () async {
              var path = await getApplicationDocumentsDirectory();
              Hive.init(path.path);
              //  await Hive.openBox('peopleBox');
              // final box = Hive.box('peopleBox');
              Hive.init(path.path);
              await Hive.openBox('peopleBox');
              final box = Hive.box('peopleBox');
              List a = [];
              for (var element in box.values) {
                a.add(element);
              }
              String validJson =
                  a.toString().replaceFirst(RegExp(r',\s*]$'), ']');
              log(validJson);
            },
            child: Padding(
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
        ),
        body: DefaultTabController(
            length: 3,
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
                      Tab(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Completed".tr,
                                style: TextStyle(
                                    fontSize: isTab(context) ? 22 : 16)),
                          ),
                        ),
                      ),
                    ]),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    AvalableRide(status: STATUS_WAITING_FOR_DRIVER,index:widget.index),
                    AcceptedRides(status: STATUS_ACCEPTED_RIDES),
                    // A ride moves here once its payment is collected and the customer has been rated; a tap opens the ride details.
                    RideHistoryList(status: STATUS_RIDE_COMPLETED, selectedType: null, allDates: true),
                  ]),
                ),
              )
            ])),
        floatingActionButton: FloatingActionButton(
          backgroundColor: tPrimaryColor,
          onPressed: () async {
               // Reload the Bookings screen. Offers are created by the server when a
               // booking is made and by its cron job, so nothing is triggered from here.
               Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
            // var path = await getApplicationDocumentsDirectory();
            // Hive.init(path.path);
            // await Hive.openBox('peopleBox');
            // final box = Hive.box('peopleBox');
            // var a = box.values;
            // List b = [
            //   17.440941,
            //   78.3769953,
            //   17.4409826,
            //   78.3769953,
            //   17.4409065,
            //   78.3769953,
            //   17.4408572,
            //   78.3769951,
            //   17.4412591,
            //   78.3769956,
            //   17.4409263,
            //   78.3769953,
            //   17.4409386,
            //   78.3769953,
            //   17.4409423,
            //   78.3769953,
            //   17.4409422,
            //   78.3769952,
            //   17.4409799,
            //   78.3769955,
            //   17.4409076,
            //   78.3769952,
            //   17.4412019,
            //   78.3769953,
            //   17.441204,
            //   78.3769953,
            //   17.4411029,
            //   78.3769953,
            //   17.4411025,
            //   78.3769953,
            //   17.4411031,
            //   78.3769953,
            //   17.4411038,
            //   78.3769953,
            //   17.4325166,
            //   78.3687622,
            //   17.4329704,
            //   78.3691376,
            //   17.4336293,
            //   78.3693403,
            //   17.4343697,
            //   78.3686036,
            //   17.4355822,
            //   78.3672482,
            //   17.4365649,
            //   78.3661669,
            //   17.4374505,
            //   78.3650798,
            //   17.4383066,
            //   78.3639014,
            //   17.4387738,
            //   78.3635622,
            //   17.4386873,
            //   78.3639877,
            //   17.4382512,
            //   78.364559,
            //   17.4388445,
            //   78.3655193,
            //   17.4398803,
            //   78.366466,
            //   17.440949,
            //   78.3674316,
            //   17.4407698,
            //   78.3687494,
            //   17.4403682,
            //   78.3701015,
            //   17.4400423,
            //   78.3715198,
            //   17.4413663,
            //   78.3717586,
            //   17.4420553,
            //   78.372322,
            //   17.441587,
            //   78.3736967,
            //   17.4410832,
            //   78.3747171,
            //   17.4400407,
            //   78.3763162,
            //   17.4403878,
            //   78.3770162,
            //   17.4414046,
            //   78.3770733,
            //   17.4429039,
            //   78.3771157,
            //   17.4445543,
            //   78.3770903,
            //   17.4461715,
            //   78.3773291,
            //   17.4475038,
            //   17.4475038,
            // ];
            // for (var element in a) {
            //   b.add(element);
            // }
            // List<Map<String, String>> formattedCoordinates = [];

            // for (int i = 0; i < b.length; i += 1) {
            //   // print(b[i]);
            //   double lat = double.parse(b[i].toString().split(',').first);
            //   double lng = double.parse(b[i].toString().split(',').last);

            //   formattedCoordinates.add({
            //     jsonEncode("lat"): jsonEncode(lat.toString()),
            //     jsonEncode("lng"): jsonEncode(lng.toString()),
            //   });
            // }

            // // Convert the list to a JSON string
            // String jsonResult = formattedCoordinates.toString();

            // // Print the formatted JSON
            // //   var c = jsonEncode(jsonResult);
            // print(jsonResult);

            //  calcDis(box.values);
          },
          child: Icon(
            Icons.refresh,
          ),
        ),
      );
  }
  // <<< END    _MyBookingHistoryState.build()
}
// <<< END    class _MyBookingHistoryState

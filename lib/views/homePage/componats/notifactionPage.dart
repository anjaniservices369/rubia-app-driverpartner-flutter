// ----------------------------------------------------------------------
// Notifications list
//
// List of messages received, with clear option.
// ----------------------------------------------------------------------
import 'dart:developer';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../responsive.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../providers/notifactionProvider.dart';

// >>> START  class Notifactionpage
class Notifactionpage extends StatefulWidget {
  const Notifactionpage({Key? key, this.boolnotificationPage})
      : super(key: key);
  final boolnotificationPage;

  @override
  State<Notifactionpage> createState() => _NotifactionpageState();
}
// <<< END    class Notifactionpage

// >>> START  class _NotifactionpageState
class _NotifactionpageState extends State<Notifactionpage> {
  late double scrollPosition;
  ScrollController scrollController = new ScrollController();

  MyNotifactionProvider myNotificationProvider = MyNotifactionProvider();
  // >>> START  _NotifactionpageState.initState()  -  runs once when the screen opens
  void initState() {
    super.initState();
    myNotificationProvider =
        Provider.of<MyNotifactionProvider>(context, listen: false);
    myNotificationProvider.myNotificationList.clear();

    myNotificationProvider.currentPage = 0;
    myNotificationProvider.totalPages = 0;
    myNotificationProvider.getFavorites(
      context: context,
      page: '${myNotificationProvider.currentPage}',
    );
    scrollController.addListener(_scrollListener);
  }
  // <<< END    _NotifactionpageState.initState()

  // >>> START  _NotifactionpageState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  // <<< END    _NotifactionpageState.dispose()

  int currentPage = 0;
  int totalPages = 0;
  var resNok;
  // >>> START  _NotifactionpageState._scrollListener()  -  scroll listener
  _scrollListener() {
    log('scroll conmterfdas0');
    if (scrollController.position.extentAfter == 0) {
      print('currentPage' + myNotificationProvider.currentPage.toString());
      if (myNotificationProvider.currentPage <
              myNotificationProvider.totalPages &&
          myNotificationProvider.myNotificationGetting == false) {
        log('is api hitting');
        myNotificationProvider.getFavorites(
          context: context,
          page: '${myNotificationProvider.currentPage}',
        );
      } else {}
    }
  }
  // <<< END    _NotifactionpageState._scrollListener()

  List<String> name = ['Start Your First Ride with Winter Offers.', 'Hey! '];
  // >>> START  _NotifactionpageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          if (widget.boolnotificationPage != true) {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
          } else {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 0));
          }
        },
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 7,
              backgroundColor: tYellow,
              leading: GestureDetector(
                  onTap: () {
                    widget.boolnotificationPage != true
                        ? Twl.forceNavigateTo(
                            context,
                            BottomNavigation(
                              tabIndexId: 3,
                            ))
                        : Twl.forceNavigateTo(
                            context,
                            BottomNavigation(
                              tabIndexId: 0,
                            ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(isTab(context) ? 10 : 12.0),
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: isTab(context) ? 7 : 6,
                            horizontal: isTab(context) ? 7 : 6),
                        decoration: BoxDecoration(
                            boxShadow: [tBoxShadow],
                            color: tWhite,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                            child: Image.asset(
                          Images.BACK,
                          scale: isTab(context) ? 2.5 : 3,
                        ))),
                  )),
              title: Text('Notification'.tr,
                  style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: isTab(context) ? 10.sp : 17.sp)),
              actions: [
                PopupMenuButton<int>(
                    onSelected: (value) async {
                      var res = await UserAPI().getClearNotifaction(context);
                      if (res != null && res['status'] == 'OK') {
                        Twl.forceNavigateTo(context, Notifactionpage());
                      } else {
                        Twl.createAlert(
                            context, 'Oops', res['error'].toString());
                      }
                    },
                    icon: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.more_vert,
                          color: tSecondaryColor,
                        )
                      ],
                    ),
                    tooltip: "  ",
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    offset: Offset(
                      -40,
                      -0,
                    ),
                    color: tWhite,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            height: 0.4.h,
                            child: Text("clear".tr,
                                style: GoogleFonts.mulish(
                                    color: tPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTab(context) ? 9.sp : 12.sp)),
                            value: 1,
                          ),
                        ]),
              ],
            ),
            body: Consumer<MyNotifactionProvider>(
                builder: (context, provider, child) {
              log('length>>>' + provider.myNotificationList.length.toString());
              return provider.myNotificationList.isEmpty
                  ? provider.resNOK == 'NOK'
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Column(
                              children: [
                                Image.asset(
                                  Images.NO_NOTIFICATION,
                                  scale: 4,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text("No Notifications Yet",
                                    style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 9.sp : 22.sp)),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text("You have no notifications right now.",
                                    style: GoogleFonts.mulish(
                                        color: tGray,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            isTab(context) ? 9.sp : 14.sp)),
                                Text("come back later",
                                    style: GoogleFonts.mulish(
                                        color: tGray,
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            isTab(context) ? 9.sp : 14.sp)),
                              ],
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: SpinKitRotatingCircle(
                            color: tAppbarColor,
                          ),
                        )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await myNotificationProvider.getFavorites(
                          context: context,
                          page: '${myNotificationProvider.currentPage}',
                        );
                      },
                    color: tWhite,
                    backgroundColor: tAppbarColor ,
                    child: ListView.builder(
                        itemCount: provider.myNotificationList.length,
                        physics: ScrollPhysics(),
                        controller: scrollController,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var notificationDetails =
                              provider.myNotificationList[index];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 0.6.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: tWhite,
                                    boxShadow: [tBoxShadow]),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  tPrimaryColor.withValues(alpha: 0.2)),
                                          child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.notifications,
                                                color: tPrimaryColor,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1,
                                                child: Text(
                                                    notificationDetails['title'],
                                                    // name[index],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: isTab(context)
                                                            ? 8.sp
                                                            : 12.sp)),
                                              ),
                                              SizedBox(
                                                height: 0.5.h,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1,
                                                child: Text(
                                                    notificationDetails[
                                                        'description'],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.mulish(
                                                        color: tDeepBrown,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: isTab(context)
                                                            ? 7.sp
                                                            : 8.5.sp)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          Twl.dateFormate(
                                              notificationDetails['created_on']),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.mulish(
                                              color: tDeepBrown,
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  isTab(context) ? 7.sp : 9.sp)),
                                    )
                                  ],
                                )),
                          );
                        }),
                  );
            })));
  }
  // <<< END    _NotifactionpageState.build()
}
// <<< END    class _NotifactionpageState

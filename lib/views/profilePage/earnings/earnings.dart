// ----------------------------------------------------------------------
// Earnings
//
// Earnings by day / 7 days / custom range.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';
import '../../wallet/pickCustomDate.dart';
import 'componants/earn_container.dart';

// >>> START  class EarningPage
class EarningPage extends StatefulWidget {
  EarningPage({Key? key, this.tabindex, this.selectedType, this.isEarningPage})
      : super(key: key);
  final selectedType;
  final tabindex;
  final isEarningPage;
  @override
  State<EarningPage> createState() => _EarningPageState();
}
// <<< END    class EarningPage

// >>> START  class _EarningPageState
class _EarningPageState extends State<EarningPage> {
  // Current tab; the widget's own field is final.
  late dynamic _tabindex = widget.tabindex;
  int initPosition = 0;
  String filterValue = "All";

  // >>> START  _EarningPageState.initState()  -  runs once when the screen opens
  void initState() {
    checkBottomIndex();
    super.initState();
  }
  // <<< END    _EarningPageState.initState()

  // >>> START  _EarningPageState.checkBottomIndex()  -  check bottom index
  void checkBottomIndex() async {
    setState(() {});
    setState(() {
      _tabindex = _tabindex != null ? _tabindex : 0;
      print('_tabindex.toString()' + _tabindex.toString());
    });
    if (_tabindex == 0) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      sharedPreferences.remove('filteredValue');
      sharedPreferences.setString('filteredValue', 'Today');

      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
      String endDate = formatter.format(DateTime.now().add(Duration(days: 1)));

      String startDate = formatter.format(now);
      print('dates');
      print(startDate);
      print(endDate);
      sharedPreferences.remove('customFilter');
      sharedPreferences.setString('startDate', startDate);
      sharedPreferences.setString('endDate', endDate);
    }
  }
  // <<< END    _EarningPageState.checkBottomIndex()

  // @override
  // void dispose() async {
  //   // TODO: implement dispose
  //   super.dispose();
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   sharedPreferences.remove('filteredValue');
  //   sharedPreferences.setString('filteredValue', 'Today');

  //   var now = new DateTime.now();
  //   var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
  //   String endDate = formatter.format(DateTime.now().add(Duration(days: 1)));

  //   String startDate = formatter.format(now);
  //   print('dates');
  //   print(startDate);
  //   print(endDate);
  //   sharedPreferences.remove('customFilter');
  //   sharedPreferences.setString('startDate', startDate);
  //   sharedPreferences.setString('endDate', endDate);
  //   setState(() {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //             builder: (context) => EarningPage(
  //                   selectedType: 'Today',
  //                   tabindex: 0,
  //                 )),
  //         (Route<dynamic> route) => false);
  //   });
  // }

  // >>> START  _EarningPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tBackground,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: tYellow,
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
          centerTitle: false,
          title: Text('earnings'.tr,
              style: TextStyle(
                  fontSize: isTab(context) ? 14.sp : 16.sp,
                  color: tBlue,
                  fontWeight: FontWeight.w700)),
        ),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            Twl.forceNavigateTo(
                context, BottomNavigation(tabIndexId: 3));
          },
          child: DefaultTabController(
              length: 4,
              initialIndex: _tabindex == null ? 0 : _tabindex,
              child: Column(children: [
                SizedBox(
                  height: 1.5.h,
                ),
                TabBar(
                  physics: NeverScrollableScrollPhysics(),
                  // physics: ScrollPhysics(),
                  // isScrollable: true,
                  padding: EdgeInsets.only(left: 10),
                  labelColor: tWhite,
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: 5,
                  ),

                  indicatorSize: TabBarIndicatorSize.tab,

                  unselectedLabelColor: tPrimaryColor,
                  indicator: BoxDecoration(
                      color: tPrimaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  onTap: (int index) {
                    setState(() {
                      _tabindex = index;
                      print(index);
                    });
                  },
                  tabs: [
                    // Tab(
                    //   child: Text('Today',
                    //       overflow: TextOverflow.ellipsis,
                    //       maxLines: 1,
                    //       style: TextStyle(
                    //           color: tGray,
                    //           fontSize: isTab(context) ? 7.sp : 10.sp,
                    //           fontWeight: FontWeight.w500)),
                    // ),
                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.remove('filteredValue');
                        sharedPreferences.setString('filteredValue', 'Today');

                        var now = new DateTime.now();
                        var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
                        String endDate = formatter
                            .format(DateTime.now().add(Duration(days: 1)));

                        String startDate = formatter.format(now);
                        print('dates');
                        print(startDate);
                        print(endDate);
                        sharedPreferences.remove('customFilter');
                        sharedPreferences.setString('startDate', startDate);
                        sharedPreferences.setString('endDate', endDate);
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => EarningPage(
                                        selectedType: 'Today',
                                        tabindex: 0,
                                      )),
                              (Route<dynamic> route) => false);
                        });
                      },
                      child: Tab(
                        height: 4.h,
                        child: Container(
                          // height: 4.h,

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: tPrimaryColor)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Today",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    // color: tBlack,
                                    fontSize: isTab(context) ? 7.sp : 10.sp,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.remove('filteredValue');
                        sharedPreferences.setString(
                            'filteredValue', 'Last 7 Days');

                        var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
                        String endDate = formatter
                            .format(DateTime.now().add(Duration(days: 1)));

                        String startDate = formatter
                            .format(DateTime.now().subtract(Duration(days: 7)));
                        print('dates');
                        print(startDate);
                        print(endDate);
                        sharedPreferences.remove('customFilter');
                        sharedPreferences.setString('startDate', startDate);
                        sharedPreferences.setString('endDate', endDate);
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => EarningPage(
                                        tabindex: 1,
                                        selectedType: 'Last 7 Days',
                                      )),
                              (Route<dynamic> route) => false);
                        });
                      },
                      child: Tab(
                        height: 4.h,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: tPrimaryColor)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Last 7days",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    // color: tBlack,
                                    fontSize: isTab(context) ? 7.sp : 10.sp,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.remove('filteredValue');
                        sharedPreferences.setString(
                            'filteredValue', 'Last 30 Days');

                        var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
                        String endDate = formatter
                            .format(DateTime.now().add(Duration(days: 1)));

                        String startDate = formatter.format(
                            DateTime.now().subtract(Duration(days: 30)));
                        print('dates');
                        print(startDate);
                        print(endDate);
                        sharedPreferences.remove('customFilter');
                        sharedPreferences.setString('startDate', startDate);
                        sharedPreferences.setString('endDate', endDate);
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => EarningPage(
                                        tabindex: 2,
                                        selectedType: 'Last 30 Days',
                                      )),
                              (Route<dynamic> route) => false);
                        });
                      },
                      child: Tab(
                        height: 4.h,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: tPrimaryColor)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Last 30days",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    // color: tBlack,
                                    fontSize: isTab(context) ? 7.sp : 10.sp,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () async {
                        showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (ctx, a1, a2) {
                            return Container();
                          },
                          transitionBuilder: (ctx, a1, a2, child) {
                            return PickCustomDate(
                                filterValue: filterValue, isEarningPage: true);
                          },
                        );
                      },
                      child: Tab(
                        height: 4.h,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: tPrimaryColor)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Custom",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    // color: tBlack,
                                    fontSize: isTab(context) ? 7.sp : 10.sp,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        TodaysEarnings(status: 0),
                        TodaysEarnings(status: 1),
                        TodaysEarnings(status: 2),
                        TodaysEarnings(status: 3)
                      ]),
                )
              ])),
          //    DefaultTabController(
          //   length: 4,
          //   initialIndex: widget.tabindex == null ? 0 : widget.tabindex,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(left: 6),
          //         child: Container(
          //           height: 60,
          //           child: AppBar(
          //             automaticallyImplyLeading: false,
          //             backgroundColor: tBackground,
          //             elevation: 0,
          //             bottom: TabBar(
          //               onTap: (int index) {
          //                 setState(() {
          //                   widget.tabindex = index;
          //                   print(index);
          //                 });
          //               },
          //               labelPadding:
          //                   EdgeInsets.symmetric(horizontal: 2, vertical: 1.6),

          //               isScrollable: true,
          //               labelColor: tWhite,
          //               // indicatorColor: tBlack,
          //               indicator: BoxDecoration(
          //                   color: tPrimaryColor,
          //                   borderRadius: BorderRadius.circular(10.0)),

          //               tabs: [
          //                 Container(
          //                   width: 30.w,
          //                   decoration: BoxDecoration(
          //                       boxShadow: [tBoxShadow],
          //                       color: tWhite,
          //                       borderRadius: BorderRadius.circular(4)),
          //                   child: Tab(
          //                     child: Text('Today',
          //                         overflow: TextOverflow.ellipsis,
          //                         maxLines: 1,
          //                         style: TextStyle(
          //                             color: tGray,
          //                             fontSize: isTab(context) ? 7.sp : 10.sp,
          //                             fontWeight: FontWeight.w500)),
          //                   ),
          //                 ),
          //                 Container(
          //                   width: 30.w,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.only(
          //                           topRight: Radius.circular(4),
          //                           bottomRight: Radius.circular(4),
          //                           topLeft: Radius.circular(4),
          //                           bottomLeft: Radius.circular(4)),
          //                       boxShadow: [tBoxShadow],
          //                       color: tWhite),
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(horizontal: 15),
          //                     child: Tab(
          //                       child: Text('Last 7days',
          //                           overflow: TextOverflow.ellipsis,
          //                           maxLines: 1,
          //                           style: TextStyle(
          //                               color: tGray,
          //                               fontSize: isTab(context) ? 7.sp : 10.sp,
          //                               fontWeight: FontWeight.w500)),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   // width: 30.w,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.only(
          //                           topRight: Radius.circular(4),
          //                           bottomRight: Radius.circular(4),
          //                           topLeft: Radius.circular(4),
          //                           bottomLeft: Radius.circular(4)),
          //                       boxShadow: [tBoxShadow],
          //                       color: tWhite),
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(horizontal: 15),
          //                     child: Tab(
          //                       child: Text('Last 30days',
          //                           overflow: TextOverflow.ellipsis,
          //                           maxLines: 1,
          //                           style: TextStyle(
          //                               color: tGray,
          //                               fontSize: isTab(context) ? 7.sp : 10.sp,
          //                               fontWeight: FontWeight.w500)),
          //                     ),
          //                   ),
          //                 ),
          //                 Container(
          //                   width: 30.w,
          //                   decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.only(
          //                           topRight: Radius.circular(4),
          //                           bottomRight: Radius.circular(4),
          //                           topLeft: Radius.circular(4),
          //                           bottomLeft: Radius.circular(4)),
          //                       boxShadow: [tBoxShadow],
          //                       color: tWhite),
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(horizontal: 15),
          //                     child: Tab(
          //                       child: Text('Coustom',
          //                           overflow: TextOverflow.ellipsis,
          //                           maxLines: 1,
          //                           style: TextStyle(
          //                               color: tGray,
          //                               fontSize: isTab(context) ? 7.sp : 10.sp,
          //                               fontWeight: FontWeight.w500)),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Expanded(
          //         child: TabBarView(children: [
          //           TodaysEarnings(status: 1),
          //           TodaysEarnings(status: 2),
          //           TodaysEarnings(status: 3),
          //           TodaysEarnings(status: 4)
          //         ]),
          //       )
          //     ],
          //   ),
          // ),
        ));
  }
  // <<< END    _EarningPageState.build()
}
// <<< END    class _EarningPageState

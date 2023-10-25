// ignore_for_file: override_on_non_overriding_member

import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/wallet/pickCustomDate.dart';
import 'package:base_project_flutter/views/wallet/walletpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../providers/earningsProvider.dart';
import '../../../responsive.dart';

class HistoryBottomSheet extends StatefulWidget {
  const HistoryBottomSheet({Key? key, this.walletTranscation})
      : super(key: key);
  final walletTranscation;

  @override
  State<HistoryBottomSheet> createState() => _HistoryBottomSheetState();
}

class _HistoryBottomSheetState extends State<HistoryBottomSheet> {
  String filterValue = "Today";

  @override
  List<String> searchlist = ['Today', 'yesterday', 'Last Week', 'Custom'];
  var dayslist;
  Widget build(BuildContext context) {
    return Consumer<EarningsProvider>(builder: (context, provider, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: tWhite,
          height: MediaQuery.of(context).size.height / 1.8,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 18.w,
                      height: 0.7.h,
                      decoration: BoxDecoration(
                          color: tPrimaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  ListTile(
                      title: Text(
                        'today'.tr,
                        style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 9.sp : 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
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
                          filterValue = "Today";
                          widget.walletTranscation == true
                              ? Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavigation(
                                            tabIndexId: 2,
                                            selectedType: 'Today',
                                          )),
                                  (Route<dynamic> route) => false)
                              : Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavigation(
                                            tabIndexId: 1,
                                            selectedType: 'Today',
                                          )),
                                  (Route<dynamic> route) => false);
                        });
                      }),
                  ListTile(
                      title: Text(
                        'yesterday'.tr,
                        style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 9.sp : 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      //

                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.remove('filteredValue');
                        sharedPreferences.setString(
                            'filteredValue', 'Yesterday');

                        var now = new DateTime.now();
                        var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
                        String endDate = formatter.format(now);

                        String startDate = formatter
                            .format(DateTime.now().subtract(Duration(days: 1)));
                        print('dates');
                        print(startDate);
                        print(endDate);
                        sharedPreferences.remove('customFilter');
                        sharedPreferences.setString('startDate', startDate);
                        sharedPreferences.setString('endDate', endDate);
                        setState(() {
                          filterValue = "Yesterday";
                          widget.walletTranscation == true
                              ? Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavigation(
                                            tabIndexId: 2,
                                            selectedType: 'Yesterday',
                                          )),
                                  (Route<dynamic> route) => false)
                              : Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavigation(
                                            tabIndexId: 1,
                                            selectedType: 'Yesterday',
                                          )),
                                  (Route<dynamic> route) => false);
                        });
                      }),
                  ListTile(
                      title: Text(
                        'week'.tr,
                        style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 9.sp : 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();

                        sharedPreferences.remove('filteredValue');
                        sharedPreferences.setString(
                            'filteredValue', 'Last 7 Days');

                        var now = new DateTime.now();
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
                          filterValue = "Last 7 Days";
                          widget.walletTranscation == true
                              ? Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavigation(
                                            tabIndexId: 2,
                                            selectedType: 'Week',
                                          )),
                                  (Route<dynamic> route) => false)
                              : Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavigation(
                                            tabIndexId: 1,
                                            selectedType: 'Week',
                                          )),
                                  (Route<dynamic> route) => false);
                        });
                      }),
                  ListTile(
                      title: Text(
                        'custom'.tr,
                        style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 9.sp : 12.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      onTap: () async {
                        showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: '',
                          context: context,
                          pageBuilder: (ctx, a1, a2) {
                            return Container();
                          },
                          transitionBuilder: (ctx, a1, a2, child) {
                            var curve = Curves.easeInOut.transform(a1.value);
                            return PickCustomDate(
                              filterValue: filterValue,
                            );
                          },
                        );
                      }),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

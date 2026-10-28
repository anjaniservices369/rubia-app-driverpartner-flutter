// ----------------------------------------------------------------------
// History filter sheet
//
// Filter rides by date.
// ----------------------------------------------------------------------
// ignore_for_file: override_on_non_overriding_member

import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/profilePage/ridehistory/ridehistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../constants/constants.dart';
import '../../../providers/earningsProvider.dart';
import '../../../responsive.dart';

// >>> START  class HistoryBottomSheet
class HistoryBottomSheet extends StatefulWidget {
  const HistoryBottomSheet({Key? key}) : super(key: key);

  @override
  State<HistoryBottomSheet> createState() => _HistoryBottomSheetState();
}
// <<< END    class HistoryBottomSheet

// >>> START  class _HistoryBottomSheetState
class _HistoryBottomSheetState extends State<HistoryBottomSheet> {
  String filterValue = "All";

  @override
  List<String> searchlist = ['Today', 'yesterday', 'Last Week', 'Custom'];

  // >>> START  _HistoryBottomSheetState.build()  -  draws this screen / widget (its layout)
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
                            .format(DateTime.now().add(Duration(days: 0)));

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
                                  builder: (context) => MyRidesView(
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

                        var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
                        String endDate = formatter
                            .format(DateTime.now().subtract(Duration(days: 1)));

                        String startDate = formatter
                            .format(DateTime.now().subtract(Duration(days: 1)));
                        print('dates');
                        print(startDate);
                        print(endDate);
                        sharedPreferences.remove('customFilter');
                        sharedPreferences.setString('startDate', startDate);
                        sharedPreferences.setString('endDate', endDate);
                        setState(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => MyRidesView(
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
                                  builder: (context) => MyRidesView(
                                        selectedType: 'week',
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
  // <<< END    _HistoryBottomSheetState.build()
}
// <<< END    class _HistoryBottomSheetState

// >>> START  class PickCustomDate
class PickCustomDate extends StatefulWidget {
  final String filterValue;

  PickCustomDate({
    Key? key,
    required this.filterValue,
  }) : super(key: key);

  @override
  State<PickCustomDate> createState() => _PickCustomDateState();
}
// <<< END    class PickCustomDate

// >>> START  class _PickCustomDateState
class _PickCustomDateState extends State<PickCustomDate> {
  // >>> START  _PickCustomDateState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
  }
  // <<< END    _PickCustomDateState.initState()

  var startDate;
  var endDate;
  // >>> START  _PickCustomDateState._onSelectionChanged()  -  on selection changed
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    debugPrint(args.value.startDate.toString().substring(0, 10));
    debugPrint(args.value.endDate.toString());
    setState(() {
      startDate = formatter.format(args.value.startDate);
      endDate = formatter.format(args.value.endDate);
    });
  }
  // <<< END    _PickCustomDateState._onSelectionChanged()

  // >>> START  _PickCustomDateState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.primary,
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300,
            width: 400,
            child: SfDateRangePicker(
              rangeSelectionColor: tPrimaryColor.withValues(alpha: 0.4),
              startRangeSelectionColor: tPrimaryColor,
              endRangeSelectionColor: tPrimaryColor,
              rangeTextStyle: TextStyle(
                decorationColor: tWhite,
                color: tWhite,
              ),
              selectionColor: tWhite,
              yearCellStyle: DateRangePickerYearCellStyle(),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyle(color: tBlack),
                todayTextStyle: TextStyle(color: tPrimaryColor),
                disabledDatesTextStyle: TextStyle(color: tGray),
              ),
              selectionTextStyle: TextStyle(color: tWhite),
              maxDate: DateTime.now(),
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: TextStyle(
                  color: tWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                backgroundColor: tPrimaryColor.withValues(alpha: 0.7),
              ),
              backgroundColor: tWhite,
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              confirmText: 'Ok',
              cancelText: 'Cancel',
              onSubmit: (dateTime) {
                debugPrint(dateTime.toString());
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Twl.navigateBack(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: tPrimaryColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('filteredEarnigs');
                  sharedPreferences.setString('filteredEarnigs', 'Custom');
                  print('dates');
                  print(startDate);
                  print(endDate);
                  sharedPreferences.remove('customFilter');
                  sharedPreferences.setString('startDate', startDate);
                  sharedPreferences.setString('endDate', endDate);
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => MyRidesView(
                                  selectedType: 'Coustom',
                                )),
                        (Route<dynamic> route) => false);
                  });
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: tPrimaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // <<< END    _PickCustomDateState.build()
}
// <<< END    class _PickCustomDateState

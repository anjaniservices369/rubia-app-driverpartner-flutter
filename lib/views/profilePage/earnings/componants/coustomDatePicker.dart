// ----------------------------------------------------------------------
// Earnings date picker
//
// Choose a custom date range.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/profilePage/earnings/earnings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// >>> START  class EarningCoustomDate
class EarningCoustomDate extends StatefulWidget {
  final String filterValue;

  EarningCoustomDate({
    Key? key,
    required this.filterValue,
  }) : super(key: key);

  @override
  State<EarningCoustomDate> createState() => _EarningCoustomDateState();
}
// <<< END    class EarningCoustomDate

// >>> START  class _EarningCoustomDateState
class _EarningCoustomDateState extends State<EarningCoustomDate> {
  // >>> START  _EarningCoustomDateState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
  }
  // <<< END    _EarningCoustomDateState.initState()

  var startDate;
  var endDate;
  // >>> START  _EarningCoustomDateState._onSelectionChanged()  -  on selection changed
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    debugPrint(args.value.startDate.toString().substring(0, 10));
    debugPrint(args.value.endDate.toString());
    setState(() {
      startDate = formatter.format(args.value.startDate);
      endDate = formatter.format(args.value.endDate);
    });
  }
  // <<< END    _EarningCoustomDateState._onSelectionChanged()

  // >>> START  _EarningCoustomDateState.build()  -  draws this screen / widget (its layout)
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
                  sharedPreferences.setInt('initialPosition', 3);
                  sharedPreferences.setString('earningStartDate', startDate);
                  sharedPreferences.setString('earningEndDate', endDate);
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => EarningPage()),
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
  // <<< END    _EarningCoustomDateState.build()
}
// <<< END    class _EarningCoustomDateState

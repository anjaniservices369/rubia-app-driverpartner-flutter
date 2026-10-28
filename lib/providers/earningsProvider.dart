// ----------------------------------------------------------------------
// Earnings filter state
//
// Holds the date range chosen on the earnings screens.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';

// >>> START  class EarningsProvider
class EarningsProvider extends ChangeNotifier {
  String _filterValue = "All";
  var _startDate = '';
  var _endDate = '';

  String get startDate => this._startDate;
  // >>> START  EarningsProvider.startDate()  -  start date
  set startDate(value) {
    this._startDate = value;
    notifyListeners();
  }
  // <<< END    EarningsProvider.startDate()

  String get endDate => this._endDate;
  // >>> START  EarningsProvider.endDate()  -  end date
  set endDate(value) {
    this._endDate = value;
    notifyListeners();
  }
  // <<< END    EarningsProvider.endDate()

  String get filterValue => this._filterValue;
  // >>> START  EarningsProvider.filterValue()  -  filter value
  set filterValue(String value) {
    this._filterValue = value;
    notifyListeners();
  }
  // <<< END    EarningsProvider.filterValue()
}
// <<< END    class EarningsProvider

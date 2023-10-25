import 'package:flutter/material.dart';

class EarningsProvider extends ChangeNotifier {
  String _filterValue = "All";
  var _startDate = '';
  var _endDate = '';

  String get startDate => this._startDate;
  set startDate(value) {
    this._startDate = value;
    notifyListeners();
  }

  String get endDate => this._endDate;
  set endDate(value) {
    this._endDate = value;
    notifyListeners();
  }

  String get filterValue => this._filterValue;
  set filterValue(String value) {
    this._filterValue = value;
    notifyListeners();
  }
}

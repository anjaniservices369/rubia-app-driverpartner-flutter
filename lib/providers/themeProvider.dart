import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ThemeProvider with ChangeNotifier {
  bool _swithValue = false;

  bool get swithValue => _swithValue;
  void setDayMode(value) async {
    ThemeData(primarySwatch: Colors.blue, backgroundColor: tWhite);
    // tPrimaryColor = Color(0XFFFB6E1F);
    // tSecondaryColor = Color(0XFF6B0BE4);
    tBackground = Colors.white;
    tWhite = Colors.white;
    tBlack = tSecondaryColor;
    _swithValue = value;
    // tThemePrimaryColor = Color(0XFF6B0BE4);
    // tThemeSecondaryColor = Color(0XFFFB6E1F);
    // tOrange =Color(0XFF6B0BE4);
    notifyListeners();
  }

  ThemeData lightTheme =
      ThemeData(primarySwatch: Colors.blue, backgroundColor: tWhite);
  ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: tBlack,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
        subtitle1: TextStyle(color: Colors.white),
      ));
  void setNightMode(value) async {
    darkTheme;

    // tPrimaryColor = Color(0XFF6B0BE4);
    // tSecondaryColor = Color(0XFFFB6E1F);
    tWhite = tSecondaryColor;
    tBlack = Colors.white;
    tBackground = tSecondaryColor;
    _swithValue = value;
    notifyListeners();
  }
}

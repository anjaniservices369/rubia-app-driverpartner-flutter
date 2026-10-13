import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ThemeProvider with ChangeNotifier {
  bool _swithValue = false;

  bool get swithValue => _swithValue;
  void setDayMode(value) async {
    ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: tWhite);
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
      ThemeData(primarySwatch: Colors.blue, scaffoldBackgroundColor: tWhite);
  ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: tBlack,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
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

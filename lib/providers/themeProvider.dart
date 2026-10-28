// ----------------------------------------------------------------------
// Theme (day / night)
//
// Remembers whether the app uses day or night colours.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';

import '../constants/constants.dart';

// >>> START  class ThemeProvider
/// Holds the day / night colour choice.
class ThemeProvider with ChangeNotifier {
  bool _swithValue = false;

  bool get swithValue => _swithValue;
  // >>> START  ThemeProvider.setDayMode()  -  set day mode
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
  // <<< END    ThemeProvider.setDayMode()

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
  // >>> START  ThemeProvider.setNightMode()  -  set night mode
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
  // <<< END    ThemeProvider.setNightMode()
}
// <<< END    class ThemeProvider

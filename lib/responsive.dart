// ----------------------------------------------------------------------
// Screen-size helpers
//
// Tiny helpers that say whether the phone is a normal phone or a tablet, so
// screens can adjust sizes.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
bool isTab(BuildContext context) =>
    MediaQuery.of(context).size.width < 1300 &&
    MediaQuery.of(context).size.width >= 600;
bool isDesktop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1300;

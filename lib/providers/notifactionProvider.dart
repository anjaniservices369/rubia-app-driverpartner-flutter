import 'dart:developer';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNotifactionProvider extends ChangeNotifier {
  List myNotificationList = [];
  bool myNotificationGetting = false;
  int myNotificationLength = 0;
  int currentPage = 0;
  int totalPages = 0;
  String resNOK = '';
  String get _resNOK => resNOK;

  getFavorites({context, page}) async {
    myNotificationGetting = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = await UserAPI().getMyNotifaction(context, page);
    try {
      if (res['status'] == 'OK') {
        List details = res['details'];
        currentPage = res['pagination']['current_page'];
        totalPages = res['pagination']['total_pages'];
        myNotificationList = myNotificationList + details;
        details.clear();
        currentPage = currentPage + 1;
        log('current page' + currentPage.toString());
        log('total page' + totalPages.toString());
        myNotificationGetting = false;
      } else {
        resNOK = res['status'];

        myNotificationGetting = false;
      }
    } catch (e) {
      myNotificationGetting = false;
      log(e.toString());
    }

    notifyListeners();
  }
}

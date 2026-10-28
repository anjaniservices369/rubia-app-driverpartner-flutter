// ----------------------------------------------------------------------
// Notification list state
//
// Holds the list of in-app notifications.
// ----------------------------------------------------------------------
import 'dart:developer';

import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/foundation.dart';

// >>> START  class MyNotifactionProvider
class MyNotifactionProvider extends ChangeNotifier {
  List myNotificationList = [];
  bool myNotificationGetting = false;
  int myNotificationLength = 0;
  int currentPage = 0;
  int totalPages = 0;
  String resNOK = '';

  getFavorites({context, page}) async {
    myNotificationGetting = true;
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
// <<< END    class MyNotifactionProvider

import 'package:flutter/material.dart';

import '../api_services/userApi.dart';

class GlobalFunctionProvider with ChangeNotifier {
  var firstSelectedImage;
  String get _firstSelectedImage => firstSelectedImage;

  var secondSelectedImage;
  String get _secondSelectedImage => secondSelectedImage;

  List rideDetailImagesList = [];
  List get _rideDetailImagesList => rideDetailImagesList;

  storeRideDetailImages(BuildContext context, String status) async {
    rideDetailImagesList = [];
    notifyListeners();
    return _rideDetailImagesList;
  }
  // fetchFirstSelectedImage() {
  //   firstSelectedImage = '';
  //   notifyListeners();
  //   print('firstSelectedImage..> provider');
  //   print(firstSelectedImage);
  //   return firstSelectedImage;
  // }

  // fetchSecondSelectedImage() {
  //   secondSelectedImage = null;
  //   notifyListeners();
  //   return secondSelectedImage;
  // }

  clearFirstSelectedImage() {
    if (firstSelectedImage != null) {
      firstSelectedImage = null;
      notifyListeners();
      return firstSelectedImage;
    }
  }

  clearSecondSelectedImage() {
    secondSelectedImage = null;
    notifyListeners();
    return secondSelectedImage;
  }

}

// ----------------------------------------------------------------------
// Ride photo selection state
//
// Remembers which photos the driver has picked for the current ride.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';


// >>> START  class GlobalFunctionProvider
class GlobalFunctionProvider with ChangeNotifier {
  var firstSelectedImage;

  var secondSelectedImage;

  List rideDetailImagesList = [];
  List get _rideDetailImagesList => rideDetailImagesList;

  // >>> START  GlobalFunctionProvider.storeRideDetailImages()  -  store ride detail images
  storeRideDetailImages(BuildContext context, String status) async {
    rideDetailImagesList = [];
    notifyListeners();
    return _rideDetailImagesList;
  }
  // <<< END    GlobalFunctionProvider.storeRideDetailImages()
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

  // >>> START  GlobalFunctionProvider.clearFirstSelectedImage()  -  clear first selected image
  clearFirstSelectedImage() {
    if (firstSelectedImage != null) {
      firstSelectedImage = null;
      notifyListeners();
      return firstSelectedImage;
    }
  }
  // <<< END    GlobalFunctionProvider.clearFirstSelectedImage()

  // >>> START  GlobalFunctionProvider.clearSecondSelectedImage()  -  clear second selected image
  clearSecondSelectedImage() {
    secondSelectedImage = null;
    notifyListeners();
    return secondSelectedImage;
  }
  // <<< END    GlobalFunctionProvider.clearSecondSelectedImage()

}
// <<< END    class GlobalFunctionProvider

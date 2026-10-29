// ----------------------------------------------------------------------
// Address picker map
//
// A map screen where an address can be searched or chosen.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/rider_Details/componants/personal_Details.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class AddressGoogleMapPage
class AddressGoogleMapPage extends StatefulWidget {
  AddressGoogleMapPage({
    Key? key,
    this.DateOfBirth,
    this.firstName,
    this.Email,
    this.gender,
  }) : super(key: key);
  static final kInitialPosition = LatLng(17.3850, 78.4867);
  final firstName;
  final Email;
  final DateOfBirth;
  final gender;

  @override
  _AddressGoogleMapPageState createState() => _AddressGoogleMapPageState();
}
// <<< END    class AddressGoogleMapPage

// >>> START  class _AddressGoogleMapPageState
class _AddressGoogleMapPageState extends State<AddressGoogleMapPage> {
  PickResult? selectedPlace;
  late double lat;
  late double lng;
  late String formattedAddress;
  String? postalCode;
  String? pinCode;
  late String streetName1;
  late String streetName2;
  late String streetName3;
  // >>> START  _AddressGoogleMapPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PlacePicker(
        apiKey: mapKey,
        hintText: "Find a place ...",
        searchingText: "Please wait ...",
        selectText: "Select Location",
        outsideOfPickAreaText: "Place not in area",
        initialPosition: AddressGoogleMapPage.kInitialPosition,
        useCurrentLocation: true,
        selectInitialPosition: true,
        usePinPointingSearch: true,
        usePlaceDetailSearch: true,
        onPlacePicked: (result) async {
          selectedPlace = result;
          print(selectedPlace!.formattedAddress);
          print(selectedPlace!.geometry!.location.lat);
          print(selectedPlace!.geometry!.location.lng);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          // GetStorage getStorage = GetStorage();
          sharedPreferences.setString(
              "formattedAddress", selectedPlace!.formattedAddress!);
          sharedPreferences.setDouble(
              "lattitude", selectedPlace!.geometry!.location.lat);
          sharedPreferences.setDouble(
              "longitude", selectedPlace!.geometry!.location.lng);
          formattedAddress = sharedPreferences.getString('formattedAddress')!;
          lat = sharedPreferences.getDouble('lattitude')!;
          lng = sharedPreferences.getDouble('longitude')!;
          print(selectedPlace!.addressComponents![0].types.length);
          print(formattedAddress);
          print(lat);
          print(lng);
          final place = await Geocoder2.getDataFromCoordinates(
              latitude: lat,
              longitude: lng,
              googleMapApiKey: mapKey);
          try {
            print(place.address);
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(addresses.first.postalCode.toString()),
            // ));
            var first = place;
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setDouble('lattitude', lat);
            // var lat = sharedPreferences.getDouble('lattitude');
            sharedPreferences.setDouble('longitude', lng);
            // var long = sharedPreferences.getDouble('longitude');
            sharedPreferences.setString('FeatureName', first.city);
            sharedPreferences.setString('AddressLine', first.address);
            sharedPreferences.setString('Locality', first.streetNumber);
            sharedPreferences.setString('PinCode', first.postalCode);
            // var res =
            //     await UserAPI().checkDelivery(context, pinCode.toString());
            // print("ress>>>>>>>>>>>>>");
            //   print(res);
            //   if (res['status'] == 'OK' && res != null) {
            //     setState(() {
            Twl.forceNavigateTo(
                context,
                PersonalDetails(
                  DateOfBirth: widget.DateOfBirth,
                  Email: widget.Email,
                  firstName: widget.firstName,
                  gender: widget.gender,
                  address: formattedAddress,
                ));
            //     });
            //   } else {
            //     //
            //     return showDialog(
            //       context: context,
            //       builder: (BuildContext context) {
            //         return AlertDialog(
            //           title: Text("Select another Location"),
            //           content:
            //               Text('We are not able to deliver to this address'),
            //           actions: <Widget>[
            //             FlatButton(
            //               child: Text('ok'),
            //               onPressed: () {
            //                 Twl.navigateBack(context);
            //               },
            //             ),
            //           ],
            //         );
            //       },
            //     );
            //   }

            // var latLng = {
            //   'lat': lat,
            //   'lng': lng,
            // };
            // getStorage.write("latLng", latLng);
            // latLng = getStorage.read('latLng');

            //  print(latLng);
            //     try {
            //       for (var i = 0; i < selectedPlace!.addressComponents!.length; i++) {
            //         for (var j = 0;
            //             j < selectedPlace!.addressComponents![i].types.length;
            //             j++) {
            //           // print(selectedPlace!.addressComponents![i].types[j]);
            //           if (selectedPlace!.addressComponents![i].types[j] ==
            //                   "postal_code" ||
            //               selectedPlace!.addressComponents![i].types[j] ==
            //                   "postal_code_prefix") {
            //             postalCode = selectedPlace!.addressComponents![i].shortName;

            //             sharedPreferences.setString("postalCode", postalCode!);
            //             postalCode = sharedPreferences.getString('postalCode');
            //             print(postalCode);
            //           }

            //           streetName1 = selectedPlace!.addressComponents![1].longName;
            //           streetName2 = selectedPlace!.addressComponents![3].longName;
            //           streetName3 = selectedPlace!.addressComponents![5].longName;
            //           postalCode = selectedPlace!.addressComponents![7].longName;
            //           // streetName = selectedPlace!.addressComponents![3].longName;
            //           // var address = selectedPlace!.addressComponents![i].types.length;
            //           sharedPreferences.setString("streetName1", streetName1);
            //           streetName1 = sharedPreferences.getString('streetName1')!;

            //           sharedPreferences.setString("streetName2", streetName2);
            //           streetName2 = sharedPreferences.getString('streetName2')!;
            //           print("streetName2:-" + streetName2);
            //           sharedPreferences.setString("streetName3", streetName3);
            //           streetName3 = sharedPreferences.getString('streetName3')!;

            //           print("streetName1:-" + streetName1);
            //           print(streetName2);
            //           print("streetName3:-" + streetName3);
            //           var cityaddress = streetName2;
            //           var fulladdress = streetName1 + streetName2 + streetName3;
            //           print(cityaddress);
            //           // print(fulladdress);
            //           sharedPreferences.setString("AddressLine", fulladdress);
            //           sharedPreferences.setString("cityaddress", cityaddress);
            //           var address = sharedPreferences.getString('AddressLine');
            //           var cityLocation = sharedPreferences.getString('cityaddress');
            //           print(address);
            //           print('postalCode');
            //           print(postalCode);

            //           if (postalCode != null) {
            //             var res = await UserAPI()
            //                 .checkDelivery(context, postalCode.toString());
            //             if (res['status'] == 'OK' && res != null) {
            //               setState(() {
            //                 Twl.forceNavigateTo(context, BottomNavigation());
            //               });
            //             } else {
            //               //
            //               return showDialog(
            //                 context: context,
            //                 builder: (BuildContext context) {
            //                   return AlertDialog(
            //                     title: Text("Select another Location"),
            //                     content: Text(
            //                         'We are not able to deliver to this address'),
            //                     actions: <Widget>[
            //                       FlatButton(
            //                         child: Text('ok'),
            //                         onPressed: () {
            //                           Twl.navigateBack(context);
            //                         },
            //                       ),
            //                     ],
            //                   );
            //                 },
            //               );
            //             }
            //           } else {
            //             //
            //             return showDialog(
            //               context: context,
            //               builder: (BuildContext context) {
            //                 return AlertDialog(
            //                   title: Text("Check Location"),
            //                   content: Text('We able to get your Pincode'),
            //                   actions: <Widget>[
            //                     FlatButton(
            //                       child: Text('ok'),
            //                       onPressed: () {
            //                         Twl.navigateBack(context);
            //                       },
            //                     ),
            //                   ],
            //                 );
            //               },
            //             );
            //           }

            //           // Twl.navigateTo(context, BottomNavigation());
            //         }
            //       }
          } catch (e) {
            throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                  'we are anable to find your pincode. please drag the place picker'),
            ));
            //  AwesomeDialog(
            //       context: context,
            //       dialogType: DialogType.NO_HEADER,
            //       borderSide: BorderSide(color: Colors.green, width: 2),
            //       buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
            //       headerAnimationLoop: true,
            //       animType: AnimType.BOTTOMSLIDE,
            //       title: 'oops!',

            //       desc:
            //           'we are anable to find your pincode. please drag the place picker',
            //       btnOkOnPress: () {
            //         Twl.navigateBack(context);
            //       },
            //       btnOkColor: Colors.red)..show();
          }
        },

        // forceSearchOnZoomChanged: true,
        // automaticallyImplyAppBarLeading: false,
        // autocompleteLanguage: "ko",
        region: 'in',
      )),
    );
  }
  // <<< END    _AddressGoogleMapPageState.build()
}
// <<< END    class _AddressGoogleMapPageState

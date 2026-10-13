import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/providers/locationProvider.dart';
import 'package:base_project_flutter/views/bill_details/bill_details.dart';
import 'package:base_project_flutter/views/ride_info/completer_ride.dart';
import 'package:flutter/material.dart';

import 'package:base_project_flutter/constants/constants.dart';
import 'package:flutter/services.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../globalFuctions/globalFunctions.dart';

import '../../../../../responsive.dart';

import '../../constants/imageConstant.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/textfildcustom.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GeoLatLng;
import 'enter_otp_ride.dart';

class AddCarNumber extends StatefulWidget {
  const AddCarNumber({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<AddCarNumber> createState() => _AddCarNumberState();
}

class _AddCarNumberState extends State<AddCarNumber> {
  final _formKey = new GlobalKey<FormState>();

  var status = 0;
  GoogleMapController? mapController;
  GeoLatLng.LatLng? startLocation;
  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  String? licenseValidate(String value) {
    String p = "[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{1}";

    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      return 'Enter a valid car number.';
    } else {
      // Twl.navigateTo(context, ConfirmDetails());
      return null;
    }

    // return regExp.hasMatch(em);
  }

  Set<Marker> markers = Set();
  addMarkers() async {
    BitmapDescriptor markerbitmapdrop = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/icons/back.png',
    );
    print('lat lng');
    markers.add(Marker(
      markerId: MarkerId(startLocation.toString()),
      position: startLocation!, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'location',
        snippet: '',
      ),
      icon: markerbitmapdrop, //Icon for Marker
    ));
  }

  final Set<Polyline> _polylines = Set();
  GoogleMapController? _mapController;

  //map lat long fetching

  var dropLat;
  var dropLng;
  var dropPincode;
  var dropAddress;
  void fetchLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permission is denied forever, handle accordingly
      return;
    }

    if (permission == LocationPermission.denied) {
      // Permission is denied, ask for permission
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        // Permission is denied, handle accordingly
        return;
      }
    }

    // Fetch the current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Fetch the address from the position
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks.first;

    // Access the location data
    dropLat = position.latitude;
    dropLng = position.longitude;
    dropPincode = placemark.postalCode;
    dropAddress =
        '${placemark.street ?? ''},${placemark.thoroughfare ?? ''}, ${placemark.locality ?? 'Unknown address'},${placemark.administrativeArea ?? ''},${placemark.postalCode ?? ''}';

    // Use the fetched data as needed
    print('Latitude: $dropLat');
    print('Longitude: $dropLng');
    print('Address: $dropPincode');
    print('pincode: $dropAddress');
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        fetchLocation();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
    String pickupLatitude = widget.bookingDetails['pickup_latitude'];
    String pickupLongitude = widget.bookingDetails['pickup_longitude'];
    String dropLatitude = widget.bookingDetails['drop_latitude'] ?? '';
    String dropLongitude = widget.bookingDetails['drop_longitude'] ?? '';
    Set<Marker> markers = {};
    LatLng dropLatLng;
    // Create LatLng objects for pickup and drop coordinates
    LatLng pickupLatLng = LatLng(double.parse(pickupLatitude), double.parse(pickupLongitude));
    if (dropLatitude != null && dropLatitude.isNotEmpty && dropLongitude != null && dropLongitude.isNotEmpty) {
      dropLatLng = LatLng(double.parse(dropLatitude), double.parse(dropLongitude));

      markers.add(
        Marker(
          markerId: MarkerId('pickup'),
          position: pickupLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          // Add any additional properties for the marker
        ),
      );

      markers.add(
        Marker(
          markerId: MarkerId('drop'),
          position: dropLatLng,
          // Add any additional properties for the marker
        ),
      );
      _polylines.add(Polyline(
        polylineId: PolylineId("line 1"),
        visible: true,
        width: 2,
        patterns: [PatternItem.dash(30), PatternItem.gap(10)],
        points: MapsCurvedLines.getPointsOnCurve(pickupLatLng, dropLatLng),
        color: tBlack,
      ));
    } else {
      markers.add(
        Marker(
          markerId: MarkerId('pickup'),
          position: pickupLatLng,
        ),
      );
    }
    final TextEditingController _reletivenameController = TextEditingController();
    return Scaffold(
      backgroundColor: tBackground,
      body: Container(
        child: WillPopScope(
          onWillPop: () {
            return Twl.navigateBack(context);
          },
          child: Stack(
            children: [
              GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: pickupLatLng,
                  zoom: 12.0,
                ),
                polylines: _polylines,
                markers: markers,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 0),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  widget.bookingDetails['status'] == '2'
                                      ? Positioned(
                                          top: isTab(context) ? -75 : -175,
                                          right: 10,
                                          child: Container(
                                              padding: EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(color: tRed, shape: BoxShape.circle, boxShadow: [tBoxShadow]),
                                              child: Text(
                                                "sos",
                                                style:
                                                    TextStyle(color: tWhite, fontSize: isTab(context) ? 12.sp : 14.sp, fontWeight: FontWeight.bold),
                                              )),
                                        )
                                      : Container(),
                                  // Positioned(
                                  //   top: isTab(context) ? -75 : -110,
                                  //   right: 14,
                                  //   child: GestureDetector(
                                  //     // onTap: () {
                                  //     //   MapsLauncher.launchCoordinates(
                                  //     //       double.parse(widget.bookingDetails[
                                  //     //           'pickup_latitude']),
                                  //     //       double.parse(widget.bookingDetails[
                                  //     //           'pickup_longitude']));
                                  //     // },
                                  //     child: Container(
                                  //         padding: EdgeInsets.all(20.0),
                                  //         decoration: BoxDecoration(
                                  //             color: tPrimaryColor,
                                  //             shape: BoxShape.circle,
                                  //             boxShadow: [tBoxShadow]),
                                  //         child: Center(
                                  //           child: Image.asset(
                                  //             Images.LOCATIONMAP,
                                  //             scale: isTab(context) ? 3 : 4,
                                  //           ),
                                  //         )),
                                  //   ),
                                  // ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: tWhite,
                                        boxShadow: [tBoxShadow],
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.0.h),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: tPrimaryColor),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Row(
                                                      children: [
                                                        Text(widget.bookingDetails['car_model'],
                                                            style: GoogleFonts.mulish(
                                                                color: tWhite,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: isTab(context) ? 10.sp : 14.sp)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(8.0),
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tPink),
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.person,
                                                          color: tPrimaryColor,
                                                        )),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                      Text(widget.bookingDetails['user_details']['first_name'] + ' ',
                                                          style: GoogleFonts.mulish(
                                                              color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 12.sp)),
                                                      Text(widget.bookingDetails['user_details']['last_name'],
                                                          style: GoogleFonts.mulish(
                                                              color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 12.sp)),
                                                      Spacer(),
                                                      GestureDetector(
                                                        onTap: () {
                                                          launch(
                                                            "tel://" + widget.bookingDetails['user_details']['contact_no'].toString(),
                                                          );
                                                        },
                                                        child: Container(
                                                            padding: EdgeInsets.all(10.0),
                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tgreen),
                                                            child: Icon(
                                                              Icons.call,
                                                              color: tWhite,
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 2.5.h,
                                          ),
                                          Text('enter_car_number'.tr,
                                              style: GoogleFonts.mulish(
                                                  color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 11.sp : 14.sp)),
                                          SizedBox(
                                            height: 1.3.h,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: 50),
                                            child: TextFieldWidgets(
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(
                                                  "[0-9,A-Z]",
                                                )),
                                                LengthLimitingTextInputFormatter(10),
                                              ],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "car_number_Cant_Be_Empty"
                                              //         .tr;
                                              //     //
                                              //   }
                                              // },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'car_number_Cant_Be_Empty'.tr;
                                                } else {
                                                  return null;
                                                  // licenseValidate(value);
                                                }
                                              },
                                              textCapitalization: TextCapitalization.characters,
                                              keyboardType: TextInputType.text,
                                              readOnly: false,
                                              hinttext: 'AP39 AB 1234'.tr,
                                              controller: _reletivenameController,
                                            ),
                                          ),
                                          SizedBox(
                                            height: tDefaultPadding * 2,
                                          ),
                                          Center(
                                            child: SizedBox(
                                              width: isTab(context) ? 53.w : 53.w,
                                              height: isTab(context) ? 7.5.h : 6.5.h,
                                              child: Button(
                                                color: tPrimaryColor,
                                                textcolor: tWhite,
                                                bottonText: 'Start ride',
                                                onTap: (startLoading, stopLoading, btnState) async {
                                                  startLoading();
                                                  if (_formKey.currentState!.validate()) {
                                                    Map<String, String> param = {
                                                      'booking_id': widget.bookingDetails['id'].toString(),
                                                      'vehicle_number': _reletivenameController.text
                                                    };
                                                    print(param);
                                                    var res = await RideBookingsApi().getStartRideAPi(context, param);
                                                    if (res != null && res['status'] == 'OK') {
                                                      //here Data will store in firebase and starts rendering
                                                      locationProvider.startLocationUpdates(widget.bookingDetails);
                                                      Twl.forceNavigateTo(context, CompleteRide(bookingDetails: widget.bookingDetails));
                                                    } else {
                                                      Twl.createAlert(context, 'Oops', res['error'].toString());
                                                    }

                                                    stopLoading();
                                                  }
                                                  stopLoading();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

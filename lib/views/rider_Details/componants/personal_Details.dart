import 'package:app_settings/app_settings.dart';
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/globalFuctions/addressGoogleMaps.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../api_services/userApi.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';

import '../../../globalWidgets/button.dart';
import 'package:intl/intl.dart';

import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../globalWidgets/texfildtital.dart';
import '../../../globalWidgets/textfildcustom.dart';

import '../../../responsive.dart';
import '../add_Details.dart';

class PersonalDetails extends StatefulWidget {
  PersonalDetails({
    Key? key,
    this.firstName,
    this.lastName,
    this.Email,
    this.DateOfBirth,
    this.gender,
    this.address,
  }) : super(key: key);
  var firstName;
  var lastName;
  var Email;
  final DateOfBirth;
  var gender;
  var address;

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  void initState() {
    fectData();
    // TODO: implement initState
    super.initState();
  }

  @override
  var gender1;
  List<String> gender = ['Male', 'Female', 'Others'];
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _dobeController = TextEditingController();

  final TextEditingController _emailaddress = TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  bool isChecked = false;
  DateTime selectedDate = DateTime.now();
  DateTime initialDate = DateTime.now();
  bool isdropdownOpwn = false;
  var dob;
  var yearDiff;
  var _selectedDate;
  var formattedTemporaryDate;

  dateFormate(now) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  bool isSelected = false;
  bool isDateSelected = false;
  bool istextSelected = false;

  void _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: tPrimaryColor,
              onPrimary: tWhite,
              onSurface: tBlack,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: tBlack,
              ),
            ),
          ),
          child: child!,
        );
      },
      fieldHintText: 'Month/Date/Year',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
    );

    if (selectedDate != null) {
      setState(() {
        dob = dateFormate(selectedDate)!;

        DateTime now = DateTime.now();
        int age = now.year - selectedDate.year;
        if (now.month < selectedDate.month ||
            (now.month == selectedDate.month && now.day < selectedDate.day)) {
          age--;
        }
        print(age);
        // Display age confirmation message
        if (age >= 18) {
          _selectedDate = dob;
          print('_selectedDate');
          print(_selectedDate);
        } else {
          Twl.createAlert(context, 'Oops',
              'Selected date of birth is below 18 Age cannot be less than 18 years');
          print('Selected date of birth is below 18');
          // Show an error message or perform any desired action
        }
      });
    }
  }

  fectData() {
    print(widget.gender);
    setState(() {
      widget.gender == null ? null : gender1 = widget.gender;
      print(gender1);
    });
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  //Age Calculation
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    print('hiii');
    print(age.toString());
    print('hiii');
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    }
    return age;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tWhite,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.forceNavigateTo(context, AddDetailsView());
          },
        ),
        title: Text('personal_details'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w800)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, AddDetailsView());
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.6.h,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 36.w),
                              child: StepProgressIndicator(
                                totalSteps: 4,
                                currentStep: 1,
                                size: 8,
                                padding: 0,
                                selectedColor: tSecondaryColor,
                                unselectedColor: tlightGray,
                                roundedEdges: Radius.circular(10),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            TextFildTital(
                              text: 'full_name'.tr,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFieldWidgets(
                              readOnly: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: tSecondaryColor),
                              controller: _firstNameController
                                ..text = widget.firstName != null
                                    ? widget.firstName.toString()
                                    : ''
                                ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset:
                                            _firstNameController.text.length -
                                                0)),
                              onChanged: (txt) {
                                widget.firstName = txt;
                                _firstNameController.value = TextEditingValue(
                                    text: txt,
                                    selection: TextSelection.collapsed(
                                      offset: widget.firstName,
                                    ));
                              },
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'full_name_Cant_Be_Empty'.tr;
                                } else if (value.length != 1 &&
                                    value.length < 1) {
                                  return 'full_name_Must_Be_Minimum_1_Digits'
                                      .tr;
                                } else {
                                  return null;
                                }
                              },
                              hinttext: 'full_name'.tr,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            TextFildTital(
                              text: 'Email'.tr,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFieldWidgets(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email can't be empty";
                                }

                                // Remove leading and trailing whitespaces
                                String trimmedValue = value.trim();

                                // Check if the trimmed value is equal to the original value (no extra spaces)
                                if (value != trimmedValue) {
                                  return 'Email cannot contain spaces';
                                }

                                if (trimmedValue.contains(' ')) {
                                  return 'Email cannot contain spaces in the middle';
                                }

                                // Use a regular expression to validate the email format
                                if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(trimmedValue)) {
                                  return 'Enter a valid email address';
                                }


                                return null;
                              },

                              readOnly: false,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: tSecondaryColor),
                              controller: _emailaddress
                                ..text = widget.Email != null
                                    ? widget.Email.toString()
                                    : ''
                                ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: _emailaddress.text.length - 0)),
                              onChanged: (txt) {
                                widget.Email = txt;
                                _emailaddress.value = TextEditingValue(
                                    text: txt,
                                    selection: TextSelection.collapsed(
                                      offset: widget.Email,
                                    ));
                              },
                              keyboardType: TextInputType.text,
                              hinttext: 'Email'.tr,
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            TextFildTital(
                              text: 'Date_of_birth'.tr,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            GestureDetector(
                              onTap: _selectDate,
                              child: Container(
                                width: double.infinity,
                                height: 7.h,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _selectedDate != null
                                      ? _selectedDate
                                      : widget.DateOfBirth != null
                                          ? widget.DateOfBirth.toString()
                                          : 'date_Of_Birth'.tr,
                                  style: TextStyle(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: tlightGray.withOpacity(0.4),
                                  border: Border.all(
                                    color: tgreen,
                                    width: 1.0,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            TextFildTital(
                              text: 'gender'.tr,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Container(
                              height: 9.h,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              gender1 = index;
                                              print(gender1 == 0
                                                  ? 'male'
                                                  : gender1 == 1
                                                      ? 'Female'
                                                      : 'Others');
                                              print(widget.gender == 0
                                                  ? 'male'
                                                  : widget.gender == 1
                                                      ? 'Female'
                                                      : 'Others');
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 12),
                                            height: 7.2.h,
                                            width: 28.2.w,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: gender1 == index
                                                      ? tPrimaryColor
                                                      : tgreen,
                                                  width: 1),
                                              color: gender1 == index
                                                  ? tPrimaryColor
                                                  : ttextfildfillcolor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                gender[index],
                                                style: TextStyle(
                                                    color: gender1 == index
                                                        ? tWhite
                                                        : tbrown,
                                                    fontSize: isTab(context)
                                                        ? 9.sp
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            TextFildTital(
                              text: 'home_address'.tr,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            // TextFieldWidgets(
                            //   readOnly: false,
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w600,
                            //       color: tSecondaryColor),
                            //   controller: _homeAddressController
                            //     ..text = widget.address != null
                            //         ? widget.address.toString()
                            //         : ''
                            //     ..selection = TextSelection.fromPosition(
                            //         TextPosition(
                            //             offset:
                            //                 _homeAddressController.text.length -
                            //                     0)),
                            //   onChanged: (txt) {
                            //     widget.address = txt;
                            //     _homeAddressController.value = TextEditingValue(
                            //         text: txt,
                            //         selection: TextSelection.collapsed(
                            //           offset: widget.address,
                            //         ));
                            //   },
                            //   keyboardType: TextInputType.text,
                            //   hinttext: 'enter_home_address'.tr,
                            // ),

                            TextFieldWidgets(
                              readOnly: false,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tSecondaryColor,
                              ),
                              controller: _homeAddressController
                                ..text = widget.address != null ? widget.address.toString() : ''
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(offset: _homeAddressController.text.length - 0),
                                ),
                              onChanged: (txt) {
                                widget.address = txt;

                                _homeAddressController.value = TextEditingValue(
                                  text: txt,
                                  selection: TextSelection.collapsed(offset: txt.length),
                                );
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Address Cant Be Empty';
                                } else if (value.length != 1 &&
                                    value.length < 1) {
                                  return 'Address Must Be Minimum 1 Digits';
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              hinttext: 'enter_home_address'.tr,
                            ),




                            // TextFormField(
                            //   readOnly: true,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return "Home address cant be empty";
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w600,
                            //       color: tSecondaryColor),
                            //   controller: _homeAddressController
                            //     ..text = widget.address != null
                            //         ? widget.address.toString()
                            //         : ''
                            //     ..selection = TextSelection.fromPosition(
                            //         TextPosition(
                            //             offset:
                            //                 _homeAddressController.text.length -
                            //                     0)),
                            //   onChanged: (txt) {
                            //     widget.address = txt;
                            //     _homeAddressController.value = TextEditingValue(
                            //         text: txt,
                            //         selection: TextSelection.collapsed(
                            //           offset: widget.address,
                            //         ));
                            //   },
                            //   keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //     contentPadding:
                            //         EdgeInsets.symmetric(horizontal: 20),
                            //     filled: true,
                            //     fillColor: tlightGray.withOpacity(0.4),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.all(
                            //         Radius.circular(10.0),
                            //       ),
                            //     ),
                            //     disabledBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: tgreen, width: 1),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: tgreen, width: 1),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     errorBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: tgreen, width: 1),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     enabledBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: tgreen, width: 1),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     hintText: 'enter_home_address'.tr,
                            //     hintStyle: TextStyle(
                            //         color: tGray,
                            //         fontSize: isTab(context) ? 10.sp : 13.sp,
                            //         fontWeight: FontWeight.w400),
                            //     // suffixIcon: GestureDetector(
                            //     //     onTap: () {
                            //     //       Twl.forceNavigateTo(
                            //     //           context,
                            //     //           AddressGoogleMapPage(
                            //     //             firstName:
                            //     //                 _firstNameController.text,
                            //     //             Email: _emailaddress.text,
                            //     //             DateOfBirth: _selectedDate != null
                            //     //                 ? _selectedDate
                            //     //                 : widget.DateOfBirth != null
                            //     //                     ? widget.DateOfBirth
                            //     //                         .toString()
                            //     //                     : 'date_Of_Birth'.tr,
                            //     //             //_selectedDate.toString(),
                            //     //             gender: gender1,
                            //     //           ));
                            //     //     },
                            //     //     child: Image.asset(
                            //     //       Images.LOCATIONAA,
                            //     //       scale: 4,
                            //     //     )),
                            //   ),
                            // ),
                            SizedBox(
                              height: 4.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Button(
              textcolor: tWhite,
              bottonText: 'next'.tr,
              borderSide: BorderSide(
                color: tPrimaryColor,
              ),
              onTap: (startLoading, stopLoading, btnState) async {
                startLoading();
                if (_selectedDate == null && widget.DateOfBirth == null) {
                  Twl.createAlert(context, 'Oops', 'Date of birth is mandatory');
                  return;
                }

                if (gender1 == null) {
                  Twl.createAlert(context, 'Oops', 'Gender can\'t be empty');
                  return;
                }

                // Validate name field
                if (_firstNameController.text.trim().isEmpty) {
                  Twl.createAlert(context, 'Oops', 'Name can\'t be empty');
                  return;
                }

                // Validate email field
                String email = _emailaddress.text.trim();
                if (email.isEmpty) {
                  Twl.createAlert(context, 'Oops', 'Enter a valid email address');
                  return;
                }

                // Validate address field
                if (_homeAddressController.text.trim().isEmpty) {
                  Twl.createAlert(context, 'Oops', 'Address can\'t be empty');
                  return;
                }

                bool success = await sendCurrentLocation(context);
                if(!success){
                  Twl.createAlert(context, 'Oops', 'Unable to fetch your location');
                  stopLoading();
                  return;
                }
                stopLoading();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                          'Are you sure u want submit the fields..?'),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Twl.navigateBack(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: tPrimaryColor),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: tPrimaryColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Container(
                              width: 20.w,
                              height: 5.h,
                              child: SmallButton(
                                textcolor: tWhite,
                                bottonText: 'Ok'.tr,
                                borderSide: BorderSide(
                                  color: tPrimaryColor,
                                ),
                                onTap: (startLoading, stopLoading,
                                    btnState) async {
                                  startLoading();
                                  if (_formKey.currentState!.validate()) {
                                    if (_selectedDate != null ||
                                        widget.DateOfBirth != null) {
                                      if (gender1 != null) {
                                        Map<String, String> param = {
                                          'first_name':
                                              _firstNameController.text,
                                          'last_name': _lastnameController.text,
                                          'email': _emailaddress.text,
                                          'date_of_birth': widget.DateOfBirth ==
                                                  null
                                              ? _selectedDate.toString()
                                              : widget.DateOfBirth.toString(),
                                          'gender': gender1 == 0
                                              ? 'Male'
                                              : gender1 == 1
                                                  ? 'Female'
                                                  : 'Others',
                                          'address':
                                              _homeAddressController.text,
                                        };
                                        print(param);
                                        if (_formKey.currentState!.validate()) {
                                          print(param.toString());
                                          var res = await DriverDetailsApi()
                                              .updateProfileAPi(context, param);
                                          if (res != null &&
                                              res['status'] == 'OK') {
                                            Twl.forceNavigateTo(
                                                context, AddDetailsView());
                                            stopLoading();
                                          } else {
                                            stopLoading();
                                            Twl.createAlert(context, 'Oops',
                                                res['error'].toString());
                                          }
                                          //
                                          stopLoading();
                                        }
                                      } else {
                                        Twl.createAlert(context, 'Oops',
                                            'Gender Cant be empty');
                                      }
                                    } else {
                                      Twl.createAlert(context, 'Oops',
                                          'Date of birth maditory');
                                    }
                                    stopLoading();
                                  }
                                  stopLoading();
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }



  Future<bool> sendCurrentLocation(BuildContext context) async {
    print("Getting current Location");
    LocationPermission permission;

    // Check location service status
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it accordingly
      print("Location services are disabled");
      openLocationSettings(); // Open location settings
      return false;
    }

    // Check and request location permission
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      // Location permission not granted, request it
      status = await Permission.locationWhenInUse.request();
      if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
        // Handle the case when the user denies the location permission permanently
        print("Location permission denied");
        openAppSettings(); // Open app settings for the user to grant permission
        return false;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address =
          "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
      print("Getting current Location " + address);

      Map<String, String> param = {
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
      };
      var res = await UserAPI().sendLocation(context, param);
      if (res['status'] == "OK") {
        print('CheckBoundary is hitting here >>>>>>>>');
        print("sent successfully");
        return true;
      } else {
        print("not saved");
        return false;
      }
    }

    return false;
  }

  Future<void> openLocationSettings() async {
    await openAppSettings();
  }


}


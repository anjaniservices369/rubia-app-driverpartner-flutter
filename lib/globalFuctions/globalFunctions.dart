import 'dart:io';

import 'package:base_project_flutter/providers/globalFunctionProvider.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';

import 'package:intl/intl.dart';

class Twl {
  bool isLoading = true;

  late String username;
  late String sessionId;
  late String deviceToken;
  late String authCode;

//getDynamiclink Start
  Future<void> getDynamiclink() async {
    //  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;
      print(deepLink);
      final postID = deepLink!.queryParameters['storeId'];
      print(postID); //will print "123"
      if (postID != null) {
        // Navigator.pushNamed(context, deepLink.path);
        // Get.to(() => StoreviewPage(storeId: int.parse(postID)));
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    print(deepLink);
    final postID = deepLink!.queryParameters['storeId'];
    print(postID); //will print "123"
    if (postID != null) {
      // Get.to(() => StoreviewPage(storeId: int.parse(postID)));
    }
    // }
  }
//getDynamiclink end

//getImage start

  static getImage(String type) async {
    late File? _image;

    bool _loading = true;
    late String url;
    final picker = ImagePicker();
    var pickedFile;
    if (type == 'camera') {
      pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    } else if (type == 'gallery') {
      pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    }
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [CropAspectRatioPreset.ratio16x9],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: tPrimaryColor,
            toolbarWidgetColor: tWhite,
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    // setState(() {
    _loading = false;
    if (croppedFile != null) {
      File _file = File(croppedFile.path);
      print(_file.lengthSync());
      if (_file.lengthSync() < 20000000) {
        _image = File(croppedFile.path);
        print("_image");
        print(_image);
        return _image;
      } else {}
      _loading = true;
    } else {
      print('No image selected.');
    }
    // });

    if (croppedFile != null) {
      _loading = false;
      File _file = File(croppedFile.path);
      print(_file.lengthSync());
      // ignore: non_constant_identifier_names
      String ImageName = 'store-image-update';
      print("13" + ImageName);
      // ignore: unused_local_variable
      // String url;
      // Upload file
      //   FirebaseStorage storage = FirebaseStorage.instance;
      //   Reference ref =
      //       storage.ref().child("$ImageName" + DateTime.now().toString());
      //   print(ref);

      //   UploadTask uploadTask = ref.putFile(_file);
      //   print(uploadTask);

      //   // setState(() => isLoading = true);
      //   uploadTask.then((resp) async {
      //     _loading = false;
      //     url = await resp.ref.getDownloadURL();
      //     print('Image url');
      //     print(url);
      //     return url;
      //     // setState(() {
      //     //   _loading = false;
      //     //   storeimage = url;
      //     //   print('storeimage');
      //     //   print(storeimage);
      //     //   _loading = true;
      //     // });
      //   }
      //   );
    }
  }
//getImage end

  static createAlert(BuildContext context, error, errormsg) async {
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(error),
              content: Text(errormsg),
            ),
          );
        });
  }

  static willpopAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    navigateBack(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                        // gradient: tPrimaryGradientColor,
                        border: Border.all(width: 1, color: tPrimaryColor),
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
                GestureDetector(
                  onTap: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 3.5, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: tPrimaryColor),
                        // gradient: tPrimaryGradientColor,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      'Ok',
                      style: TextStyle(color: tPrimaryColor),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  static navigateTo(BuildContext context, page) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static navigateBack(BuildContext context) async {
    Navigator.pop(context);
  }

  static errorHandler(BuildContext context, errorRes) async {
    switch (errorRes) {
      case 301:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Moved Permanently'),
        ));
        break;
      case 302:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Found'),
        ));
        break;
      case 401:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Unauthorized'),
        ));
        break;
      case 403:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Forbidden'),
        ));

        break;
      case 404:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Not Found'),
        ));
        break;
      case 500:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Internal Server Error'),
        ));
        break;
      case 502:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Bad Gateway'),
        ));
        break;
      case 503:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Service Unavailable'),
        ));

        break;
      case 504:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Gateway Timeout'),
        ));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Oops!...'),
        ));
    }
  }

  static forceNavigateTo(BuildContext context, page) async {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => page));
  }

  // Date Formate
  static dateFormate(now) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

  static dateReverseFormate(now) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

  static dateTimeFormate(now) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

  static dateTime(now) {
    final DateFormat formatter = DateFormat('hh:mm aa');

    final String formatted = formatter.format(DateTime.parse(now.toString()));
    return formatted;
  }

  //time format
  static timeFormate(now) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('hh:mm a');
    final dateTime = inputFormat.parse(now);
    return outputFormat.format(dateTime);
  }

  static reviewTotal(var actualValue, var totalValue) {
    final totalPrecentage = (actualValue / totalValue) * 100;
    return totalPrecentage;
  }

  Future<String> uploadImage() async {
    var pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxHeight: 480,
      maxWidth: 640,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      File _file = File(pickedFile.path);
      String imageName = pickedFile.path;
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref =
          storage.ref().child("$imageName" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_file);
      try {
        TaskSnapshot snapshot = await uploadTask;
        String url = await snapshot.ref.getDownloadURL();
        return url;
      } catch (error) {
        print("Failed to upload image: $error");
      }
    }
    return '1';
  }

  Future<String> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final imageSource = await showBarModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 7,
                    vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, ImageSource.camera);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/Camera.png",
                                scale: isTab(context) ? 3 : 5,
                              ),
                              SizedBox(
                                height: tDefaultPadding,
                              ),
                              Text("Camera")
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context, ImageSource.gallery);
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/imageUpload.png",
                                scale: isTab(context) ? 3 : 5,
                              ),
                              SizedBox(
                                height: tDefaultPadding,
                              ),
                              Text("Gallery")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )));
    if (imageSource != null) {
      final pickedImage = await picker.pickImage(source: imageSource);
      if (pickedImage != null) {
        String imageName = pickedImage.path;
        print('imageName');
        print(imageName);
        File _file = File(pickedImage.path);
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref =
            storage.ref().child("$imageName" + DateTime.now().toString());
        UploadTask uploadTask = ref.putFile(_file);
        try {
          TaskSnapshot snapshot = await uploadTask;
          print('imageName');
          String url = await snapshot.ref.getDownloadURL();
          print('imageNamewwwwwwwwwwwww');
          print('url...>>>');
          print(url);
          return url;
        } catch (error) {
          print("Failed to upload image: $error");
        }
      }
    }
    return '1';
  }

  static wallateShowDailogBox(context, var checkDetails) {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, set) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            backgroundColor: tWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.red,
                    size: 55.0,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Low Wallet Balance",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                        fontSize: isTab(context) ? 12.sp : 14.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You have ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: tSecondaryColor,
                                fontSize: isTab(context) ? 10.sp : 12.sp),
                          ),
                          Text(
                            currencySymbol +
                                checkDetails['driver_wallet_bal'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: tPrimaryColor,
                                fontSize: isTab(context) ? 10.sp : 12.sp),
                          ),
                          checkDetails['driver_wallet_bal'] < 0
                              ? Text(
                                  " negative balance.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: tSecondaryColor,
                                      fontSize: isTab(context) ? 10.sp : 12.sp),
                                )
                              : Text(
                                  "  balance.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: tSecondaryColor,
                                      fontSize: isTab(context) ? 10.sp : 12.sp),
                                ),
                        ],
                      ),
                      Text(
                        "You have low Wallet balance please",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 10.sp : 12.sp),
                      ),
                      Text(
                        "recharge immediately to get the rides",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 10.sp : 12.sp),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Twl.navigateBack(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                      child: Text(
                                    "Go Back",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: tSecondaryColor,
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp),
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Twl.forceNavigateTo(
                                      context,
                                      BottomNavigation(
                                        tabIndexId: 2,
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration:
                                      BoxDecoration(color: tPrimaryColor),
                                  child: Center(
                                      child: Text(
                                    "Recharge Now",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: tSecondaryColor,
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

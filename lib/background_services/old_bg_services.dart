// // import 'dart:async';
// // import 'dart:convert';
// // import 'dart:ui';
// // import 'package:flutter/cupertino.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:flutter_background_service/flutter_background_service.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:sqflite/sqflite.dart';
// // import 'package:path/path.dart';
// //
// // import 'notification.dart';
// //
// // int timeInterval = 45; //in seconds
// //
// // @pragma('vm:entry-point')
// // void onStart(ServiceInstance service) async {
// //   DartPluginRegistrant.ensureInitialized();
// //   // For flutter prior to version 3.0.0
// //   // We have to register the plugin manually
// //
// //   //final box = Hive.box('peopleBox');
// //   if (service is AndroidServiceInstance) {
// //     service.setAutoStartOnBootMode(true);
// //
// //     service.on('setAsForeground').listen((event) async {
// //       await service.setAsForegroundService();
// //     });
// //
// //     service.on('setAsBackground').listen((event) async {
// //       await service.setAsBackgroundService();
// //     });
// //
// //     service.on('setAutoStartOnBootMode').listen((event) async {
// //       print(
// //           "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^6");
// //     });
// //   }
// //
// //   service.on("stop_service").listen((event) async {
// //     await service.stopSelf();
// //   });
// //   var  finalInterval;
// //
// //   var usageHours = await BackgroundService.getUsageHours();
// //   if (usageHours>1){
// //     var intervalMoreThan1 = usageHours*60;
// //     var IntervalMin = intervalMoreThan1/10;
// //     finalInterval = IntervalMin*60;
// //   }else{
// //     finalInterval = 45;
// //   }
// //   // int adjustedTimeInterval = usageHours == 1 ? 45 : ;
// //   int timeInterval = finalInterval;
// //
// //   List _locationData = [];
// //
// //   var path = await getApplicationDocumentsDirectory();
// //   Hive.init(path.path);
// //   await Hive.openBox('peopleBox');
// //   final box = Hive.box('peopleBox');
// //
// //   Timer? timer;
// //   DateTime? lastStoredTimestamp;
// //
// //   // bring to foreground
// //   //final box = Hive.box('peopleBox');
// //
// //   timer = Timer.periodic(Duration(seconds: timeInterval), (timer) async {
// //     if (service is AndroidServiceInstance) {
// //       if (await service.isForegroundService()) {
// //
// //         Geolocator.getPositionStream(
// //           locationSettings: LocationSettings(
// //             accuracy: LocationAccuracy.bestForNavigation,
// //           ),
// //         ).listen((Position position) async {
// //           final permission = await Geolocator.checkPermission();
// //           if (permission == LocationPermission.always) {
// //             service.invoke('on_location_changed', position.toJson());
// //
// //             if (lastStoredTimestamp == null ||
// //                 (position.timestamp?.difference(lastStoredTimestamp!) ??
// //                     Duration(seconds: timeInterval)).inSeconds >=
// //                     timeInterval) {
// //               // var path = await getApplicationDocumentsDirectory();
// //               // Hive.init(path.path);
// //               // await Hive.openBox('peopleBox');
// //               // final box = Hive.box('peopleBox');
// //               _locationData.add("${position.latitude},${position.longitude}");
// //
// //               print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
// //               print(usageHours);
// //               print(_locationData.length.toString());
// //               print(timeInterval);
// //               print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
// //
// //               if (box.isOpen) {
// //                 box.put(
// //                   position.timestamp.toString(),
// //                   "${position.latitude},${position.longitude}",
// //                 );
// //               } else {
// //                 var path = await getApplicationDocumentsDirectory();
// //                 Hive.init(path.path);
// //                 await Hive.openBox('peopleBox');
// //                 final box = Hive.box('peopleBox');
// //                 box.put(
// //                   position.timestamp.toString(),
// //                   "${position.latitude},${position.longitude}",
// //                 );
// //               }
// //               lastStoredTimestamp = position.timestamp;
// //             }
// //
// //
// //
// //             await NotificationService(FlutterLocalNotificationsPlugin())
// //                 .showNotification(
// //               showNotificationId: foregroundServiceNotificationId,
// //               title: "Rubia Services",
// //               body: 'Your location will be tracked during the ride',
// //               payload: "service",
// //               androidNotificationDetails: const AndroidNotificationDetails(
// //                 notificationChannelId,
// //                 notificationChannelId,
// //                 channelShowBadge: true,
// //                 ongoing: true,
// //                 playSound: false,
// //                 enableVibration: false,
// //                 icon: "assets/icons/driver.png",
// //               ),
// //             );
// //           }
// //         });
// //       }
// //     }
// //   });
// //
// // }
// //
// //
// // class BackgroundService {
// //   static Future<int> getUsageHours() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? usageHoursString = prefs.getString('usage_hours');
// //     print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
// //     print(usageHoursString);
// //     print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
// //
// //     int usageHours;
// //
// //     if (usageHoursString != null && usageHoursString.isNotEmpty) {
// //       usageHours = int.parse(usageHoursString);
// //     } else {
// //       usageHours = 1;
// //     }
// //
// //     print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
// //     print(usageHours);
// //     print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
// //
// //     return usageHours;
// //   }
// //
// //
// //
// //   //Get instance for flutter background service plugin
// //   final FlutterBackgroundService flutterBackgroundService =
// //   FlutterBackgroundService();
// //
// //   FlutterBackgroundService get instance => flutterBackgroundService;
// //
// //   Future<void> initializeService() async {
// //     await NotificationService(FlutterLocalNotificationsPlugin()).createChannel(
// //         const AndroidNotificationChannel(
// //             notificationChannelId, notificationChannelId));
// //     await flutterBackgroundService.configure(
// //       androidConfiguration: AndroidConfiguration(
// //         // this will be executed when app is in foreground or background in separated isolate
// //         onStart: onStart,
// //
// //         // auto start service
// //         autoStart: false,
// //         isForegroundMode: true,
// //         notificationChannelId: notificationChannelId,
// //         foregroundServiceNotificationId: foregroundServiceNotificationId,
// //         initialNotificationTitle: initialNotificationTitle,
// //         initialNotificationContent: initialNotificationContent,
// //       ),
// //       //Currently IOS setup is not completed.
// //       iosConfiguration: IosConfiguration(
// //         // auto start service
// //         autoStart: true,
// //         // this will be executed when app is in foreground in separated isolate
// //         onForeground: onStart,
// //       ),
// //     );
// //     await flutterBackgroundService.startService();
// //   }
// //
// //   void setServiceAsForeGround() async {
// //     flutterBackgroundService.invoke("setAsForeground");
// //   }
// //
// //   void stopService() {
// //     flutterBackgroundService.invoke("stop_service");
// //   }
// // }
//
//
// // **********************************************************
// // before removing hive
//
// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'notification.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// const String notificationChannelId = "foreground_service";
// const int foregroundServiceNotificationId = 888;
// const String initialNotificationTitle = "TRACK YOUR LOCATION";
// const String initialNotificationContent = "Initializing...";
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//
//
//   //final box = Hive.box('peopleBox');
//   if (service is AndroidServiceInstance) {
//     service.setAutoStartOnBootMode(true);
//
//     service.on('setAsForeground').listen((event) async {
//       await service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) async {
//       await service.setAsBackgroundService();
//     });
//
//     service.on('setAutoStartOnBootMode').listen((event) async {
//       // await service.setAutoStartOnBootMode(true);
//       print(
//           "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^6");
//     });
//   }
//
//   service.on("stop_service").listen((event) async {
//     await service.stopSelf();
//   });
//
//   List _locationData = [];
//
//   var path = await getApplicationDocumentsDirectory();
//   Hive.init(path.path);
//   await Hive.openBox('peopleBox');
//   final box = Hive.box('peopleBox');
//
//
//   var locationSettings = LocationSettings(
//     accuracy: LocationAccuracy.best,
//     distanceFilter: 100,
//   );
//
//    Geolocator.getPositionStream(locationSettings: locationSettings)
//       .listen((Position? position) async {
//     print('location after fixed interval >>>>>> ${position!.latitude},${position.longitude}');
//
//     final permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.always) {
//
//         _locationData.add("${position.latitude},${position.longitude}");
//         if (box.isOpen) {
//           box.put(
//             position.timestamp.toString(),
//             "${position.latitude},${position.longitude}",
//           );
//           print("cordinates added in hive >>>>>>> ${position.latitude},${position.longitude}");
//
//         } else {
//           var path = await getApplicationDocumentsDirectory();
//           Hive.init(path.path);
//           await Hive.openBox('peopleBox');
//           final box = Hive.box('peopleBox');
//           box.put(
//             position.timestamp.toString(),
//             "${position.latitude},${position.longitude}",
//           );
//           print("cordinates added in hive >>>>>>> ${position.latitude},${position.longitude}");
//
//         }
//
//         await NotificationService(FlutterLocalNotificationsPlugin())
//             .showNotification(
//           showNotificationId: foregroundServiceNotificationId,
//           title: "Rubia Services",
//           body: 'Your location will be tracked during the ride',
//           payload: "service",
//           androidNotificationDetails: const AndroidNotificationDetails(
//             notificationChannelId,
//             notificationChannelId,
//             channelShowBadge: true,
//             ongoing: true,
//             playSound: false,
//             enableVibration: false,
//             importance: Importance.max,
//             priority: Priority.high,
//             icon: "assets/icons/driver.png",
//           ),
//         );
//
//     }
//   });
//
// }
//
// class BackgroundService {
//
//   final FlutterBackgroundService flutterBackgroundService =
//   FlutterBackgroundService();
//
//   FlutterBackgroundService get instance => flutterBackgroundService;
//
//   Future<void> initializeService() async {
//     await NotificationService(FlutterLocalNotificationsPlugin()).createChannel(
//         const AndroidNotificationChannel(
//             notificationChannelId, notificationChannelId));
//     await flutterBackgroundService.configure(
//       androidConfiguration: AndroidConfiguration(
//         // this will be executed when app is in foreground or background in separated isolate
//         onStart: onStart,
//         autoStart: false,
//         isForegroundMode: true,
//         notificationChannelId: notificationChannelId,
//         foregroundServiceNotificationId: foregroundServiceNotificationId,
//         initialNotificationTitle: initialNotificationTitle,
//         initialNotificationContent: initialNotificationContent,
//       ),
//       //Currently IOS setup is not completed.
//       iosConfiguration: IosConfiguration(
//         // auto start service
//         autoStart: true,
//         // this will be executed when app is in foreground in separated isolate
//         onForeground: onStart,
//       ),
//     );
//     await flutterBackgroundService.startService();
//   }
//
//   void setServiceAsForeGround() async {
//     flutterBackgroundService.invoke("setAsForeground");
//   }
//
//   void stopService() {
//     flutterBackgroundService.invoke("stop_service");
//   }
// }




// ****************************************************

// var path = await getApplicationDocumentsDirectory();
// Hive.init(path.path);
// await Hive.openBox('peopleBox');
// final box = Hive.box('peopleBox');
// var b = box.values;
// List<dynamic> locationData = [];
// List<dynamic> loc = [];
// for (var element in b) {
//   locationData.add(element);
//   log(element.toString());
// }
// loc.add(locationData);
//
// List<Map<String, String>> formattedCoordinates = [];
//
// for (int i = 0; i < b.length; i += 1) {
//   // print(b[i]);
//   double lat = double.parse(
//       locationData[i].toString().split(',').first);
//   double lng = double.parse(
//       locationData[i].toString().split(',').last);
//
//   formattedCoordinates.add({
//     jsonEncode("lat"): jsonEncode(lat.toString()),
//     jsonEncode("lng"): jsonEncode(lng.toString()),
//   });
// }
//
// // Convert the list to a JSON string
// String jsonResult = formattedCoordinates.toString();
//
// // Print the formatted JSON
// print(jsonResult);
//
// //  locationData.add(logStr.toString());
// // print("Array converted ");
//
// // var inputJson = loc.toString();
// // // Remove the trailing comma
// // String validJson =
// //     inputJson.replaceFirst(RegExp(r',\s*]$'), ']');
// String validJson = jsonEncode(jsonResult);
// // print("validJson >>>>>>>");
// // log(locationData.toString());
// // print(validJson);
//
// if (res != null && res['status'] == 'OK') {
//   // print('stop services >>>>>>>>>>');
//   // print(locationData.toString());
//
//   Map<String, String> params1 = {
//     'booking_id':
//         widget.bookingDetails['id'].toString(),
//     'final_drop_latitude':
//         _locationData.latitude.toString(),
//     'final_drop_longitude':
//         _locationData.longitude.toString(),
//     'final_drop_address': _locationAddress,
//     'lat_long_route_map': jsonResult
//     // _data.locationEntries.toString()
//
//     // locationData.toString()
//   };
//   log(jsonResult.toString());
//
//   print('stop services >>>>>>>>>>');
//
//   var res1 = await RideBookingsApi()
//       .completeRideApi(context, params1);
//   print('res1----------------');
//   print(res1);
//   print('res1----------------------------------');
//   if (res1 != null && res1['status'] == 'OK') {
//     //   onStop();
//     backgroundService.stopService();
//     box.clear();
//     FileManager.clearLogFile();
//     setState(() {
//       logStr = '';
//     });

//****************************************************************************************************
// before implementing using booking id

//var databasesPath = await getDatabasesPath();
// String path = join(databasesPath, 'location_database.db');
// Database database = await openDatabase(path, version: 1,
//     onCreate: (Database db, int version) async {
//       await db.execute(
//           'CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, timestamp INTEGER)');
//     });
//
// List<Map<String, dynamic>> result = await database.query('locations');
//
// List<String> locationStrings = result.map((data) =>
// "${data['latitude']},${data['longitude']}").toList();
//
// List<Map<String, String>> formattedCoordinates = [];
//
// for (int i = 0; i < result.length; i++) {
//   double lat = result[i]['latitude'];
//   double lng = result[i]['longitude'];
//
//   formattedCoordinates.add({
//     'lat': lat.toString(),
//     'lng': lng.toString(),
//   });
// }
//
// String jsonResult = jsonEncode(formattedCoordinates);
//
// print(jsonResult);
//
//
// if (res != null && res['status'] == 'OK') {
//   Map<String, String> params1 = {
//     'booking_id': widget.bookingDetails['id'].toString(),
//     'final_drop_latitude': _locationData.latitude.toString(),
//     'final_drop_longitude': _locationData.longitude.toString(),
//     'final_drop_address': _locationAddress,
//     'lat_long_route_map': jsonResult,
//   };
//
//   log(jsonResult.toString());
//
//   print('stop services >>>>>>>>>>');
//
//   var res1 = await RideBookingsApi().completeRideApi(context, params1);
//   print('res1----------------');
//   print(res1);
//   print('res1----------------------------------');
//   if (res1 != null && res1['status'] == 'OK') {
//
//     // Clear the SQLite data after successfully storing in backend
//     await database.delete('locations');
//
//     // Checkingggg if the locations table is deleted
//     List<Map<String, dynamic>> checkDeletion = await database.query('locations');
//     if (checkDeletion.isEmpty) {
//       print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//       print('The locations table is deleted.');
//       print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//     } else {
//       print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//       print('locations table NOTTTTTTTTT deleted');
//       print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//     }
//
//     backgroundService.stopService();
//     setState(() {
//       logStr = '';
//     });
//
// *******************************************************************
//sqlite final including booking id

//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// import 'notification.dart';
//
// const String notificationChannelId = "foreground_service";
// const int foregroundServiceNotificationId = 888;
// const String initialNotificationTitle = "TRACK YOUR LOCATION";
// const String initialNotificationContent = "Initializing...";
//
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//
//   DartPluginRegistrant.ensureInitialized();
//
//   if (service is AndroidServiceInstance) {
//     service.setAutoStartOnBootMode(true);
//
//     service.on('setAsForeground').listen((event) async {
//       await service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) async {
//       await service.setAsBackgroundService();
//     });
//
//     service.on('setAutoStartOnBootMode').listen((event) async {
//       // await service.setAutoStartOnBootMode(true);
//       print(
//           "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^6");
//     });
//   }
//
//   int  fetchInterval = 1000;
//   String? booking_id = '';
//
//   var trip_type = await BackgroundService.getTripType();
//   if (trip_type == 1){
//     fetchInterval = 2000;
//     print("fetch interval : $fetchInterval");
//   }else if(trip_type == 2){
//     fetchInterval = 2;
//     print("fetch interval : $fetchInterval");
//   }else{
//     fetchInterval = 1000;
//     print("fetch interval : $fetchInterval");
//   }
//   booking_id = await BackgroundService.getBookingId();
//
//
//   var databasesPath = await getDatabasesPath();
//   String path = join(databasesPath, 'location_database.db');
//   Database database = await openDatabase(path, version: 1,
//       onCreate: (Database db, int version) async {
//         await db.execute(
//             'CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, bookingId INTEGER, latitude REAL, longitude REAL, timestamp INTEGER)');
//
//       });
//
//   LocationSettings locationSettings = LocationSettings(
//     accuracy: LocationAccuracy.best,
//     distanceFilter: fetchInterval,
//     // accuracy: LocationAccuracy.bestForNavigation,
//     // distanceFilter: 2,
//   );
//
//   StreamSubscription<Position?>? positionStreamSubscription;
//
//   void addLocationToDatabase(Position position, String? bookingId) async {
//     Map<String, dynamic> locationData = {
//       'bookingId': bookingId,
//       'latitude': position.latitude,
//       'longitude': position.longitude,
//       'timestamp': position.timestamp?.millisecondsSinceEpoch,
//     };
//
//     await database.insert('locations', locationData,
//         conflictAlgorithm: ConflictAlgorithm.replace);
//
//     print("Coordinates added in SQLite >>>>>>> ${position.latitude},${position.longitude} for Booking ID: $bookingId");
//
//     await NotificationService(FlutterLocalNotificationsPlugin())
//         .showNotification(
//       showNotificationId: foregroundServiceNotificationId,
//       title: "Rubia Services",
//       body: 'Your location will be tracked during the ride',
//       payload: "service",
//       androidNotificationDetails: const AndroidNotificationDetails(
//         notificationChannelId,
//         notificationChannelId,
//         channelShowBadge: true,
//         ongoing: true,
//         playSound: false,
//         enableVibration: false,
//         importance: Importance.max,
//         priority: Priority.high,
//         icon: "assets/icons/driver.png",
//       ),
//     );
//   }
//
//
//
//   positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
//       .listen((Position? position) async {
//     print('location after fixed interval >>>>>> ${position!.latitude},${position.longitude}');
//
//     final permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.always) {
//       addLocationToDatabase(position,booking_id);
//     }
//   });
//
//   service.on('invoke').listen((event) async {
//     print("Service invoked");
//   });
//
//   service.on("stop_service").listen((event) async {
//     // Clean up and stop the service
//     positionStreamSubscription?.cancel();
//     await service.stopSelf();
//   });
// }
//
// class BackgroundService {
//
//   static Future<int> getTripType() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? tripTypeString = prefs.getString('trip_type');
//     print("tripTypeStringkkkkkkkkkkkkkkkkkkkkkkkkkk");
//     print(tripTypeString);
//     print("tripTypeStringkkkkkkkkkkkkkkkkkkkkkkkkkkk");
//
//     int trip_type;
//
//     if (tripTypeString != null && tripTypeString.isNotEmpty) {
//       trip_type = int.parse(tripTypeString);
//     } else {
//       trip_type = 1;
//     }
//
//
//     print("tripTypeStringjjjjjjjjjjjjjjjjjjjjjjjj");
//     print(trip_type);
//     print("tripTypeStringjjjjjjjjjjjjjjjjjjjjjjjj");
//
//     return trip_type;
//   }
//
//   static Future<String?> getBookingId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? bookingIdd = prefs.getString('booking_id');
//     print("getBookingIdkkkkkkkkkkkkkkkkkkkkkkkk");
//     print(bookingIdd);
//     print("getBookingIdkkkkkkkkkkkkkkkkkkkkkkkk");
//
//
//     if (bookingIdd != null && bookingIdd.isNotEmpty) {
//       bookingIdd = bookingIdd;
//     }
//
//
//     print("getBookingIdjjjjjjjjjjjjjjjjjjjjjjjj");
//     print(bookingIdd);
//     print("getBookingIdjjjjjjjjjjjjjjjjjjjjjjj");
//
//     return bookingIdd;
//   }
//
//
//   final FlutterBackgroundService flutterBackgroundService =
//   FlutterBackgroundService();
//
//   FlutterBackgroundService get instance => flutterBackgroundService;
//
//   Future<void> initializeService() async {
//     await NotificationService(FlutterLocalNotificationsPlugin()).createChannel(
//         const AndroidNotificationChannel(
//             notificationChannelId, notificationChannelId));
//     await flutterBackgroundService.configure(
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         autoStart: false,
//         isForegroundMode: true,
//         notificationChannelId: notificationChannelId,
//         foregroundServiceNotificationId: foregroundServiceNotificationId,
//         initialNotificationTitle: initialNotificationTitle,
//         initialNotificationContent: initialNotificationContent,
//       ),
//       iosConfiguration: IosConfiguration(
//         autoStart: true,
//         onForeground: onStart,
//       ),
//     );
//     await flutterBackgroundService.startService();
//   }
//
//   void setServiceAsForeground() async {
//     flutterBackgroundService.invoke('setAsForeground');
//   }
//
//   void stopService() {
//     flutterBackgroundService.invoke('stop_service');
//   }
// }

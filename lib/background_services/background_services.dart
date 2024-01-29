import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'notification.dart';

const String notificationChannelId = "foreground_service";
const int foregroundServiceNotificationId = 888;
const String initialNotificationTitle = "TRACK YOUR LOCATION";
const String initialNotificationContent = "Initializing...";

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {

  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.setAutoStartOnBootMode(true);

    service.on('setAsForeground').listen((event) async {
      await service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) async {
      await service.setAsBackgroundService();
    });

    service.on('setAutoStartOnBootMode').listen((event) async {
      // await service.setAutoStartOnBootMode(true);
      print(
          "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^6");
    });
  }

  int  fetchInterval = 1000;
  String? booking_id = '';

  var trip_type = await BackgroundService.getTripType();
  if (trip_type == 1){
    fetchInterval = 2000;
    print("fetch interval : $fetchInterval");
  }else if(trip_type == 2){
    fetchInterval = 5000;
    print("fetch interval : $fetchInterval");
  }else{
    fetchInterval = 1000;
    print("fetch interval : $fetchInterval");
  }
  booking_id = await BackgroundService.getBookingId();

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'location_database.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE locations (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, timestamp INTEGER)');
      });

LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: fetchInterval,
    // accuracy: LocationAccuracy.bestForNavigation,
    // distanceFilter: 2,
  );

  StreamSubscription<Position?>? positionStreamSubscription;

  void addLocationToDatabase(Position position) async {
    Map<String, dynamic> locationData = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': position.timestamp?.millisecondsSinceEpoch,
    };

    await database.insert('locations', locationData,
        conflictAlgorithm: ConflictAlgorithm.replace);

    print("coordinates added in SQLite >>>>>>> ${position.latitude},${position.longitude}");

    await NotificationService(FlutterLocalNotificationsPlugin())
        .showNotification(
      showNotificationId: foregroundServiceNotificationId,
      title: "Rubia Services",
      body: 'Your location will be tracked during the ride',
      payload: "service",
      androidNotificationDetails: const AndroidNotificationDetails(
        notificationChannelId,
        notificationChannelId,
        channelShowBadge: true,
        ongoing: true,
        playSound: false,
        enableVibration: false,
        importance: Importance.max,
        priority: Priority.high,
        icon: "assets/icons/driver.png",
      ),
    );
  }



  positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position? position) async {
    print('location after fixed interval >>>>>> ${position!.latitude},${position.longitude}');

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      addLocationToDatabase(position);
    }
  });

  service.on('invoke').listen((event) async {
    print("Service invoked");
  });

  service.on("stop_service").listen((event) async {
    // Clean up and stop the service
    positionStreamSubscription?.cancel();
    await service.stopSelf();
  });
}

class BackgroundService {
  final FlutterBackgroundService flutterBackgroundService =
  FlutterBackgroundService();

  FlutterBackgroundService get instance => flutterBackgroundService;


  static Future<int> getTripType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tripTypeString = prefs.getString('trip_type');
    print("tripTypeStringkkkkkkkkkkkkkkkkkkkkkkkkkk");
    print(tripTypeString);
    print("tripTypeStringkkkkkkkkkkkkkkkkkkkkkkkkkkk");

    int trip_type;

    if (tripTypeString != null && tripTypeString.isNotEmpty) {
      trip_type = int.parse(tripTypeString);
    } else {
      trip_type = 1;
    }


    print("tripTypeStringjjjjjjjjjjjjjjjjjjjjjjjj");
    print(trip_type);
    print("tripTypeStringjjjjjjjjjjjjjjjjjjjjjjjj");

    return trip_type;
  }

  static Future<String?> getBookingId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? bookingIdd = prefs.getString('booking_id');
    print("getBookingIdkkkkkkkkkkkkkkkkkkkkkkkk");
    print(bookingIdd);
    print("getBookingIdkkkkkkkkkkkkkkkkkkkkkkkk");


    if (bookingIdd != null && bookingIdd.isNotEmpty) {
      bookingIdd = bookingIdd;
    }


    print("getBookingIdjjjjjjjjjjjjjjjjjjjjjjjj");
    print(bookingIdd);
    print("getBookingIdjjjjjjjjjjjjjjjjjjjjjjj");

    return bookingIdd;
  }


  Future<void> initializeService() async {
    await NotificationService(FlutterLocalNotificationsPlugin()).createChannel(
        const AndroidNotificationChannel(
            notificationChannelId, notificationChannelId));
    await flutterBackgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: notificationChannelId,
        foregroundServiceNotificationId: foregroundServiceNotificationId,
        initialNotificationTitle: initialNotificationTitle,
        initialNotificationContent: initialNotificationContent,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
      ),
    );
    await flutterBackgroundService.startService();
  }

  void setServiceAsForeground() async {
    flutterBackgroundService.invoke('setAsForeground');
  }

  void stopService() {
    flutterBackgroundService.invoke('stop_service');
  }
}
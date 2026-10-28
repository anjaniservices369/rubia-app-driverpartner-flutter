// ----------------------------------------------------------------------
// Ride-tracking background service
//
// While a ride is in progress this keeps recording the driver's route even
// if the app is minimised, and shows the 'location is being tracked'
// notification.
//
// Developer note: Android 14 requires the foreground service type 'location'
// (manifest + AndroidConfiguration.foregroundServiceTypes).
// ----------------------------------------------------------------------
import 'dart:async';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:base_project_flutter/api_services/locationPing.dart';
import 'notification.dart';

const String notificationChannelId = "foreground_service";
const int foregroundServiceNotificationId = 888;
const String initialNotificationTitle = "TRACK YOUR LOCATION";
const String initialNotificationContent = "Initializing...";

// >>> START  pragma()
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

  // A reading is taken every 20 metres. (This number used to be 2000 for an in-city ride and 5000 for an outstation ride, but the
  // setting is a DISTANCE in metres, not a time: a short trip recorded nothing and a long one one point per 5 km.) The server adds up
  // the distance from these readings, so the denser they are the more exact the bill; LocationPing sends one at most every 10 seconds.
  const int fetchInterval = 20;

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'location_database.db');
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE locations (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, timestamp INTEGER)');
      });
  // This service starts when a ride is about to start, so points left over from a ride that was cancelled or crashed (they are only
  // cleared after a clean completion) must not become part of this one.
  await database.delete('locations');
  bool trackingNoticeShown = false;

LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: fetchInterval,
    // accuracy: LocationAccuracy.bestForNavigation,
    // distanceFilter: 2,
  );

  StreamSubscription<Position?>? positionStreamSubscription;

  // >>> START  addLocationToDatabase()  -  add location to database
  void addLocationToDatabase(Position position) async {
    Map<String, dynamic> locationData = {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': position.timestamp.millisecondsSinceEpoch,
    };

    await database.insert('locations', locationData,
        conflictAlgorithm: ConflictAlgorithm.replace);

    print("coordinates added in SQLite >>>>>>> ${position.latitude},${position.longitude}");

    // The 'location is being tracked' notice is shown once; with a reading every 20 m, posting it again for every point is wasted work.
    if (trackingNoticeShown) return;
    trackingNoticeShown = true;
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
  // <<< END    addLocationToDatabase()



  positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position? position) async {
    print('location after fixed interval >>>>>> ${position!.latitude},${position.longitude}');

    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always) {
      addLocationToDatabase(position);
      // Keep the admin live map fresh during rides (throttled inside).
      LocationPing.send(position.latitude, position.longitude,
          handleExpiredSession: false,
          accuracy: position.accuracy,
          speedKmh: position.speed * 3.6,
          recordedAt: position.timestamp);
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
// <<< END    pragma()

// >>> START  class BackgroundService
/// Starts and stops the Android foreground service that records the route during a ride.
class BackgroundService {
  final FlutterBackgroundService flutterBackgroundService =
  FlutterBackgroundService();

  FlutterBackgroundService get instance => flutterBackgroundService;


  // >>> START  BackgroundService.getTripType()  -  get trip type
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
  // <<< END    BackgroundService.getTripType()

  // >>> START  BackgroundService.getBookingId()  -  get booking id
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
  // <<< END    BackgroundService.getBookingId()


  // >>> START  BackgroundService.initializeService()  -  initialize service
  Future<void> initializeService() async {
    await NotificationService(FlutterLocalNotificationsPlugin()).createChannel(
        const AndroidNotificationChannel(
            notificationChannelId, notificationChannelId));
    await flutterBackgroundService.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        foregroundServiceTypes: [AndroidForegroundType.location],
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
  // <<< END    BackgroundService.initializeService()

  // >>> START  BackgroundService.setServiceAsForeground()  -  set service as foreground
  void setServiceAsForeground() async {
    flutterBackgroundService.invoke('setAsForeground');
  }
  // <<< END    BackgroundService.setServiceAsForeground()

  // >>> START  BackgroundService.stopService()  -  stop service
  void stopService() {
    flutterBackgroundService.invoke('stop_service');
  }
  // <<< END    BackgroundService.stopService()
}
// <<< END    class BackgroundService
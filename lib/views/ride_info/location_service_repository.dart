// ----------------------------------------------------------------------
// Background locator storage
//
// Stores location updates received from the background plugin.
// ----------------------------------------------------------------------
import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:background_locator_2/location_dto.dart';

import 'file_manager.dart';

// >>> START  class LocationServiceRepository
class LocationServiceRepository {
  static LocationServiceRepository _instance = LocationServiceRepository._();

  LocationServiceRepository._();

  // >>> START  LocationServiceRepository.LocationServiceRepository()  -  constructor (receives the values this class needs)
  factory LocationServiceRepository() {
    return _instance;
  }
  // <<< END    LocationServiceRepository.LocationServiceRepository()

  static const String isolateName = 'LocatorIsolate';

  int _count = -1;

  // >>> START  LocationServiceRepository.init()
  Future<void> init(Map<dynamic, dynamic> params) async {
    //TODO change logs
    print("***********Init callback handler");
    if (params.containsKey('countInit')) {
      dynamic tmpCount = params['countInit'];
      if (tmpCount is double) {
        _count = tmpCount.toInt();
      } else if (tmpCount is String) {
        _count = int.parse(tmpCount);
      } else if (tmpCount is int) {
        _count = tmpCount;
      } else {
        _count = -2;
      }
    } else {
      _count = 0;
    }
    print("$_count");
    // await setLogLabel("start");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }
  // <<< END    LocationServiceRepository.init()

  // >>> START  LocationServiceRepository.dispose()  -  cleanup when the screen closes
  Future<void> dispose() async {
    print("***********Dispose callback handler");
    print("$_count");
    // await setLogLabel("end");
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(null);
  }
  // <<< END    LocationServiceRepository.dispose()

  // >>> START  LocationServiceRepository.callback()
  Future<void> callback(LocationDto locationDto) async {
    print('$_count location in dart: ${locationDto.toString()}');
    await setLogPosition(_count, locationDto);
    final SendPort? send = IsolateNameServer.lookupPortByName(isolateName);
    send?.send(locationDto.toJson());
    _count++;
  }
  // <<< END    LocationServiceRepository.callback()

  // >>> START  LocationServiceRepository.setLogLabel()  -  set log label
  static Future<void> setLogLabel(String label) async {
    final date = DateTime.now();
    await FileManager.writeToLogFile('------------\n$label: ${formatDateLog(date)}\n------------\n');
  }
  // <<< END    LocationServiceRepository.setLogLabel()

  // static List<Map<String, double>> logPositions = [];
  // static Future<void> setLogPosition(int count, LocationDto data) async {
  //   final date = DateTime.now();
  //   // await FileManager.writeToLogFile(
  //   //     '$count : ${formatDateLog(date)} --> ${formatLog(data)} --- isMocked: ${data.isMocked}\n');
  //   logPositions.add({"lat": data.latitude, "lng": data.longitude});

  //   // Write the updated logPositions list to the log file in the desired format
  //   final logText = logPositions
  //       .map((entry) => "{lat: ${entry["lat"]}, lng: ${entry["lng"]}}")
  //       .toList()
  //       .join(', ');

  //   await FileManager.writeToLogFile('[$logText]');
  // }
  static List<Map<String, String>> logPositions = [];

  // >>> START  LocationServiceRepository.setLogPosition()  -  set log position
  static Future<void> setLogPosition(int count, LocationDto data) async {
    // logPositions.add({
    //   "lat": data.latitude.toString(),
    //   "lng": data.longitude.toString(),
    // });
    // print("Here I am ");
    // print(">>> " + logPositions.toString());

    // Write the updated logPositions list to the log file in the desired format
    // final logText = logPositions.map((entry) => '{"lat": "${entry["lat"]}", "lng": "${entry["lng"]}"}').join(',');
    final logText = '{"lat": "${data.latitude.toString()}", "lng": "${data.longitude.toString()}"}' + ',';
    print(data.latitude.toString());
    print("last value >>>>" + logText.toString());
    await FileManager.writeToLogFile(logText);
  }
  // <<< END    LocationServiceRepository.setLogPosition()

  // >>> START  LocationServiceRepository.dp()
  static double dp(double val, int places) {
    num mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }
  // <<< END    LocationServiceRepository.dp()

  // >>> START  LocationServiceRepository.formatDateLog()  -  format date log
  static String formatDateLog(DateTime date) {
    return date.hour.toString() + ":" + date.minute.toString() + ":" + date.second.toString();
  }
  // <<< END    LocationServiceRepository.formatDateLog()

  // >>> START  LocationServiceRepository.formatLog()  -  format log
  static String formatLog(LocationDto locationDto) {
    return dp(locationDto.latitude, 4).toString() + " " + dp(locationDto.longitude, 4).toString();
  }
  // <<< END    LocationServiceRepository.formatLog()
}
// <<< END    class LocationServiceRepository

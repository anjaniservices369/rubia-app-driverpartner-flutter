// ----------------------------------------------------------------------
// Ride-offer poller (switched off)
//
// Would check for new ride offers every 5 seconds, ring a tone and show an
// accept/reject pop-up. Switched off in the driver app.
//
// Developer note: Gated by skipperOffersEnabled in apiConstants.dart.
// ----------------------------------------------------------------------
import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:base_project_flutter/api_services/skipperApi.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/views/skipperRide/skipperRideScreen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

// >>> START  class OfferService
/// While the partner is online: posts position and polls `new-request` every
/// 5 s, rings a looping tone and shows an accept/reject dialog for new offers.
/// A `type=newOrder` push triggers an immediate poll ([pollNow]).
class OfferService {
  static const Duration _interval = Duration(seconds: 5);

  static Timer? _timer;
  static bool _polling = false;
  static bool _dialogOpen = false;
  static bool _hasActiveRide = false;
  static final Set<String> _handled = {};
  static AudioPlayer? _player;

  static bool get isRunning => _timer != null;

  // >>> START  OfferService.start()
  static void start() {
    if (!skipperOffersEnabled || isRunning) return;
    SkipperApi.updateOnlineStatus(true);
    _timer = Timer.periodic(_interval, (_) => pollNow());
    pollNow();
  }
  // <<< END    OfferService.start()

  /// [notifyOffline] is false when the session is already gone.
  static void stop({bool notifyOffline = true}) {
    if (!isRunning) return;
    _timer?.cancel();
    _timer = null;
    _stopRinging();
    if (notifyOffline) SkipperApi.updateOnlineStatus(false);
  }

  static void rideFinished() => _hasActiveRide = false;

  // >>> START  OfferService.pollNow()  -  poll now
  static Future<void> pollNow() async {
    if (!isRunning || _polling) return;
    _polling = true;
    try {
      await _postPosition();
      if (_dialogOpen || _hasActiveRide) return;

      final res = await SkipperApi.newRequests();
      if (!SkipperApi.isOk(res)) return; // NOK = nothing new
      final details = res!['details'];
      if (details is! List) return;

      for (final item in details) {
        if (item is! Map) continue;
        final id = item['id']?.toString();
        if (id == null || _handled.contains(id)) continue;
        _showOffer(id, Map<String, dynamic>.from(item));
        break;
      }
    } catch (e) {
      print('OfferService poll error: $e');
    } finally {
      _polling = false;
    }
  }
  // <<< END    OfferService.pollNow()

  // >>> START  OfferService._postPosition()  -  post position
  static Future<void> _postPosition() async {
    try {
      final pos = await Geolocator.getLastKnownPosition() ??
          await Geolocator.getCurrentPosition();
      await SkipperApi.updateLatLng(pos.latitude, pos.longitude);
    } catch (_) {}
  }
  // <<< END    OfferService._postPosition()

  // >>> START  OfferService._pick()
  static String _pick(Map<String, dynamic> m, List<String> keys) {
    for (final k in keys) {
      final v = m[k];
      if (v != null && v.toString().isNotEmpty) return v.toString();
    }
    return '-';
  }
  // <<< END    OfferService._pick()

  // >>> START  OfferService._showOffer()  -  show offer
  static Future<void> _showOffer(String id, Map<String, dynamic> offer) async {
    _dialogOpen = true;
    _startRinging();

    final user = offer['user'] is Map ? offer['user'] as Map : const {};
    final pickup = _pick(offer, [
      'pickup_address',
      'pickup_location',
      'pickup',
      'from_address',
      'source_address',
    ]);
    final drop = _pick(offer, [
      'drop_address',
      'drop_location',
      'drop',
      'to_address',
      'destination_address',
    ]);
    final fare = _pick(offer, ['total_fare', 'fare']);

    final accepted = await Get.dialog<bool>(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('New ride request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user['username'] != null) Text('Rider: ${user['username']}'),
              const SizedBox(height: 6),
              Text('Pickup: $pickup'),
              Text('Drop: $drop'),
              const SizedBox(height: 6),
              Text('Fare: $fare   (${_pick(offer, ['payment_method'])})'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('Reject')),
            ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: const Text('Accept')),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    _stopRinging();
    _handled.add(id);

    final res = await SkipperApi.acceptOrReject(id, accepted == true);
    _dialogOpen = false;

    if (accepted == true) {
      if (SkipperApi.isOk(res)) {
        _hasActiveRide = true;
        final details = res!['details'];
        Get.to(() => SkipperRideScreen(
              rideRequestId: id,
              offer: offer,
              accepted: details is Map
                  ? Map<String, dynamic>.from(details)
                  : <String, dynamic>{},
            ));
      } else {
        // e.g. "Some other Skipper has accepted the ride..."
        Get.snackbar('Ride not assigned', SkipperApi.errorOf(res));
      }
    }
  }
  // <<< END    OfferService._showOffer()

  // >>> START  OfferService._startRinging()  -  start ringing
  static Future<void> _startRinging() async {
    try {
      _player ??= AudioPlayer();
      await _player!.setReleaseMode(ReleaseMode.loop);
      await _player!.play(AssetSource('tones/noti.mp3'));
    } catch (e) {
      print('OfferService ring error: $e');
    }
  }
  // <<< END    OfferService._startRinging()

  // >>> START  OfferService._stopRinging()  -  stop ringing
  static Future<void> _stopRinging() async {
    try {
      await _player?.stop();
    } catch (_) {}
  }
  // <<< END    OfferService._stopRinging()
}
// <<< END    class OfferService

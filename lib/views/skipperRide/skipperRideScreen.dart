import 'package:base_project_flutter/api_services/offerService.dart';
import 'package:base_project_flutter/api_services/skipperApi.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

/// Minimal progress screen for a ride accepted through the skipper flow:
/// accepted(4) -> on the way(5) -> arrived(6) -> start with rider OTP(8)
/// -> completed(9).
class SkipperRideScreen extends StatefulWidget {
  final String rideRequestId;
  final Map<String, dynamic> offer;
  final Map<String, dynamic> accepted;

  const SkipperRideScreen({
    Key? key,
    required this.rideRequestId,
    required this.offer,
    required this.accepted,
  }) : super(key: key);

  @override
  State<SkipperRideScreen> createState() => _SkipperRideScreenState();
}

class _SkipperRideScreenState extends State<SkipperRideScreen> {
  int _status = RIDE_ACCEPTED;
  bool _busy = false;
  final _otp = TextEditingController();

  String get _label {
    switch (_status) {
      case RIDE_ACCEPTED:
        return 'On the way to pickup';
      case RIDE_ON_THE_WAY:
        return 'I have arrived';
      case RIDE_ARRIVED:
        return 'Start ride';
      case RIDE_STARTED:
        return 'Complete ride';
      default:
        return 'Done';
    }
  }

  String _pick(List<String> keys) {
    for (final k in keys) {
      final v = widget.offer[k];
      if (v != null && v.toString().isNotEmpty) return v.toString();
    }
    return '-';
  }

  Future<void> _advance() async {
    setState(() => _busy = true);
    Map<String, dynamic>? res;
    int next = _status;

    switch (_status) {
      case RIDE_ACCEPTED:
        next = RIDE_ON_THE_WAY;
        res = await SkipperApi.changeStatus(widget.rideRequestId, next);
        break;
      case RIDE_ON_THE_WAY:
        next = RIDE_ARRIVED;
        res = await SkipperApi.changeStatus(widget.rideRequestId, next);
        break;
      case RIDE_ARRIVED:
        next = RIDE_STARTED;
        res = await SkipperApi.verifyRideOtp(
            widget.rideRequestId, _otp.text.trim());
        break;
      case RIDE_STARTED:
        next = RIDE_COMPLETED;
        double? lat, lng;
        try {
          final pos = await Geolocator.getCurrentPosition();
          lat = pos.latitude;
          lng = pos.longitude;
        } catch (_) {}
        res = await SkipperApi.changeStatus(widget.rideRequestId, next,
            finalLat: lat, finalLng: lng);
        break;
    }

    if (!mounted) return;
    setState(() => _busy = false);

    if (SkipperApi.isOk(res)) {
      if (next == RIDE_COMPLETED) {
        OfferService.rideFinished();
        Get.back();
      } else {
        setState(() => _status = next);
      }
    } else {
      Get.snackbar('Could not update ride', SkipperApi.errorOf(res));
    }
  }

  @override
  void dispose() {
    _otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.offer['user'];
    final name = widget.accepted['name'] ?? (user is Map ? user['username'] : null);
    return WillPopScope(
      // Leaving mid-ride would strand the ride; complete it first.
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Current ride'),
            automaticallyImplyLeading: false),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (name != null)
                Text('Rider: $name', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              Text(
                  'Pickup: ${_pick(['pickup_address', 'pickup_location', 'pickup', 'from_address', 'source_address'])}'),
              Text(
                  'Drop: ${_pick(['drop_address', 'drop_location', 'drop', 'to_address', 'destination_address'])}'),
              Text('Fare: ${_pick(['total_fare', 'fare'])}'),
              const SizedBox(height: 24),
              if (_status == RIDE_ARRIVED)
                TextField(
                  controller: _otp,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Rider's OTP", border: OutlineInputBorder()),
                ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _busy ? null : _advance,
                  child: _busy
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(_label),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

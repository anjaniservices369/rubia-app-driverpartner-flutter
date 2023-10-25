import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GeoLatLong;
import 'package:provider/provider.dart';
import 'package:base_project_flutter/providers/locationProvider.dart';

class RideMap extends StatelessWidget {
  final bookingDetails;

  const RideMap({required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final rideData =
        locationProvider.getRideData(bookingDetails['id'].toString());

    if (rideData != null && rideData.isNotEmpty) {
      final GeoLatLong.LatLngBounds bounds = calculateBounds(rideData);
      final center = GeoLatLong.LatLng(
        (bounds.southwest.latitude + bounds.northeast.latitude) / 2,
        (bounds.southwest.longitude + bounds.northeast.longitude) / 2,
      );
      return GeoLatLong.GoogleMap(
        initialCameraPosition: GeoLatLong.CameraPosition(
          target: center,
          zoom: 12.0,
        ),
        polygons: {
          GeoLatLong.Polygon(
            polygonId: GeoLatLong.PolygonId(bookingDetails['id'].toString()),
            points: rideData,
            strokeWidth: 2,
            strokeColor: Colors.blue,
            fillColor: Colors.blue.withOpacity(0.2),
          ),
        },
        onMapCreated: (GeoLatLong.GoogleMapController controller) {
          // Perform any additional map setup here
        },
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      );
    }

    return const Center(
      child: Text('No ride data available.'),
    );
  }

  GeoLatLong.LatLngBounds calculateBounds(List<GeoLatLong.LatLng> rideData) {
    double minLat = double.infinity;
    double maxLat = double.negativeInfinity;
    double minLng = double.infinity;
    double maxLng = double.negativeInfinity;

    for (final latLng in rideData) {
      minLat = latLng.latitude < minLat ? latLng.latitude : minLat;
      maxLat = latLng.latitude > maxLat ? latLng.latitude : maxLat;
      minLng = latLng.longitude < minLng ? latLng.longitude : minLng;
      maxLng = latLng.longitude > maxLng ? latLng.longitude : maxLng;
    }

    final southwest = GeoLatLong.LatLng(minLat, minLng);
    final northeast = GeoLatLong.LatLng(maxLat, maxLng);

    return GeoLatLong.LatLngBounds(northeast: northeast, southwest: southwest);
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/contact_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _mapController;
  final ContactService _contactService = ContactService();
  final LatLng _fallbackLocation = const LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Set<Marker>>(
      stream: _contactService.contactMarkers,
      builder: (context, snapshot) {
        final markers = snapshot.data ?? {};

        if (markers.isNotEmpty && _mapController != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _mapController.animateCamera(
              CameraUpdate.newLatLngBounds(
                _boundsFromMarkers(markers),
                50, // padding
              ),
            );
          });
        }

        return GoogleMap(
          onMapCreated: (controller) => _mapController = controller,
          initialCameraPosition: CameraPosition(
            target: _fallbackLocation,
            zoom: 2,
          ),
          markers: markers,
        );
      },
    );
  }

  LatLngBounds _boundsFromMarkers(Set<Marker> markers) {
    double? minLat, maxLat, minLng, maxLng;

    for (final marker in markers) {
      final lat = marker.position.latitude;
      final lng = marker.position.longitude;

      minLat = minLat == null ? lat : math.min(lat, minLat);
      maxLat = maxLat == null ? lat : math.max(lat, maxLat);
      minLng = minLng == null ? lng : math.min(lng, minLng);
      maxLng = maxLng == null ? lng : math.max(lng, maxLng);
    }

    return LatLngBounds(
      northeast: LatLng(maxLat ?? 0, maxLng ?? 0),
      southwest: LatLng(minLat ?? 0, minLng ?? 0),
    );
  }

}
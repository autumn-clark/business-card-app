import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _MapPageState();
  }
}

class _MapPageState extends StatefulWidget {
  const _MapPageState();

  @override
  State<_MapPageState> createState() => __MapPageStateState();
}

class __MapPageStateState extends State<_MapPageState> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pGooglePlex,
          zoom: 13,
        ),
      ),
    );
  }
}
//AIzaSyC25SOOL-FT83AtAfoER_js2EoVxOiTP78

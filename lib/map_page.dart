
  import 'package:flutter/material.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:geolocator/geolocator.dart'; // Import geolocator

  class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
  }

  class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  LatLng _currentLocation = const LatLng(47.92280592816315, 106.92075913913573);

  // Function to check and get current location
  Future<void> _getCurrentLocation() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
  // Handle service not enabled
  print('Location services are disabled');
  return;
  }

  // Request permission to access location
  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.deniedForever) {
  // Handle permanently denied permission
  print("Location permission denied forever");
  return;
  }

  // Get current position if permission is granted
  Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high,
  );

  setState(() {
  _currentLocation = LatLng(position.latitude, position.longitude);
  });

  mapController.animateCamera(
  CameraUpdate.newLatLng(_currentLocation),
  );
  }

  @override
  void initState() {
  super.initState();
  _getCurrentLocation(); // Fetch the current location when the page loads
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: GoogleMap(
  initialCameraPosition: CameraPosition(
  target: _currentLocation,
  zoom: 13,
  ),
  onMapCreated: (GoogleMapController controller) {
  mapController = controller;
  },
  myLocationEnabled: true, // Enable the current location dot
  myLocationButtonEnabled: true, // Enable the button to center on current location
  ),
  );
  }
  }

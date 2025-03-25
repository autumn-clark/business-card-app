import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Contact {
  final String userUid;
  final String cardUid;
  final LatLng location; // Using google_maps_flutter's LatLng
  final Timestamp time;

  Contact({
    required this.userUid,
    required this.cardUid,
    required this.location,
    required this.time,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'cardUid': cardUid,
      'location': GeoPoint(location.latitude, location.longitude),
      'time': time,
    };
  }

  // Create from Firestore Document
  factory Contact.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final geoPoint = data['location'] as GeoPoint;
    return Contact(
      userUid: data['userUid'],
      cardUid: data['cardUid'],
      location: LatLng(geoPoint.latitude, geoPoint.longitude), // Google Maps LatLng
      time: data['time'],
    );
  }

  // For distance calculations (optional)
  double distanceTo(LatLng other) {
    const double earthRadius = 6371000; // meters
    final double lat1 = location.latitude * math.pi / 180;
    final double lon1 = location.longitude * math.pi / 180;
    final double lat2 = other.latitude * math.pi / 180;
    final double lon2 = other.longitude * math.pi / 180;

    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) * math.cos(lat2) *
            math.sin(dLon / 2) * math.sin(dLon / 2);
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Contact {
  final String userUid;
  final String cardUid;
  final LatLng location;
  final Timestamp time;

  Contact({
    required this.userUid,
    required this.cardUid,
    required this.location,
    required this.time,
  });

  factory Contact.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final geoPoint = data['location'] as GeoPoint;

    return Contact(
      userUid: data['userUid'],
      cardUid: data['cardUid'],
      location: LatLng(geoPoint.latitude, geoPoint.longitude),
      time: data['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userUid': userUid,
      'cardUid': cardUid,
      'location': GeoPoint(location.latitude, location.longitude),
      'time': FieldValue.serverTimestamp(),
    };
  }
}
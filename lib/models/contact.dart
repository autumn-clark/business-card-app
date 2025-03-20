import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Contact {
  final String cardUid;
  final LatLng location;
  final Timestamp time;

  Contact({
    required this.cardUid,
    required this.location,
    required this.time,
  });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/contact.dart';
import 'package:flutter_application_1/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  // Automatically gets current user's contacts
  Stream<Set<Marker>> get contactMarkers {

    if (user != null) return Stream.value({});

    return _firestore
        .collection('contacts')
        .where('userUid', isEqualTo: user?.uid)
        .snapshots()
        .map(_convertToMarkers);
  }

  Set<Marker> _convertToMarkers(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final contact = Contact.fromFirestore(doc);
      return Marker(
        markerId: MarkerId(contact.cardUid),
        position: contact.location,
        infoWindow: InfoWindow(
          title: 'Met on ${_formatDate(contact.time)}',
          snippet: 'Card: ${contact.cardUid.substring(0, 8)}...',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRose,
        ),
      );
    }).toSet();
  }

  String _formatDate(Timestamp timestamp) {
    return DateFormat.yMMMd().format(timestamp.toDate());
  }
}
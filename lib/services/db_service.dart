import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/models/contact.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //---------------------Card-----------------//
  // To create a card
  Future<String?> createBusinessCard(BusinessCardModel card) async {
    User? user = _auth.currentUser;
    if (user != null) {
      Map<String, dynamic> cardData = {
        "userUid": user.uid,
        "email": card.email,
        "firstName": card.firstName,
        "lastName": card.lastName,
        "company": card.company,
        "occupation": card.occupation,
        "addresses": card.addresses,
        "tels": card.tels,
        "links": card.links,
        "seen": card.seen,
      };

      // Create a new document and get its reference
      DocumentReference docRef = await _db.collection("Card").add(cardData);

      // Return the newly created document ID
      return docRef.id;
    }
    return null; // Return null if user is not authenticated
  }

  // To update a card
  Future<void> updateBusinessCard(BusinessCardModel updatedCard) async {
    try {
      Map<String, dynamic> updatedData = {
        "email": updatedCard.email,
        "firstName": updatedCard.firstName,
        "lastName": updatedCard.lastName,
        "company": updatedCard.company,
        "occupation": updatedCard.occupation,
        "addresses": updatedCard.addresses,
        "tels": updatedCard.tels,
        "links": updatedCard.links,
        "seen": updatedCard.seen,
      };
      await _db.collection("Card").doc(updatedCard.uid).update(updatedData);
      print("Business card updated successfully!");
    } catch (e) {
      print("Error updating business card: $e");
    }
  }

  Future<void> deleteBusinessCard(String cardId) async {
    try {
      await _db.collection("Card").doc(cardId).delete();
      print("Business card deleted successfully!");
    } catch (e) {
      print("Error deleting business card: $e");
    }
  }


  // To get a card by its id
  Future<BusinessCardModel?> getBusinessCard(String cardId) async {
    try {
      DocumentSnapshot doc = await _db.collection("Card").doc(cardId).get();
      if (doc.exists) {
        var data = doc.data() as Map<String, dynamic>;
        return BusinessCardModel(
          uid: doc.id,
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          company: data['company'],
          occupation: data['occupation'],
          addresses: List<String>.from(data['addresses'] ?? []),
          tels: List<String>.from(data['tels'] ?? []),
          links: List<String>.from(data['links'] ?? []),
          seen: List<Timestamp>.from(data['seen'] ?? []),
        );
      } else {
        print("No business card found with ID: $cardId");
        return null;
      }
    } catch (e) {
      print("Error retrieving business card: $e");
      return null;
    }
  }

  // To get all cards of a user
  Future<List<BusinessCardModel>> getAllBusinessCards() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    try {
      QuerySnapshot snapshot = await _db
          .collection("Card")
          .where("userUid", isEqualTo: user.uid)
          .get();

      return snapshot.docs
          .map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return BusinessCardModel(
          uid: doc.id,
          email: data['email'],
          firstName: data['firstName'],
          lastName: data['lastName'],
          company: data['company'],
          occupation: data['occupation'],
          addresses: List<String>.from(data['addresses'] ?? []),
          tels: List<String>.from(data['tels'] ?? []),
          links: List<String>.from(data['links'] ?? []),
          seen: List<Timestamp>.from(data['seen'] ?? []),
        );
      })
          .toList();
    } catch (e) {
      print("Error retrieving business cards: $e");
      return [];
    }
  }
//-----------------------Contacts-------------------------//

  Future<void> saveContact({
    required String scannedCardUid,
    required String contactUid,
    required LatLng location,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    print("before adding");
    await _db.collection('contacts').add({
      'userUid': user.uid,
      'contactUid': contactUid,
      'cardUid': scannedCardUid,
      'location': GeoPoint(location.latitude, location.longitude),
      'time': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Contact>> getContacts() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _db.collection('contacts')
        .where('userUid', isEqualTo: user.uid)
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Contact.fromFirestore(doc))
        .toList());
  }

  Future<List<Contact>> getContactsByUser(String contactUid) async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _db.collection('contacts')
        .where('userUid', isEqualTo: user.uid)
        .where('contactUid', isEqualTo: contactUid)
        .get();

    return snapshot.docs.map(Contact.fromFirestore).toList();
  }
}


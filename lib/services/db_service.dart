import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/card.dart';

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
  Future<void> updateBusinessCard(String cardId, BusinessCardModel updatedCard) async {
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
      await _db.collection("Card").doc(cardId).update(updatedData);
      print("Business card updated successfully!");
    } catch (e) {
      print("Error updating business card: $e");
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
//---------------------User------------------//



  Future<void> createUserDocument(Map<String, dynamic> userData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      userData["uid"] = user.uid;
      userData["email"] = user.email;

      await _db.collection("User").doc(user.uid).set(userData);
    }
  }


  Future<Map<String, dynamic>?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection("User").doc(user.uid).get();
      return doc.data() as Map<String, dynamic>?;
    }
    return null;
  }

//-----------------------Contacts-------------------------//

//To create a contact
  Future<String?> createContact(Map<String, dynamic> contactData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      contactData["userUid"] = user.uid;

      // Create a new document and get its reference
      DocumentReference docRef = await _db.collection("Contacts").add(contactData);

      // Return the newly created document ID
      return docRef.id;
    }
    return null; // Return null if user is not authenticated
  }


//To delete a contact
  Future<void> deleteContact(String contactId) async {
    try {
      await _db.collection("Contacts").doc(contactId).delete();
    } catch (e) {
      print("Error deleting contacts: $e");
      throw e;
    }
  }
//To get a contact by its id
  Future<Map<String, dynamic>?> getContact(String contactId) async {
    try {
      DocumentSnapshot doc = await _db.collection("Contacts").doc(contactId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print("No contacts found with ID: $contactId");
        return null;
      }
    } catch (e) {
      print("Error retrieving contacts: $e");
      return null;
    }
  }
//To get all contact of a user
  Future<List<Map<String, dynamic>>> getAllContacts() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    try {
      QuerySnapshot snapshot = await _db
          .collection("Contacts")
          .where("userUid", isEqualTo: user.uid)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error retrieving contacts: $e");
      return [];
    }
  }

}

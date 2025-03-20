import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //---------------------Card-----------------//
//To create a card
  Future<String?> createBusinessCard(Map<String, dynamic> cardData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      cardData["userUid"] = user.uid;

      // Create a new document and get its reference
      DocumentReference docRef = await _db.collection("Card").add(cardData);

      // Return the newly created document ID
      return docRef.id;
    }
    return null; // Return null if user is not authenticated
  }

//To update a card
  Future<void> updateBusinessCard(String cardId, Map<String, dynamic> updatedData) async {
    try {
      await _db.collection("Card").doc(cardId).update(updatedData);
      print("Business card updated successfully!");
    } catch (e) {
      print("Error updating business card: $e");
    }
  }

//To delete a card
  Future<void> deleteBusinessCard(String cardId) async {
    try {
      await _db.collection("BusinessCards").doc(cardId).delete();
    } catch (e) {
      print("Error deleting business card: $e");
      throw e;
    }
  }
//To get a card by its id
  Future<Map<String, dynamic>?> getBusinessCard(String cardId) async {
    try {
      DocumentSnapshot doc = await _db.collection("Card").doc(cardId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print("No business card found with ID: $cardId");
        return null;
      }
    } catch (e) {
      print("Error retrieving business card: $e");
      return null;
    }
  }
//To get all cards of a user
  Future<List<Map<String, dynamic>>> getAllBusinessCards() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    try {
      QuerySnapshot snapshot = await _db
          .collection("Card")
          .where("userUid", isEqualTo: user.uid)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
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

//To create a card
  Future<String?> createContact(Map<String, dynamic> cardData) async {
    User? user = _auth.currentUser;
    if (user != null) {
      cardData["userUid"] = user.uid;

      // Create a new document and get its reference
      DocumentReference docRef = await _db.collection("Card").add(cardData);

      // Return the newly created document ID
      return docRef.id;
    }
    return null; // Return null if user is not authenticated
  }


//To delete a card
  Future<void> deleteContact(String cardId) async {
    try {
      await _db.collection("BusinessCards").doc(cardId).delete();
    } catch (e) {
      print("Error deleting business card: $e");
      throw e;
    }
  }
//To get a card by its id
  Future<Map<String, dynamic>?> getContact(String cardId) async {
    try {
      DocumentSnapshot doc = await _db.collection("Card").doc(cardId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print("No business card found with ID: $cardId");
        return null;
      }
    } catch (e) {
      print("Error retrieving business card: $e");
      return null;
    }
  }
//To get all cards of a user
  Future<List<Map<String, dynamic>>> getAllBusinessCards() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    try {
      QuerySnapshot snapshot = await _db
          .collection("Card")
          .where("userUid", isEqualTo: user.uid)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error retrieving business cards: $e");
      return [];
    }
  }

}

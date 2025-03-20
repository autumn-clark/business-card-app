import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createBusinessCard(String firstName, String lastName, List<String> tel, List<String> socialLinks, List<String> addresses) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _db.collection("Card").doc(user.uid).set({
        "uid": user.uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": user.email,
        "tel": tel,
        "company": '',
        "occupation" : '',
        "social links": socialLinks,
        "addresses" : addresses,
      });
    }
  }

  Future<void> createUserDocument(String firstName, String lastName) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _db.collection("User").doc(user.uid).set({
        "uid": user.uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": user.email,
      });
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

}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveUserInfo(String name, String phone, String email) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'qrCode': '',
      'businessCard': {
        'company': '',
        'jobTitle': '',
        'website': '',
        'socialLinks': {}
      }
    }, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data();
  }
}

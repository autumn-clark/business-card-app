import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmail(String email, String password) async {
    print("Sign in With Email");
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      print('User signed in: ${userCredential.user?.email}');
    } catch (e) {
        print('Sign-in error: ${e.toString()}');
      }
    }


  Future<void> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      print('User registered: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      print('Registration error: ${e.message}');
    }
  }


  // **Anonymous Sign-in**
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      print("Anonymous sign-in error: $e");
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool isUserSignedIn() {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}


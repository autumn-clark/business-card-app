import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/auth.dart'; // Import your auth methods

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Нэвтрэх"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "И-мейл",
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Нууц үг",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await auth.signInWithEmail(
                    _emailController.text,
                    _passwordController.text,
                  );
                  // Navigate to Home after successful sign-in
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                        (route) => false,
                  );
                } catch (e) {}
                //   print("Sign-in error: $e");
                //   // Show error message if needed
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //         content: Text("Failed to sign in. Check credentials.")),
                //   );
                // }
              },
              child: Text("Нэвтрэх"),
            ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: (){},
                  child: Text("Register instead"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

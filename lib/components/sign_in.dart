import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/services/auth.dart'; // Import your auth methods

class SignIn extends StatefulWidget {
  const SignIn({super.key});

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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                        (route) => false,
                  );
                } catch (e) {
                   print("Sign-in error: $e");
                   ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                         content: Text("Нэвтрэхэд алдаа гарлаа")),
                   );
                 }
              },
              child: Text("Нэвтрэх"),
            ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: (){},
                  child: Text("Бүртгүүлэх үү?"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

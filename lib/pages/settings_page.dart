import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/sign_in.dart';
import 'package:flutter_application_1/home.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;

  Widget _buildSettingItem(IconData icon, String title, {Widget? trailing}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          leading: Icon(icon, color: Colors.teal),
          title: Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          trailing: trailing,
          onTap: () async {
            if (title == 'Гарах') {
              await FirebaseAuth.instance.signOut(); // Sign out the user
              // Navigate to the sign-in screen after logging out
              //         Navigator.pushAndRemoveUntil(
              //           context,
              //           MaterialPageRoute(builder: (context) => AuthWrapper()),
              //               (route) => false,  // This will remove all the previous routes
              //         );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            // User Info Section
            FutureBuilder<User?>(
              future: FirebaseAuth.instance
                  .authStateChanges()
                  .first, // Listen once to the auth state
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator while checking auth state
                }

                if (snapshot.hasData) {
                  // If user is signed in, display the Sign Out button
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(radius: 30, backgroundColor: Colors.grey[300]),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ариунаа',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500)),
                              Text('Таны профайл'),
                            ],
                          ),
                          Spacer(),
                          ElevatedButton(onPressed: () {}, child: Text('Засах')),
                        ],
                      ),
                    ),
                  );
                } else {
                  // If user is not signed in, show Sign In button or other UI
                  return ElevatedButton(
                    onPressed: () {Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                          (route) => false,  // This will remove all the previous routes
                        );
                      },
                    child: Text("Нэвтрэх"),
                  );
                }
              },
            ),

            SizedBox(height: 16),

            // Settings Options
            _buildSettingItem(
              Icons.notifications,
              'Мэдэгдэл',
              trailing: Switch(
                value: _notifications,
                onChanged: (bool value) {
                  setState(() {
                    _notifications = value;
                  });
                },
              ),
            ),

            _buildSettingItem(
              Icons.dark_mode,
              'Харанхуй горим',
              trailing: Switch(
                value: _darkMode,
                onChanged: (bool value) {
                  setState(() {
                    _darkMode = value;
                  });
                },
              ),
            ),

            _buildSettingItem(Icons.lock, 'Нууцлал'),
            _buildSettingItem(Icons.language, 'Хэл'),
            _buildSettingItem(Icons.info, 'Тухай'),
            FutureBuilder<User?>(
              future: FirebaseAuth.instance
                  .authStateChanges()
                  .first, // Listen once to the auth state
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading indicator while checking auth state
                }

                if (snapshot.hasData) {
                  // If user is signed in, display the Sign Out button
                  return ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                            (route) => false,  // This will remove all the previous routes
                      );
                    },
                    child: Text("Гарах"),
                  );
                } else {
                  // If user is not signed in, show Sign In button or other UI
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

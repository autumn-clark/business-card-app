import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/components/recent_contacts.dart';
import 'package:flutter_application_1/services/user_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  final userService = UserService();
  fetchUser () async {
    if(user != null ) {
      print(user);
      userService.createUserDocument("Ариунаа", "Баярмагнай");

    }
    var userData = await userService.getUserData();
    print(userData);
    if (userData != null) {
      print("User Name: $userData");
    } else {
      print("User not found");
    }
    if (userData != null) {
      print("User Name: ${userData['name']}");
    } else {
      print("User not found");
    }
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: user != null
            ? [
                // If user is signed in, show these widgets
                BusinessCard(),
                Container(
                  height: 200,
                  width: 390,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MapPage(),
                  ),
                ),
                RecentContacts(),
          ElevatedButton(onPressed: fetchUser, child: Text("get")),
              ]
            : [
                EmptyCard(),
              ],
        
      ),
    );
  }
}

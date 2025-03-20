import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/components/recent_contacts.dart';
import 'package:flutter_application_1/services/db_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  User? user = FirebaseAuth.instance.currentUser;
  final dbService = DBService();
  List<BusinessCardModel> businessCards = [];

  fetchUser() async {
    if (user != null) {
      print(user);
      // await dbService.createUserDocument({
      //   "firstName": "John",
      //   "lastName": "Doe",
      //   "email": "doe.john@info.com",
      // });

      // userService.createUserDocument("Ариунаа", "Баярмагнай");

    }
    var userData = await dbService.getUserData();
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

  createCard() async {
    final dbService = DBService();
    print("oncreatecard");
    if (user != null) {
      // String? cardId = await dbService.createBusinessCard({
      //   "firstName": "John",
      //   "lastName": "Doe",
      //   "email": "john.doe@info.com",
      //   "tel": "8888",
      //   "company": 'aaaa',
      //   "occupation": 'slob',
      //   "social links": "baaa",
      //   "addresses": ["aaa"],
      // });
      // print(cardId);
      //
      //
      // if (cardId != null) {
      //   await dbService.updateBusinessCard(cardId, {
      //     "firstName": "Ari",
      //     "lastName": "Buya",
      //     "email": "ari.doe@info.com",
      //     "tel": "8888",
      //     "company": "aaaa",
      //     "occupation": "slob",
      //     "social links": ["a", "b"],
      //     "addresses": ["aaa"],
      //   });
      // }
    }
  }

  Future<bool> checkIfUserHasACard() async {
    try {
      // Fetch the list of business cards
      businessCards = await dbService
          .getAllBusinessCards();

      // Check if the list is empty
      return businessCards.isNotEmpty;
    } catch (e) {
      print("Error retrieving business cards: $e");
      return false; // Return false if there was an error
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkIfUserHasACard(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data == true) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: user != null
                  ? [
                ElevatedButton(
                  onPressed: createCard,
                  child: Text("johndoe"),
                ),
                BusinessCard(cardData: businessCards[0]),
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
        } else {
          // If there's no data (card not found), return an alternative widget
          return Column(
            children: [
              EmptyCard(),
            ],
          );
        }
      },
    );
  }
}


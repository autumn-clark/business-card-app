import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/services/db_service.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BusinessCard extends StatelessWidget {
  final BusinessCardModel cardData;

  const BusinessCard({Key? key, required this.cardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: screenWidth - 50,
          child: Card(
            elevation: 8,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            //logo or avatar
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            color: Colors.black26,
                            height: 80,
                            width: 80,
                          ),
                          Expanded(
                            //main info and social links
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(cardData.firstName ?? 'Unknown'),
                                      Text(cardData.occupation ?? 'Unknown'),
                                      Text(cardData.company ?? 'Unknown'),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      Text('Fb '), // Replace with social links data
                                      Text('IG '),
                                      Text('Ln '),
                                      Text('Yt'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        //contact information
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cardData.email ?? 'No email'),
                              Text(cardData.tels?.join(", ") ?? 'No phone'),
                              // Add other contact details here if available
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/cloud.svg',
                    width: 150,
                    height: 225,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 25,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EmptyCard extends StatelessWidget {
  EmptyCard({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  createCard() {
    final dbService = DBService();
    if(user != null){
      // dbService.createBusinessCard({
      //   "firstName": "John",
      //   "lastName": "Doe",
      //   "email": "john.doe@info.com",
      //   "tel": "8888",
      //   "company": 'John',
      //   "occupation": 'slob',
      //   "social links": ["a", "b", "c"],
      //   "addresses": ["aaa"],
      // });
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: createCard,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 3,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 200, // Adjust height as needed
            width: double.infinity, // Takes full width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[500], // Light grey background
            ),
            child: Center(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueAccent, // Button color
                child: Icon(Icons.add, size: 40, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

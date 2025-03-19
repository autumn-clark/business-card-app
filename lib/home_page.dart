import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_card.dart';
import 'package:flutter_application_1/map_page.dart';
import 'package:flutter_application_1/map_spinnet.dart';
import 'package:flutter_application_1/recent_contacts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BusinessCard(),
            Container(
              height: 200,
              width: 390,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      blurRadius: 10, // Softness of the shadow
                      spreadRadius: 2, // Shadow size
                      offset: Offset(0, 4), // Vertical shadow position
                    ),
                  ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Ensures clipping
                child: MapPage(), // Ensures content follows rounded corners
              ),
            ),
            RecentContacts()],
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_application_1/business_card.dart';
import 'package:flutter_application_1/map_spinnet.dart';
import 'package:flutter_application_1/recent_connects.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [BusinessCard(), MapSpinnet(), RecentConnects()],
        ),
      ),
    );
  }
}



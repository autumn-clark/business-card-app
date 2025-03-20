import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/components/recent_contacts.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/services/db_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final dbService = DBService();

  List<BusinessCardModel> businessCardData = [];
  List<Widget> businessCardWidgets = [];

  int currentPage = 0;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    loadUserCards();
  }

  Future<void> loadUserCards() async {
    try {
      var cards = await dbService.getAllBusinessCards();
      setState(() {
        businessCardData = cards;
        businessCardWidgets = cards.map((card) => BusinessCard(cardData: card)).toList();
        businessCardWidgets.add(EmptyCard());
        print(businessCardWidgets.length);
        isLoading = false;
      });
    } catch (e) {
      print("Error retrieving business cards: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: user != null
          ? [
        Column(
          children: [
            CarouselSlider(
              items: [...businessCardWidgets, EmptyCard()],
              options: CarouselOptions(
                initialPage: 0,
                autoPlay: false,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                enableInfiniteScroll: true,
                onPageChanged: (value, _) {
                  setState(() {
                    currentPage = value;
                  });
                },
              ),
            ),
            buildCarouselIndicator()
          ],
        ),
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
      ]
          : [EmptyCard()],
    ),
    );
  }

  Widget buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(businessCardData.length+1, (i) {
        return Container(
          margin: const EdgeInsets.all(5),
          height: i == currentPage ? 7 : 5,
          width: i == currentPage ? 7 : 5,
          decoration: BoxDecoration(
            color: i == currentPage ? Colors.black : Colors.black26,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}


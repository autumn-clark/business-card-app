import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/components/business_card_carousel.dart';
import 'package:flutter_application_1/components/recent_contacts.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/pages/map_page.dart';
import 'package:flutter_application_1/providers/business_card_provider.dart';
import 'package:flutter_application_1/services/db_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  final dbService = DBService();

  List<BusinessCardModel> businessCardData = [];
  bool isLoading = true;

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
        isLoading = false;
      });
    } catch (e) {
      print("Алдаа гарлаа: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessCardProvider>(context);

    if (provider.isLoading || isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: user != null
                ? [
              Column(
                children: provider.cards.isNotEmpty
                    ? [
                  BusinessCardCarousel(
                    cards: provider.cards,
                    onCardUpdated: () => provider.loadCards(),
                  ),
                ]
                    : [
                  EmptyCard(
                    onCardAdded: () => provider.loadCards(),
                  ),
                ],
              ),
              // Map
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
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MapPage(),
                ),
              ),
              // Recent Contacts
              RecentContacts(),
            ]
                : [
              EmptyCard(
                onCardAdded: () => provider.loadCards(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

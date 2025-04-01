import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/services/db_service.dart';

class RecentContacts extends StatefulWidget {
  const RecentContacts({super.key});

  @override
  State<RecentContacts> createState() => _RecentContactsState();
}

class _RecentContactsState extends State<RecentContacts> {
  final DBService dbService = DBService();
  List<BusinessCardModel> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  Future<void> loadCards() async {
    final fetchedCards = await dbService.getCardsFromContacts();
    setState(() {
      cards = fetchedCards;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Сүүлд танилцсан",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              if (cards.isEmpty)
                const Text("Холбоо барьсан хүн алга.")
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cards.map((card) {
                      String name = card.lastName ?? card.firstName ??
                          card.company ?? "Нэр байхгүй";
                      return GestureDetector(
                        onTap: () => _showBusinessCard(context, card),
                        child: _buildContactCard(name),
                      );
                    }).toList(),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 16,
          ),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showBusinessCard(BuildContext context, BusinessCardModel card) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: BusinessCard(
            cardData: card,
            onCardUpdated: () {
              setState(() {
                print("Card updated!");
              });
            },
          ),
        );
      },
    );
  }
}

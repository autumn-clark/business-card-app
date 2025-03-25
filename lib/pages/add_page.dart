import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/providers/business_card_provider.dart';
import 'package:flutter_application_1/services/db_service.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_application_1/pages/qr_scanner_page.dart';
import 'package:flutter_application_1/components/share_your_card_bottom_sheet.dart';

class AddPage extends StatefulWidget {


  AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final dbService = DBService();
  late List<String> sharedCards;

  String scannedCardId = '';

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser; // Get current user

    final provider = Provider.of<BusinessCardProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Not logged in")),
      );
    }

    String userId = user.uid; // Now safe to access uid

    return Scaffold(
      appBar: AppBar(title: Text('Generated QR Code')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QrImageView(
            //   data: '$userId',
            //   version: QrVersions.auto,
            //   size: 200.0,
            // ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.qr_code_scanner, size: 50, color: Colors.blue),
              onPressed: () async {
                // Navigate to QRScannerPage and wait for the result
                scannedCardId = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerPage()),
                );

                // Show the ShareCardBottomSheet after scanning
                if (scannedCardId != null && scannedCardId.isNotEmpty) {
                  _showShareDialog(context, scannedCardId);
                }
              },
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...provider.cards.map((card) => BusinessCard(
                    cardData: card,
                    onCardUpdated: () => provider.loadCards(),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showShareDialog(BuildContext context, String scannedCardId) async {
    final myCards = await DBService().getAllBusinessCards(); // Get Ari's cards

    List<bool> selectedCards = List.filled(myCards.length, false);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Share your card?"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: myCards.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(myCards[index].firstName ?? 'Unnamed Card'),
                subtitle: Text(myCards[index].company ?? ''),
                value: selectedCards[index],
                onChanged: (value) {
                  setState(() {
                    selectedCards[index] = value!;
                  });
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Get indices of selected cards
              final selectedIndices = selectedCards
                  .asMap()
                  .entries
                  .where((entry) => entry.value)
                  .map((entry) => entry.key)
                  .toList();

              // Share the selected cards
              _shareCards(scannedCardId, selectedIndices.map((i) => myCards[i]).toList());
              Navigator.pop(context);
            },
            child: const Text("Share"),
          ),
        ],
      ),
    );
  }

  Future<void> _shareCards(String recipientCardId, List<BusinessCardModel> cardsToShare) async {
    // Implement your sharing logic here
    // This might involve:
    // 1. Saving to "shared_cards" collection in Firestore
    // 2. Sending a notification to Buya
    // 3. Updating local state

    // for (final card in cardsToShare) {
    //   await DBService().shareCard(
    //     senderCardId: card.uid!,
    //     recipientCardId: recipientCardId,
    //   );
    // }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shared ${cardsToShare.length} card(s)')),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/business_card.dart';
import 'package:flutter_application_1/providers/business_card_provider.dart';
import 'package:flutter_application_1/services/db_service.dart';
import 'package:flutter_application_1/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/qr_scanner_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final dbService = DBService();
  late List<String> sharedCards;

  String scannedCardId = '';

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

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

    String userId = user.uid;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              
              icon: Icon(Icons.qr_code_scanner, size: 100, color: Colors.blue),
              onPressed: () async {
                scannedCardId = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerPage()),
                );

                if (scannedCardId.isNotEmpty) {
                  _showShareDialog(context, scannedCardId);
                }
              },
            ),
            Center(
              child: Text('QR уншуулах'),
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleScannedQR(String scannedData, String latlong) async {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    await DBService().saveContact(
      scannedCardUid: scannedData,
      location: LatLng(47.90928770042334, 106.90664904302045),
      userUid: userUid
    );
  }

  Future<String> getLocation() async {
    Position? position = await LocationService.getCurrentLocation();
    if (position != null) {
      return '${position.latitude}-${position.longitude}';
    } else {
      print("Could not get location");
      return '';
    }
  }

  void _showShareDialog(BuildContext context, String scannedCardId) async {
    handleScannedQR(scannedCardId, await getLocation());
    final myCards = await dbService.getAllBusinessCards();

    int? selectedCardIndex;

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
              return RadioListTile<int>(
                title: Text(myCards[index].firstName ?? 'Unnamed Card'),
                subtitle: Text(myCards[index].company ?? ''),
                value: index,
                groupValue: selectedCardIndex,
                onChanged: (int? value) {
                  setState(() {
                    selectedCardIndex = value;
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
              if (selectedCardIndex != null) {
                // Share the selected card
                final selectedCard = myCards[selectedCardIndex!];
                _shareCards(selectedCard.uid ?? '', scannedCardId);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please select a card to share.')),
                );
              }
            },
            child: const Text("Share"),
          ),
        ],
      ),
    );
  }

  Future<void> _shareCards(String cardId, String contactingUserId) async {
    dbService.shareCard(cardId, contactingUserId);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shared ${cardId} card')),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_application_1/pages/qr_scanner_page.dart';
import 'package:flutter_application_1/components/share_your_card_bottom_sheet.dart';

class AddPage extends StatelessWidget {
  String scannedUserId = '';
  AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser; // Get current user

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Not logged in")),
      );
    }

    String userId = user.uid; // Now safe to access uid
    return Scaffold(
      appBar: AppBar(title: Text('Generated QR Code')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: userId,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            IconButton(
              icon: Icon(Icons.qr_code_scanner, size: 50, color: Colors.blue),
              onPressed: () async {
                // Navigate to QRScannerPage and wait for the result
                scannedUserId = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerPage()),
                );

                // Show the ShareCardBottomSheet after scanning
                if (scannedUserId != null && scannedUserId.isNotEmpty) {
                  _showShareCardBottomSheet(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showShareCardBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the sheet to take up more space
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return ShareCardBottomSheet(
          items: ["Email", "WhatsApp", "Instagram", "Facebook"],
          onNoPressed: () {
            Navigator.pop(context); // Close the bottom sheet
            print("No button pressed");
          },
        );
      },
    );
  }
}
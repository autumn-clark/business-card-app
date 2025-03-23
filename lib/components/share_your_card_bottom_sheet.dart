import 'package:flutter/material.dart';

class ShareCardBottomSheet extends StatelessWidget {
  final List<String> items;
  final VoidCallback onNoPressed;

  const ShareCardBottomSheet({
    super.key,
    required this.items,
    required this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Share your card",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // List of items as buttons
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle item button press
                    print("Selected: $item");
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(double.infinity, 50.0), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(item),
                ),
              );
            }).toList(),
            SizedBox(height: 16.0),
            // No button
            ElevatedButton(
              onPressed: onNoPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.0), // Full-width button
                backgroundColor: Colors.grey[300], // Light gray background
                foregroundColor: Colors.black, // Black text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text("No"),
            ),
          ],
        ));
  }
}

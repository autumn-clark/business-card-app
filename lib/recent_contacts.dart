import 'package:flutter/material.dart';

class RecentContacts extends StatelessWidget {
  final List<String> names = ["Ариунаа", "Ариунаа", "Ариунаа"]; // Example names

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners
      ),
      elevation: 3,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Сүүлд танилцсан",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: names.map((name) => _buildContactCard(name)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(String name) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300], // Placeholder for image
            radius: 16,
          ),
          SizedBox(width: 10),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

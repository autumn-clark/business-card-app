import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/services/db_service.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final DBService dbService = DBService();
  List<BusinessCardModel> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  Future<void> loadContacts() async {
    final fetchedContacts = await dbService.getCardsFromContacts();
    setState(() {
      contacts = fetchedContacts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (contacts.isEmpty)
              const Center(child: Text("Танд холбогдсон харилцагч байхгүй байна."))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return _buildContactTile(contacts[index]);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(BusinessCardModel card) {
    return GestureDetector(
      onTap: () => _showBusinessCard(context, card),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[300],
            radius: 24,
          ),
          title: Text(
            card.firstName ?? 'Unknown',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(card.company ?? 'No company'),
        ),
      ),
    );
  }

  void _showBusinessCard(BuildContext context, BusinessCardModel card) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Нэр: ${card.firstName} ${card.lastName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Цахим шуудан: ${card.email}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text('Байгууллага: ${card.company}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text('Албан тушаал: ${card.occupation}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    print("Нэрийн хуудсыг устгалаа!");
                  });
                },
                child: Text('Устгах'),
              ),
            ],
          ),
        );
      },
    );
  }
}

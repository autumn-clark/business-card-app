import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/services/db_service.dart';

class CardFormPage extends StatefulWidget {
  final BusinessCardModel? cardData;
  final dbService = DBService();

  CardFormPage({this.cardData});

  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController companyController;
  late TextEditingController occupationController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing data if editing
    emailController = TextEditingController(
        text: widget.cardData != null ? widget.cardData!.email : '');
    firstNameController = TextEditingController(
        text: widget.cardData != null ? widget.cardData!.firstName : '');
    lastNameController = TextEditingController(
        text: widget.cardData != null ? widget.cardData!.lastName : '');
    companyController = TextEditingController(
        text: widget.cardData != null ? widget.cardData!.company : '');
    occupationController = TextEditingController(
        text: widget.cardData != null ? widget.cardData!.occupation : '');
    phoneController = TextEditingController(
      text: widget.cardData != null ? widget.cardData!.tels?.join(", ") : '', // Assuming `tels` is a List<String>
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    companyController.dispose();
    occupationController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cardData != null ? 'Edit Card' : 'Add Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: companyController,
              decoration: InputDecoration(labelText: 'Company'),
            ),
            TextField(
              controller: occupationController,
              decoration: InputDecoration(labelText: 'Occupation'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Create or update the business card
                BusinessCardModel newCard = BusinessCardModel(
                  uid: widget.cardData?.uid ?? FirebaseAuth.instance.currentUser?.uid,
                  email: emailController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  company: companyController.text,
                  occupation: occupationController.text,
                  tels: phoneController.text.split(", "), // Assuming `tels` is a List<String>
                );

                if (widget.cardData != null) {
                  // Update the existing card
                  await widget.dbService.updateBusinessCard(newCard);
                } else {
                  // Create a new card
                  await widget.dbService.createBusinessCard(newCard);
                }

                Navigator.pop(context, true);
              },
              child: Text('Save'),
            ),
            if (widget.cardData != null)
              ElevatedButton(
                onPressed: () async {
                  await widget.dbService.deleteBusinessCard(widget.cardData!.uid!);
                  Navigator.pop(context, true);
                },
                child: Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

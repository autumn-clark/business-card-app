import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/services/db_service.dart';

class CardFormPage extends StatefulWidget {
  final BusinessCardModel? cardData;
  final dbService = DBService();

  CardFormPage({super.key, this.cardData});

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
              decoration: InputDecoration(labelText: 'Нэр'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Овог'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Цахим шуудан'),
            ),
            TextField(
              controller: companyController,
              decoration: InputDecoration(labelText: 'Байгууллага'),
            ),
            TextField(
              controller: occupationController,
              decoration: InputDecoration(labelText: 'Албан тушаал'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Утас'),
            ),
            ElevatedButton(
              onPressed: () async {
                BusinessCardModel newCard = BusinessCardModel(
                  uid: widget.cardData?.uid ?? FirebaseAuth.instance.currentUser?.uid,
                  email: emailController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  company: companyController.text,
                  occupation: occupationController.text,
                  tels: phoneController.text.split(", "),
                  userUid: ''
                );

                if (widget.cardData != null) {
                  await widget.dbService.updateBusinessCard(newCard);
                } else {
                  await widget.dbService.createBusinessCard(newCard);
                }

                Navigator.pop(context, true);
              },
              child: Text('Хадгалах'),
            ),
            if (widget.cardData != null)
              ElevatedButton(
                onPressed: () async {
                  await widget.dbService.deleteBusinessCard(widget.cardData!.uid!);
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Устгах'),
              ),
          ],
        ),
      ),
    );
  }
}

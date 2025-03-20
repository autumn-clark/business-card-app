import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessCardModel {
  final String? uid;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? occupation;
  final List<String>? addresses;
  final List<String>? tels;
  final List<String>? links;
  final List<Timestamp>? seen;

  // Constructor with optional parameters
  BusinessCardModel({
    this.uid,
    this.email,
    this.firstName,
    this.lastName,
    this.company,
    this.occupation,
    this.addresses,
    this.tels,
    this.links,
    this.seen,
  });

  @override
  String toString() {
    return 'BusinessCardModel{uid: $uid, email: $email, firstName: $firstName, lastName: $lastName, company: $company, occupation: $occupation, addresses: $addresses, tels: $tels, links: $links, seen: $seen}';
  }
}

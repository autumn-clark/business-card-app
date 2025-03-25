import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/card.dart';
import 'package:flutter_application_1/services/db_service.dart';

class BusinessCardProvider extends ChangeNotifier {
  final DBService _dbService = DBService();
  List<BusinessCardModel> _cards = [];
  bool _isLoading = false;
  String? _error;

  List<BusinessCardModel> get cards => _cards;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCards() async {
    try {
      _isLoading = true;
      notifyListeners();

      _cards = await _dbService.getAllBusinessCards();
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading cards: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCards() async {
    await loadCards();
  }
}
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = [];
  bool _isLoading = false;
  String _error = '';

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> search(String query) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _books = await BookService.searchBooks(query);
    } catch (e) {
      _error = e.toString();
      _books = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _books = [];
    _error = '';
    notifyListeners();
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class BookService {
  static Future<List<Book>> searchBooks(String query) async {
    try {
      final response = await http.get(Uri.parse('https://openlibrary.org/search.json?q=$query'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> docs = data['docs'];
        return docs.map((json) => Book.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar livros');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
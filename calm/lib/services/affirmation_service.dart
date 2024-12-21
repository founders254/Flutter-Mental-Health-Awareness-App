import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  final String _apiUrl = 'https://api.quotable.io/random';

  Future<Map<String, String>> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'content': data['content'],
          'author': data['author'],
        };
      } else {
        throw Exception('Failed to load quote. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quote: $e');
    }
  }
}

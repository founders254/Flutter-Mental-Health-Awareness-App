import 'dart:convert';
import 'package:http/http.dart' as http;

class DistressService {
  final String _baseUrl = 'https://emergencynumberapi.com/api/data/all'; // Replace with the actual API URL

  Future<Map<String, String>> fetchEmergencyNumbers() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data.map((key, value) => MapEntry(key, value.toString()));
    } else {
      throw Exception('Failed to fetch emergency numbers');
    }
  }
}

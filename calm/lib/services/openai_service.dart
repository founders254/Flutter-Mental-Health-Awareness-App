import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String apiKey = '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'; // Replace with your API key
  final String apiUrl = 'https://api.openai.com/v1/completions';

  Future<String> getAIResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': prompt,
        'max_tokens': 150,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['text'].trim();
    } else {
      throw Exception('Failed to fetch AI response');
    }
  }
}

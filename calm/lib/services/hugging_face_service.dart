import 'dart:convert';
import 'package:http/http.dart' as http;

class HuggingFaceService {
  final String apiKey = "YOUR_API_KEY_HERE";
  final String modelName = "microsoft/DialoGPT-medium"; // Replace with your chosen model.

  Future<String> getChatbotResponse(String userInput) async {
    final url = Uri.parse("https://api-inference.huggingface.co/models/$modelName");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "inputs": userInput,
        "options": {"wait_for_model": true}
      }),
    );

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse.containsKey("generated_text")) {
        return decodedResponse["generated_text"];
      } else {
        return "I'm sorry, I couldn't process your request.";
      }
    } else {
      return "Error: ${response.statusCode} - ${response.reasonPhrase}";
    }
  }
}

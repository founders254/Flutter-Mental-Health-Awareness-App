import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey = 'sk-svcacct-dQmz0Lr3frYdg9gDcldhgAG8TCT0ZU-7BtC29BGeP2iOp-67CNayG-PFDpFv5hnEXT3BlbkFJL9Yf9l8km6UpOSZ4N8pV_Ul3G7XLHdc2UurLNjg2xkBOQ1fcV5HgHy_Mv10ejZargA'; 
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getChatbotResponse(String userMessage) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: json.encode({
          "model": "gpt-3.5-turbo", 
          "messages": [
            {"role": "system", "content": "You are a helpful mental health assistant."},
            {"role": "user", "content": userMessage},
          ],
          "max_tokens": 150,
          "temperature": 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chatbotMessage = data['choices'][0]['message']['content'];
        return chatbotMessage.trim();
      } else {
        return 'Error: ${response.statusCode}, ${response.body}';
      }
    } catch (e) {
      return 'Error: Unable to fetch response. $e';
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIChatScreen extends StatefulWidget {
  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final List<types.Message> _messages = [];
  final types.User _user = types.User(id: 'user');
  final types.User _ai = types.User(id: 'ai');
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addSystemMessage("Hi there! How are you feeling today?");
  }

  void _addSystemMessage(String text) {
    final message = types.TextMessage(
      author: _ai,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
    });
  }

  void _sendMessage(String text) async {
    final message = types.TextMessage(
      author: _user,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
    );

    setState(() {
      _messages.insert(0, message);
      _textController.clear();
    });

    _fetchResponse(text);
  }

  Future<void> _fetchResponse(String userMessage) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions"); // Replace with your AI API
    const apiKey = "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";

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a mental health support assistant."},
          {"role": "user", "content": userMessage},
        ],
        "max_tokens": 100,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final aiResponse = data['choices'][0]['message']['content'];

      _addSystemMessage(aiResponse);
    } else {
      _addSystemMessage("Oops! Something went wrong. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mental Health AI"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: (types.PartialText message) {
                _sendMessage(message.text);
              },
              user: _user,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              onSubmitted: _sendMessage,
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textController.text.trim());
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    const String apiKey = "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"; // Replace with your API key.
    const String apiUrl = "https://api-inference.huggingface.co/models/facebook/blenderbot-400M-distill";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "inputs": userMessage,
          "options": {"wait_for_model": true},
        }),
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey("generated_text")) {
          final aiResponse = data["generated_text"];
          _addSystemMessage(aiResponse);
        } else {
          _addSystemMessage("I'm sorry, I couldn't process your request.");
        }
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData["error"] ?? "Unknown error.";
        _addSystemMessage("Error: $errorMessage");
      }
    } catch (e) {
      print("Error: $e");
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
              onSubmitted: (text) {
                if (text.trim().isNotEmpty) _sendMessage(text.trim());
              },
              decoration: InputDecoration(
                hintText: "Type your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.trim().isNotEmpty) {
                      _sendMessage(_textController.text.trim());
                    }
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

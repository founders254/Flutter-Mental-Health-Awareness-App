import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:calm/services/openai_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final OpenAIService openAIService = OpenAIService();
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> messages = [];

  // Encryption key and initialization vector
  final key = encrypt.Key.fromLength(32); // AES requires a 32-byte key
  final iv = encrypt.IV.fromLength(16); // AES requires a 16-byte IV
  late final encrypt.Encrypter encrypter;

  @override
  void initState() {
    super.initState();
    encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  // Encrypt a message
  String _encryptMessage(String message) {
    final encrypted = encrypter.encrypt(message, iv: iv);
    return encrypted.base64; // Store as Base64 string
  }

  // Decrypt a message
  String _decryptMessage(String encryptedMessage) {
    final decrypted = encrypter.decrypt64(encryptedMessage, iv: iv);
    return decrypted;
  }

  void _sendMessage() async {
    final userMessage = _messageController.text;
    if (userMessage.isEmpty) return;

    // Encrypt the user's message
    final encryptedMessage = _encryptMessage(userMessage);

    setState(() {
      messages.add({"role": "user", "content": encryptedMessage});
    });

    _messageController.clear();

    // Get response from OpenAI service
    final response = await openAIService.getChatbotResponse(userMessage);

    // Encrypt the assistant's response
    final encryptedResponse = _encryptMessage(response);

    setState(() {
      messages.add({"role": "assistant", "content": encryptedResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mental Health Assistant")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                // Decrypt message for display
                final decryptedMessage =
                    _decryptMessage(message['content'] ?? "");

                return Align(
                  alignment: message['role'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message['role'] == 'user'
                          ? Colors.blue[100]
                          : Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(decryptedMessage),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Type your message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

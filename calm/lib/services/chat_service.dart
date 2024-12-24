import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Send a message
  Future<void> sendMessage(String userId, String message) async {
    await _firestore.collection('messages').add({
      'senderId': userId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get messages
  Stream<QuerySnapshot> getMessages() {
    return _firestore
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}

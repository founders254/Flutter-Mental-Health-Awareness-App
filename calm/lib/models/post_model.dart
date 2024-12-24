import 'package:cloud_firestore/cloud_firestore.dart';
 
class Post {
  final String id;
  final String content;
  final String authorId;
  final int likes;
  final DateTime timestamp;

  Post({
    required this.id,
    required this.content,
    required this.authorId,
    this.likes = 0,
    required this.timestamp,
  });

  factory Post.fromMap(Map<String, dynamic> data, String id) {
    return Post(
      id: id,
      content: data['content'],
      authorId: data['authorId'],
      likes: data['likes'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'authorId': authorId,
      'likes': likes,
      'timestamp': timestamp,
    };
  }
}

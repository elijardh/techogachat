import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String content;
  final String type;
  final DateTime createdAt;
  final String senderId;

  ChatMessage({
    required this.content,
    required this.createdAt,
    required this.senderId,
    required this.type,
  });

  factory ChatMessage.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return ChatMessage(
      content: json['content'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
      senderId: json['sender_id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content,
        'created_at': createdAt.millisecondsSinceEpoch,
        'sender_id': senderId,
        'type': type,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String roomId;
  final List<String> participants;
  final String lastMessage;

  ChatRoom({
    required this.lastMessage,
    required this.participants,
    required this.roomId,
  });

  factory ChatRoom.fromJson(QueryDocumentSnapshot json) {
    return ChatRoom(
        lastMessage: json['lastMessage'],
        participants: json['participants'].cast<String>(),
        roomId: json['room_id']);
  }

  Map<String, dynamic> toJson() => {
        'room_id': roomId,
        'participants': participants,
        'lastMessage': lastMessage
      };
}

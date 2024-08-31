import 'package:cloud_firestore/cloud_firestore.dart';

class ChatUser {
  String? userId;
  String? email;
  String? name;
  String? phoneNumber;
  String? avatar;
  DateTime? subscribtion;

  ChatUser({
    this.email,
    this.name,
    this.phoneNumber,
    this.userId,
    this.avatar,
    this.subscribtion,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      userId: json['user_id'],
      avatar: json['avatar'],
      subscribtion: json['subscribtion'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['subscribtion']),
    );
  }
  factory ChatUser.fromQueryDocumentJson(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return ChatUser(
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      userId: json['user_id'],
      avatar: json['avatar'],
      subscribtion: json.data()['subscribtion'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json.data()['subscribtion']),
    );
  }
}

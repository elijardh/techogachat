import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techogachat/models/chat_room.dart';

abstract class ChatRoomServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<void> createChatRoom(ChatRoom room) async {
    try {
      await firestore
          .collection('chat_room')
          .doc(room.roomId)
          .set(room.toJson());
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }
}

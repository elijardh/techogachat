import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techogachat/models/chat_user.dart';

abstract class UserServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<void> storeUser(
      String userId, Map<String, dynamic> data) async {
    try {
      await firestore.collection('users').doc(userId).set(data);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }

  static Future<ChatUser> getUser({String? userId}) async {
    try {
      final response = await firestore
          .collection('users')
          .doc(userId ?? firebaseAuth.currentUser!.uid)
          .get();

      if (!response.exists || response.data() == null) {
        throw 'Data not found';
      }

      return ChatUser.fromJson(response.data()!);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> updateSubscription(int duration) async {
    try {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'subscribtion': duration,
      });
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }
}

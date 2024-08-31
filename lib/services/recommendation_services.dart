import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:techogachat/models/chat_user.dart';

abstract class RecommendationServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<List<ChatUser>> getRecommendations() async {
    try {
      final response = await firestore
          .collection('users')
          .limit(10)
          .where('user_id', isNotEqualTo: firebaseAuth.currentUser!.uid)
          .get();

      return response.docs
          .map(
            (e) => ChatUser.fromQueryDocumentJson(e),
          )
          .toList();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Something went wrong';
    } catch (e) {
      rethrow;
    }
  }
}

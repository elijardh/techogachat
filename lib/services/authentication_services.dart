import 'package:firebase_auth/firebase_auth.dart';
import 'package:techogachat/models/chat_user.dart';
import 'package:techogachat/services/user_services.dart';

abstract class AuthenticationServices {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<ChatUser> createUser(Map<String, dynamic> data) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );

      data.remove('password');

      data.addAll({'user_id': response.user!.uid});

      await UserServices.storeUser(response.user!.uid, data);

      final user = UserServices.getUser();

      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ChatUser> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserServices.getUser();

      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}

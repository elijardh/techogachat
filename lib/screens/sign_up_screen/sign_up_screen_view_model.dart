import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/models/chat_user.dart';
import 'package:techogachat/services/authentication_services.dart';

class SignUpScreenViewModele extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool load) {
    loading = load;
    notifyListeners();
  }

  Future<void> createUser({
    required String name,
    required String password,
    required String phoneNumber,
    required String email,
    required void Function(ChatUser) onSuccess,
  }) async {
    try {
      setLoading(true);

      final Map<String, dynamic> data = {
        'email': email,
        'name': name,
        'phone_number': phoneNumber,
        'password': password,
      };

      final user = await AuthenticationServices.createUser(data);

      onSuccess(user);
    } catch (e) {
      BotToast.showText(text: e.toString());
    } finally {
      setLoading(false);
    }
  }
}

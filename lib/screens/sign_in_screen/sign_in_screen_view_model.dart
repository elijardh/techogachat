import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/app_services/app_services.dart';
import 'package:techogachat/app_services/view_model_services.dart';
import 'package:techogachat/services/authentication_services.dart';
import 'package:techogachat/services/user_services.dart';

class SignInScreenViewModel extends ChangeNotifier {
  final _auth = AppServices.locate<ViewModelServices>().auth;
  bool loading = false;
  void setLoading(bool load) {
    loading = load;
    notifyListeners();
  }

  Future<void> signIn(
      String email, String password, VoidCallback onSuccess) async {
    try {
      setLoading(true);

      await AuthenticationServices.signIn(email, password);

      final user = await UserServices.getUser();

      _auth.setUser(user);

      onSuccess();
    } catch (e) {
      BotToast.showText(text: e.toString());
    } finally {
      setLoading(false);
    }
  }
}

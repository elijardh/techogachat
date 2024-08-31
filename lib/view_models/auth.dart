import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/models/chat_user.dart';
import 'package:techogachat/services/authentication_services.dart';
import 'package:techogachat/shared/subscription_finished_dialog.dart';

class Auth extends ChangeNotifier {
  ChatUser? user;

  void setUser(ChatUser newUser) {
    user = newUser;

    notifyListeners();

    if (user != null && user!.subscribtion != null) {
      _triggerTime();
    }
  }

  Timer? timer;

  _triggerTime() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        DateTime currentDate = DateTime.now();

        if (currentDate.isAfter(user!.subscribtion!) ||
            currentDate.isAtSameMomentAs(user!.subscribtion!)) {
          //Tell the user thier sub is up
          BotToast.showWidget(
            toastBuilder: (cancelFunc) => SubscriptionFinishedDialog(
              onCancel: cancelFunc,
            ),
          );

          timer.cancel();
        }
      },
    );
  }

  Future<void> logOut(VoidCallback onSuccess) async {
    await AuthenticationServices.signOut();
    user = null;
    onSuccess();
  }
}

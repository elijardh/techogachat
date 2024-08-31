import 'dart:math';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
// import 'package:techogachat/app_services/app_services.dart';
// import 'package:techogachat/app_services/view_model_services.dart';
import 'package:techogachat/models/subscription_model.dart';

class PaymentScreenViewModel extends ChangeNotifier {
  PaymentScreenViewModel() {
    //plugin.initialize(publicKey: dotenv.env['publicKey']!);
  }
  //final _auth = AppServices.locate<ViewModelServices>().auth;

  // final plugin = PaystackPlugin();

  bool loading = false;
  void setLoading(bool load) {
    loading = load;
  }

  SubscriptionModel? selectedSubscriptionModel;

  void setSubscriptionModed(SubscriptionModel model) {
    selectedSubscriptionModel = model;
    notifyListeners();
  }

  Future<void> paySubscription(
      BuildContext context, VoidCallback onSuccess) async {
    try {
      setLoading(true);

      if (selectedSubscriptionModel == null) {
        throw 'Select a subscribtion';
      }

      // Charge charge = Charge()
      //   ..amount = 10000
      //   ..reference = getReference(10)
      //   ..email = _auth.user!.email!;

      // CheckoutResponse response = await plugin.checkout(
      //   context,
      //   method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      //   charge: charge,
      // );

      // if (!response.verify) {
      //   BotToast.showText(text: 'Transaction Failed');
      // } else {
      //   //Add the selected subscription duration to the current time
      //   int duration = DateTime.now()
      //       .add(selectedSubscriptionModel!.duration)
      //       .millisecondsSinceEpoch;

      //   //Update the user profile with the duration on the firebase
      //   await UserServices.updateSubscription(duration);

      //   //Get the updated user data from the database
      //   final user = await UserServices.getUser();

      //   //Update the local user on the device
      //   _auth.setUser(user);
      //   onSuccess();
      // }
    } catch (e) {
      BotToast.showText(text: e.toString());
    } finally {
      setLoading(false);
    }
  }
}

String? getReference(int lenght) {
  const chars =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();
  return String.fromCharCodes(Iterable.generate(
      lenght, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}

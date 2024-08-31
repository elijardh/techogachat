import 'package:flutter/material.dart';
import 'package:techogachat/app_services/app_services.dart';
import 'package:techogachat/app_services/view_model_services.dart';
import 'package:techogachat/screens/payment_screen/payment_screen.dart';
import 'package:techogachat/screens/sign_in_screen/sign_in_screen.dart';
import 'package:techogachat/shared/shared.dart';
import 'package:techogachat/utils/extensions.dart';

class SubscriptionFinishedDialog extends StatelessWidget {
  final VoidCallback onCancel;
  SubscriptionFinishedDialog({
    super.key,
    required this.onCancel,
  });

  final _auth = AppServices.locate<ViewModelServices>().auth;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your subscription has finished',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              20.vSpace,
              Button(
                buttonName: 'Subscribe',
                onTap: () {
                  onCancel();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ),
                  );
                },
              ),
              20.vSpace,
              Button(
                buttonName: 'Log Out',
                onTap: () {
                  onCancel();
                  _auth.logOut(
                    () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                      (route) => false,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techogachat/models/subscription_model.dart';
import 'package:techogachat/screens/home_screen/home_screen.dart';
import 'package:techogachat/screens/payment_screen/payment_screen_view_model.dart';
import 'package:techogachat/shared/button.dart';
import 'package:techogachat/utils/extensions.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentScreenViewModel(),
      child: Consumer<PaymentScreenViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Payment'),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 29),
            child: value.selectedSubscriptionModel == null
                ? const SizedBox()
                : Button(
                    buttonName: 'Subscribe',
                    onTap: () => value.paySubscription(
                      context,
                      () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      )),
                    ),
                  ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                20.vSpace,
                SubscriptionCard(
                  selectedModel: value.selectedSubscriptionModel,
                  onTap: (val) => value.setSubscriptionModed(val),
                  subscriptionModel: SubscriptionModel(
                    amount: 10000,
                    duration: const Duration(minutes: 5),
                  ),
                ),
                20.vSpace,
                SubscriptionCard(
                  selectedModel: value.selectedSubscriptionModel,
                  onTap: (val) => value.setSubscriptionModed(val),
                  subscriptionModel: SubscriptionModel(
                    amount: 20000,
                    duration: const Duration(days: 5),
                  ),
                ),
                20.vSpace,
                SubscriptionCard(
                  selectedModel: value.selectedSubscriptionModel,
                  onTap: (val) => value.setSubscriptionModed(val),
                  subscriptionModel: SubscriptionModel(
                    amount: 40000,
                    duration: const Duration(days: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionModel? selectedModel;
  final SubscriptionModel subscriptionModel;
  final void Function(SubscriptionModel) onTap;
  const SubscriptionCard({
    super.key,
    required this.selectedModel,
    required this.subscriptionModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(subscriptionModel),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: subscriptionModel.duration == selectedModel?.duration
                  ? Colors.orange
                  : Colors.black),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${subscriptionModel.duration.inDays} days',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text('${subscriptionModel.amount}'),
          ],
        ),
      ),
    );
  }
}

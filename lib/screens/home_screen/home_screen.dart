import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techogachat/screens/home_screen/home_screen_view_model.dart';
import 'package:techogachat/screens/home_screen/widgets/widgets.dart';
import 'package:techogachat/utils/extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeScreenViewModel(),
      child: Consumer<HomeScreenViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            leadingWidth: 0.01,
            leading: const SizedBox(),
            title: const Text(
              'John Doe',
            ),
            actions: [
              const Icon(Icons.search),
              20.hSpace,
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RecommendationsSection(
                  loading: value.recommendationsLoading,
                  users: value.recommendations,
                ),
                20.vSpace,
                const ChatSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

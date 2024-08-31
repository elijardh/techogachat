import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/models/chat_user.dart';
import 'package:techogachat/services/recommendation_services.dart';

class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel() {
    _getRecommendations();
  }

  bool recommendationsLoading = false;
  void setRecommendationsLoading(bool load) {
    recommendationsLoading = load;
    notifyListeners();
  }

  List<ChatUser> recommendations = [];

  Future<void> _getRecommendations() async {
    try {
      setRecommendationsLoading(true);

      recommendations = await RecommendationServices.getRecommendations();
    } catch (e) {
      log(e.toString());
      BotToast.showText(text: e.toString());
    } finally {
      setRecommendationsLoading(false);
    }
  }
}

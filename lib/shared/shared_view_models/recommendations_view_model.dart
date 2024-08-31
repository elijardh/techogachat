import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:techogachat/app_services/app_services.dart';
import 'package:techogachat/app_services/view_model_services.dart';
import 'package:techogachat/models/chat_room.dart';
import 'package:techogachat/models/chat_user.dart';
import 'package:techogachat/screens/payment_screen/payment_screen_view_model.dart';
import 'package:techogachat/services/chat_room_services.dart';

class RecommendationsViewModel extends ChangeNotifier {
  RecommendationsViewModel(this.recommendation);
  ChatUser recommendation;
  final _auth = AppServices.locate<ViewModelServices>().auth;

  Future<void> createChatRoom(void Function(String) onSuccess) async {
    try {
      ChatRoom chatRoom = ChatRoom(
        lastMessage: '',
        participants: [recommendation.userId!, _auth.user!.userId!],
        roomId: getReference(12)!,
      );

      await ChatRoomServices.createChatRoom(chatRoom);
      onSuccess(chatRoom.roomId);
    } catch (e) {
      BotToast.showText(text: e.toString());
    }
  }
}

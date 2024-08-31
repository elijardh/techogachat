import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatScreenViewModel extends ChangeNotifier {
  ChatScreenViewModel(this.roomId);
  String roomId;
}

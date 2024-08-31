import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techogachat/view_models/auth.dart';

class ViewModelServices {
  ViewModelServices(this._scaffoldMessengerKey);
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;

  Auth get auth => Provider.of<Auth>(
        _scaffoldMessengerKey.currentContext!,
        listen: false,
      );
}

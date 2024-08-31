import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:techogachat/app_services/view_model_services.dart';

abstract class AppServices {
  static GetIt locate = GetIt.instance;

  static void initialize() {
    GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
        GlobalKey<ScaffoldMessengerState>();
    ViewModelServices viewModelServices =
        ViewModelServices(scaffoldMessengerState);

    AppServices.locate.registerSingleton<GlobalKey<ScaffoldMessengerState>>(
      scaffoldMessengerState,
    );
    AppServices.locate.registerSingleton<ViewModelServices>(
      viewModelServices,
    );
  }
}

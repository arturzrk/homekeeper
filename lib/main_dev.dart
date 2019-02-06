import 'package:flutter/material.dart';
import 'package:homekeeper/app_config.dart';
import 'package:homekeeper/main.dart';
import 'package:homekeeper/utils/global_state.dart';

void main() {
  var configuredApp = new AppConfig(
      appTitle: 'Homekeeper dev',
      environment: 'development',
      globalState: GlobalState(),
      child: new MyApp());

  runApp(configuredApp);
}

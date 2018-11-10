import 'package:flutter/material.dart';
import 'package:homekeeper/app_config.dart';
import 'package:homekeeper/main.dart';

void main() {
  var configuredApp = new AppConfig(
      appTitle: 'Homekeeper prod',
      environment: 'production',
      child: new MyApp());

  runApp(configuredApp);
}

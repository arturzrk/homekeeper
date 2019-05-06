import 'package:flutter/material.dart';
import 'package:homekeeper/app_config.dart';
import 'package:homekeeper/forms/pre_login.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return new MaterialApp(
      title: config.appTitle,
      theme: new ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
      ),
      home: PreLoginForm(),
    );
  }
}
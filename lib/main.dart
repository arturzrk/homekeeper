import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/app_config.dart';
import 'package:homekeeper/pages/eventlist.dart';
import 'package:homekeeper/repo/event/eventstore.dart';

class MyApp extends StatefulWidget {

  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    var injector = Injector.getInjector();
    var eventService = injector.get<EventStore>();
    return new MaterialApp(
      title: config.appTitle,
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: new EventListPage(service: eventService),
      home: EventListPage(service: eventService)
    );
  }
}


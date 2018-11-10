import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:homekeeper/repo/event/fireeventstore.dart';
import 'package:homekeeper/repo/event/mockeventstore.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  final String environment;
  final String appTitle;

  AppConfig(
      {@required this.appTitle,
      @required this.environment,
      @required Widget child})
      : super(child: child) {
    setupDependencies();
  }

  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  void setupDependencies() {
    if (environment.toLowerCase() == 'development')
      setupDevDependencies();
    else
      setupProdDependencies();
  }

  void setupDevDependencies() {
    final Injector injector = Injector.getInjector();
    injector.map<EventStore>((i) => new MockEventStore());
  }

  void setupProdDependencies() {
    final Injector injector = Injector.getInjector();
    injector.map<EventStore>((i) => new FireEventStore());
  }
}

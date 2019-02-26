import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/repo/event/fireeventstore.dart';
import 'package:homekeeper/repo/event/mockeventstore.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:homekeeper/repo/template/templatestore.dart';
import 'package:homekeeper/repo/template/firetemplatestore.dart';
import 'package:homekeeper/repo/template/mocktemplatestore.dart';
import 'package:homekeeper/utils/global_state.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  final String environment;
  final String appTitle;
  final GlobalState globalState;

  AppConfig(
      {@required this.appTitle,
      @required this.environment,
      @required this.globalState,
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
    injector.map<TemplateStore>((i) => new MockTemplateStore());
    injector.map<EventStore>((i) => new MockEventStore());
  }

  void setupProdDependencies() {
    final Injector injector = Injector.getInjector();
    injector.map<TemplateStore>((i) => new FireTemplateStore(accountName: globalState.accountName));
    injector.map<EventStore>((i) => new FireEventStore(accountName: globalState.accountName));
  }
}

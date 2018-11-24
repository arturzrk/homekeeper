import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/repo/task/firetaskstore.dart';
import 'package:homekeeper/repo/task/mocktaskstore.dart';
import 'package:homekeeper/repo/task/taskstore.dart';
import 'package:homekeeper/repo/template/templatestore.dart';
import 'package:homekeeper/repo/template/firetemplatestore.dart';
import 'package:homekeeper/repo/template/mocktemplatestore.dart';
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
    injector.map<TemplateStore>((i) => new MockTemplateStore());
    injector.map<TaskStore>((i) => new MockTaskStore());
  }

  void setupProdDependencies() {
    final Injector injector = Injector.getInjector();
    injector.map<TemplateStore>((i) => new FireTemplateStore());
    injector.map<TaskStore>((i) => new FireTaskStore());
  }
}

import 'package:flutter/widgets.dart';
import 'package:homekeeper/bloc/events_bloc.dart';

class EventsProvider extends InheritedWidget {
  EventsProvider({this.eventsBloc});
  final EventsBloc eventsBloc;
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static EventsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(EventsProvider);
  }
}
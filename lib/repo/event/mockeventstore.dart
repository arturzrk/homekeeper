import 'dart:async';

import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';

class MockEventStore implements EventStore {

  final Duration _interval = Duration(milliseconds: 200);
  final _tasks =  [
    Event(
      title: 'first',
      category: TemplateCategory.hydrofor.name,
      startDate: DateTime.now().subtract(Duration(minutes: 45)),
    ),
    Event(
      title: 'second',
      category: TemplateCategory.rekuperator.name,
      startDate: DateTime.now().subtract(Duration(days: 25)),
    ),
    Event(
      title: 'third',
      category: TemplateCategory.scieki.name,
      startDate: DateTime.now().subtract(Duration(days: 33)),
    )
  ];

  @override
  Future<String> createEvent(Event event) async{
    _tasks.add(event);
    return "1234";
  }

  @override
  Future deleteEvent(Event eventToDelete) async {
  }

  @override
  Stream<List<Event>> getEvents() async* {
    yield _tasks;
  }

  @override
  Future updateEvent(Event updatedEvent) async{
    await Future.delayed(_interval);
  }
}
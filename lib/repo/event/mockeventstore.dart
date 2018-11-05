import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';

class MockEventStore implements EventStore {
  
  MockEventStore();

  final Duration _interval = Duration(milliseconds: 200);
  final cEvents =  [
    Event(
      title: 'first',
      category: EventCategory.hydrofor.name,
      occurenceDate: DateTime.now(),
      reoccurenceDaysCount: 90
    ),
    Event(
      title: 'second',
      category: EventCategory.rekuperator.name,
      occurenceDate: DateTime.now().add(Duration(days: 20)),
      reoccurenceDaysCount: 365
    ),
    Event(
      title: 'third',
      category: EventCategory.scieki.name,
      occurenceDate: DateTime.now().add(Duration(days: 30)),
      reoccurenceDaysCount: 30
    )
  ];

  @override
  Future<String> createEvent(Event event) async{
    cEvents.add(event);
    return "1234";
  }

  @override
  void deleteEvent(String eventID) {
    return;
  }

  @override
  Stream<List<Event>> getEvents() async* {
    await Future.delayed(_interval);
    yield cEvents;
  }

  @override
  Event updateEvent(String eventID, Event updatedEvent) {
    return updatedEvent;
  }

}
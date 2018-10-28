import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';

class MockEventStore implements EventStore {
  MockEventStore();

  final cEvents =  [
    Event(
      title: 'first',
      category: EventCategory.Hydrofor,
      occurenceDate: DateTime.now(),
      reoccurenceDaysCount: 90
    ),
    Event(
      title: 'second',
      category: EventCategory.Rekuperator,
      occurenceDate: DateTime.now().add(Duration(days: 20)),
      reoccurenceDaysCount: 365
    ),
    Event(
      title: 'third',
      category: EventCategory.Szambo,
      occurenceDate: DateTime.now().add(Duration(days: 30)),
      reoccurenceDaysCount: 30
    )
  ];

  @override
  String createEvent(Event event) {
    return "1234";
  }

  @override
  void deleteEvent(String eventID) {
    return;
  }

  @override
  List<Event> getEvents() {
    return cEvents;
  }

  @override
  Event updateEvent(String eventID, Event updatedEvent) {
    return updatedEvent;
  }

}
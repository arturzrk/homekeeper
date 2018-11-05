import 'package:homekeeper/model/event.dart';

abstract class EventStore {
  Stream<List<Event>> getEvents();
  Future<String> createEvent(Event event);
  Event updateEvent(String eventID, Event updatedEvent);
  void deleteEvent(String eventID);
}
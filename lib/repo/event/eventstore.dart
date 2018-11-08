import 'package:homekeeper/model/event.dart';

abstract class EventStore {
  Stream<List<Event>> getEvents();
  Future<String> createEvent(Event event);
  Future updateEvent(Event updatedEvent);
  void deleteEvent(String eventID);
}
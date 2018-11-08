import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';

class FireEventStore implements EventStore {
  @override
  Future<String> createEvent(Event event) async{
    final ref = Firestore.instance.collection('event').document();
    await ref.setData(event.toMap()); 
    return ref.documentID;
  }

  @override
  void deleteEvent(String eventID) {
    // TODO: implement deleteEvent
  }

  @override
  Stream<List<Event>> getEvents() async* {
    final snapshotStream = Firestore.instance.collection('event').snapshots();
    await for(var snapshot in snapshotStream) {
      var eventSnapshots = snapshot.documents;
      var x = eventSnapshots.map((document) {
        return Event.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateEvent(Event updatedEvent) async{
     await updatedEvent.reference.updateData(updatedEvent.toMap());
  }
}
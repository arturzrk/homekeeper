import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';

class FireEventStore implements EventStore {
  @override
  Future<String> createEvent(Event task) async{
    final ref = Firestore.instance.collection(getCollectionPath()).document();
    await ref.setData(task.toMap()); 
    return ref.documentID;
  }

  String getCollectionPath() => 'task';

  @override
  Future deleteEvent(Event eventToDelete) async{
    eventToDelete.reference.delete();
  }

  @override
  Stream<List<Event>> getEvents() async* {
    final snapshotStream = Firestore.instance.collection(getCollectionPath()).snapshots();
    await for(var snapshot in snapshotStream) {
      var templateSnapshots = snapshot.documents;
      var x = templateSnapshots.map((document) {
        return Event.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateEvent(Event updatedTask) async{
     await updatedTask.reference.updateData(updatedTask.toMap());
  }
}
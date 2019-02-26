import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:meta/meta.dart';

class FireEventStore implements EventStore {

  final String accountName;

  FireEventStore({@required this.accountName});

  @override
  Future<String> createEvent(Event event) async {
    final ref = Firestore.instance.collection(getCollectionPath()).document();
    await ref.setData(event.toMap());
    return ref.documentID;
  }

  String getCollectionPath() => 'users/$accountName/event';

  @override
  Future deleteEvent(Event eventToDelete) async {
    eventToDelete.reference.delete();
  }

  @override
  Stream<List<Event>> getEvents() async* {
    final snapshotStream =
        Firestore.instance.collection(getCollectionPath()).snapshots();
    await for (var snapshot in snapshotStream) {
      var templateSnapshots = snapshot.documents;
      var x = templateSnapshots.map((document) {
        return Event.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateEvent(Event updatedTask) async {
    await updatedTask.reference.updateData(updatedTask.toMap());
  }

}

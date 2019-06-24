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
    final ref = fireStoreCollection.document();
    await ref.setData(event.toMap());
    return ref.documentID;
  }

  String get collectionPath => 'users/$accountName/event';
  CollectionReference get fireStoreCollection => Firestore.instance.collection(collectionPath);

  @override
  Future deleteEvent(Event eventToDelete) async {
    fireStoreCollection.document(eventToDelete.reference).delete();
  }

  @override
  Stream<List<Event>> getEvents() async* {
    final snapshotStream =
        fireStoreCollection.snapshots();
    await for (var snapshot in snapshotStream) {
      var templateSnapshots = snapshot.documents;
      templateSnapshots.sort((a, b) {
    return Event.fromSnapshot(b).startDate.compareTo(Event.fromSnapshot(a).startDate);
    });
      var x = templateSnapshots.map((document) {
        return Event.fromSnapshot(document);
      }).toList();
      yield x;
    }
  }

  @override
  Future updateEvent(Event updatedTask) async {
    await fireStoreCollection.document(updatedTask.reference).updateData(updatedTask.toMap());
  }

}

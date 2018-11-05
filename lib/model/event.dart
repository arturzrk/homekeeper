import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String title;
  String category;
  DateTime occurenceDate;
  bool isReoccurence = false;
  int reoccurenceDaysCount;
  DocumentReference reference;
  Event({this.title, this.category, this.occurenceDate, this.reoccurenceDaysCount});

  Event.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['category'] != null),
       assert(map['occurenceDate'] != null),
       title = map['title'],
       category = map['category'],
       occurenceDate = map['occurenceDate'],
       reoccurenceDaysCount = map['reocurenceDaysCount'];

  Event.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic>  toMap(Event event) {
    var map = Map<String,dynamic>();
    map['title'] = event.title;
    map['category'] = event.category;
    map['occurenceDate'] = event.occurenceDate;
    map['reoccurenceDaysCount'] = event.reoccurenceDaysCount;
    return map;
  }
}
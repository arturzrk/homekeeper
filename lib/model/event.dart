import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String title;
  String category;
  DateTime startDate;
  DocumentReference templateReference;
  DocumentReference reference;
  Event({this.title, this.category, this.startDate, this.templateReference, this.reference});

  Event.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['category'] != null),
       assert(map['startDate'] != null),
       title = map['title'],
       category = map['category'],
       startDate = map['startDate'],
       templateReference = map['templateReference'] != null ? map['templateReference'] : null; 
       
  Event.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic>  toMap() {
    var map = Map<String,dynamic>();
    map['title'] = title;
    map['category'] = category;
    map['startDate'] = startDate;
    map['templateReference'] = templateReference;
    return map;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String title;
  String category;
  DateTime startDate;
  DocumentReference templateReference;
  DocumentReference reference;
  Task({this.title, this.category, this.startDate, this.templateReference, this.reference});

  Task.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['category'] != null),
       assert(map['startDate'] != null),
       title = map['title'],
       category = map['category'],
       startDate = map['startDate'];
       
  Task.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, reference: snapshot.reference);

  Map<String, dynamic>  toMap() {
    var map = Map<String,dynamic>();
    map['title'] = title;
    map['category'] = category;
    map['startDate'] = startDate;
    return map;
  }
}
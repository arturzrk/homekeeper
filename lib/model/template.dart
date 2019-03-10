import 'package:cloud_firestore/cloud_firestore.dart';

class Template {
  String title;
  String category;
  DateTime occurenceDate;
  bool isReoccurence = false;
  int reoccurenceDaysCount;
  String reference;
  Template({this.title, this.category, this.occurenceDate, this.reoccurenceDaysCount, this.isReoccurence, this.reference});

  Template.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['category'] != null),
       assert(map['occurenceDate'] != null),
       title = map['title'],
       category = map['category'],
       occurenceDate = map['occurenceDate'],
       isReoccurence = map['isReoccurence'],
       reoccurenceDaysCount = map['reoccurenceDaysCount'];

  Template.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, reference: snapshot.reference.documentID);

  Map<String, dynamic>  toMap() {
    var map = Map<String,dynamic>();
    map['title'] = title;
    map['category'] = category;
    map['isReoccurence'] = isReoccurence;
    map['occurenceDate'] = occurenceDate;
    map['reoccurenceDaysCount'] = reoccurenceDaysCount;
    return map;
  }
}
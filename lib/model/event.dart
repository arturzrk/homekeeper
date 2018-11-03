import 'package:homekeeper/model/category.dart';

class Event {
  String title;
  EventCategory category;
  DateTime occurenceDate;
  bool isReoccurence = false;
  int reoccurenceDaysCount;
  Event({this.title, this.category, this.occurenceDate, this.reoccurenceDaysCount});
}
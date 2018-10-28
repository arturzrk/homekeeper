import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum EventCategory {
  Szambo, Hydrofor, Rekuperator, Other
}

final Map<EventCategory, Icon> categoryIcon = {
  EventCategory.Szambo: Icon(CupertinoIcons.add_circled),
  EventCategory.Hydrofor: Icon(CupertinoIcons.clear_circled_solid),
  EventCategory.Rekuperator: Icon(CupertinoIcons.delete_solid),
  EventCategory.Other: Icon(CupertinoIcons.loop_thick)
};

class Event {
  String title;
  EventCategory category;
  DateTime occurenceDate;
  int reoccurenceDaysCount;
  Event({this.title, this.category, this.occurenceDate, this.reoccurenceDaysCount});
}
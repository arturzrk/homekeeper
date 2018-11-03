
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventCategory {
  final String name;
  final Icon icon;
  const EventCategory({this.name, this.icon});

  static const EventCategory scieki = EventCategory( name: 'Scieki', icon: Icon(CupertinoIcons.add_circled) );
  static const EventCategory hydrofor = EventCategory( name: 'Hydrofor', icon: Icon(CupertinoIcons.clear_circled_solid) );
  static const EventCategory rekuperator = EventCategory( name: 'Rekuperator', icon: Icon(CupertinoIcons.delete_solid) );
  static const EventCategory other = EventCategory( name: 'Inne', icon: Icon(CupertinoIcons.loop_thick) );
  static const List<EventCategory> eventCategories = [ scieki, hydrofor, rekuperator, other ];
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateCategory {
  final String name;
  final Icon icon;
  const TemplateCategory({this.name, this.icon});

  static const TemplateCategory scieki = TemplateCategory( name: 'Scieki', icon: Icon(CupertinoIcons.add_circled) );
  static const TemplateCategory hydrofor = TemplateCategory( name: 'Hydrofor', icon: Icon(CupertinoIcons.clear_circled_solid) );
  static const TemplateCategory rekuperator = TemplateCategory( name: 'Rekuperator', icon: Icon(CupertinoIcons.delete_solid) );
  static const TemplateCategory other = TemplateCategory( name: 'Inne', icon: Icon(CupertinoIcons.loop_thick) );
  static const List<TemplateCategory> templateCategories = [ scieki, hydrofor, rekuperator, other ];
}


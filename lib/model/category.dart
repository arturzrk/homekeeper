
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateCategory {
  final String name;
  final IconData icon;
  final String imageLocation;
  const TemplateCategory({this.name, this.icon, this.imageLocation});

  static const TemplateCategory scieki = TemplateCategory( name: 'Scieki', imageLocation: "assets/icons/edziu.png" );
  static const TemplateCategory hydrofor = TemplateCategory( name: 'Hydrofor', icon: CupertinoIcons.clear_circled_solid );
  static const TemplateCategory rekuperator = TemplateCategory( name: 'Rekuperator', imageLocation: "assets/icons/rekuperacja.png" );
  static const TemplateCategory other = TemplateCategory( name: 'Inne', icon: CupertinoIcons.loop_thick );
  static const List<TemplateCategory> templateCategories = [ scieki, hydrofor, rekuperator, other ];
}


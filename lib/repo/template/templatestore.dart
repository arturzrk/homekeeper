import 'dart:async';

import 'package:homekeeper/model/template.dart';

abstract class TemplateStore {
  Stream<List<Template>> getTemplates();
  Future<String> createTemplate(Template template);
  Future updateTemplate(Template updatedTemplate);
  Future deleteTemplate(Template templateToDelete);
}
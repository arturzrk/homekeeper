import 'package:homekeeper/model/template.dart';

abstract class TemplateStore {
  Stream<List<Template>> getTemplates();
  Future<String> createTemplate(Template template);
  Future updateTemplate(Template updatedTemplate);
  void deleteTemplate(String templateID);
}
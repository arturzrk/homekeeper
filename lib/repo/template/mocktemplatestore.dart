import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/repo/template/templatestore.dart';

class MockTemplateStore implements TemplateStore {

  final Duration _interval = Duration(milliseconds: 200);
  final cEvents =  [
    Template(
      title: 'first',
      category: EventCategory.hydrofor.name,
      occurenceDate: DateTime.now(),
      isReoccurence: true,
      reoccurenceDaysCount: 90,
    ),
    Template(
      title: 'second',
      category: EventCategory.rekuperator.name,
      occurenceDate: DateTime.now().add(Duration(days: 20)),
      isReoccurence: true,
      reoccurenceDaysCount: 365
    ),
    Template(
      title: 'third',
      category: EventCategory.scieki.name,
      occurenceDate: DateTime.now().add(Duration(days: 30)),
      isReoccurence: true,
      reoccurenceDaysCount: 30
    )
  ];

  @override
  Future<String> createTemplate(Template event) async{
    cEvents.add(event);
    return "1234";
  }

  @override
  void deleteTemplate(String eventID) {
    return;
  }

  @override
  Stream<List<Template>> getTemplates() async* {
    yield cEvents;
  }

  @override
  Future updateTemplate(Template updatedEvent) async{
    await Future.delayed(_interval);
  }

}
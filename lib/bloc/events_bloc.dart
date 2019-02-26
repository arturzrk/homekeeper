import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/model/template.dart';

class EventsBloc {
  static Event fromTemplate(Template template) {
    return Event(
        category: template.category,
        startDate: DateTime.now(),
        templateReference: template.reference,
        title: template.title);
  }
}

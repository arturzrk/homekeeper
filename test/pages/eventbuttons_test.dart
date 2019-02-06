import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart' hide group;
import 'package:homekeeper/model/template.dart';
import 'package:test/test.dart' show group;
import 'package:homekeeper/pages/eventbuttons.dart';
import 'package:homekeeper/repo/template/mocktemplatestore.dart';


final Map<String,int> buttonsTapped = Map<String, int>();

void eventTriggered(Template event) {
  buttonsTapped.putIfAbsent(event.title, () => 0);
  buttonsTapped[event.title]++;
}

void main() async {

  var service = MockTemplateStore();
  var buttonsWidget = EventButtons(
    templateService: service,
    onEventTriggered: eventTriggered
  );
  var templates = await service
      .getTemplates()
      .first;

  group('Event buttons tests', ()  {
    testWidgets(
        'Should display button for each template', (WidgetTester tester) async {
      var wut = MaterialApp(
        home: Scaffold(
          body: buttonsWidget,
        ),
      );
      await tester.pumpWidget(wut);
      await tester.pumpAndSettle();

      for (var template in templates) {
        var buttonFinder = find.byKey(Key(template.title));
        expect(buttonFinder, findsOneWidget);
        await tester.tap(buttonFinder);
      }
      expect(buttonsWidget.templateService, equals(service));

      expect(buttonsTapped.values, equals(List.filled(templates.length, 1)));
    });
  });
}


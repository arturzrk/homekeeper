import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homekeeper/forms/eventform.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';

const String EVENT_TITLE = 'Testing Event Form.';

void main() {
  testWidgets('EventForm test', (WidgetTester tester) async {
    var event = new Event(
      isReoccurence: true,
      title: 'Title before update',
      occurenceDate: DateTime.now(),
      category: 'Inne',
      reoccurenceDaysCount: 10,
    );
    Event targetEvent;
    EventForm page = new EventForm(
        event: event,
        onSubmit: (event) {
          targetEvent = event;
        });

    await tester.pumpWidget(makeTestableWidget(page: page));
    await tester.enterText(find.byKey(Key('title-text-field')), EVENT_TITLE);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('category-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('category-Rekuperator')).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('submit-button')));
    expect(targetEvent.title, equals(EVENT_TITLE));
    expect(targetEvent.category, 'Rekuperator');
  });
}

Widget makeTestableWidget({Widget page}) {
  return new MaterialApp(home: page);
}

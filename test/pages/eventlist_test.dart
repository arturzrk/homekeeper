import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homekeeper/forms/eventform.dart';
import 'package:homekeeper/model/event.dart';

void main() {
  testWidgets('EventList test to check lines and add button',
      (WidgetTester tester) async {
    var event = new Event(
      isReoccurence: true,
      title: 'Testing event form',
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
    await tester.pump();
    expect(find.byKey(Key('submit-button')), findsOneWidget);
  });
}

Widget makeTestableWidget({Widget page}) {
  return MaterialApp(home: page);
}

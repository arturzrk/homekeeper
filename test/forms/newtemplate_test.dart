import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homekeeper/forms/templateform.dart';
import 'package:homekeeper/model/template.dart';
import 'package:mockito/mockito.dart';

const String EVENT_TITLE = 'Testing Event Form.';

class MockDocumentReference extends Mock implements DocumentReference {}

void main() {
 
  testWidgets('New Event Template test', (WidgetTester tester) async {
    Template targetEvent;
    EventForm page = new EventForm(
        onSubmit: (event) {
          targetEvent = event;
        });

    await tester.pumpWidget(makeTestableWidget(page: page));
    await tester.enterText(find.byKey(Key('title-text-field')), EVENT_TITLE);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('occurence-date')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('13'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('category-dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key('category-Rekuperator')).at(1));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('auto-repeat')));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('cycle-days')), '100');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('submit-button')));
    expect(targetEvent.title, equals(EVENT_TITLE));
    expect(targetEvent.category, 'Rekuperator');
    expect(targetEvent.isReoccurence, isTrue);
    expect(targetEvent.occurenceDate.day, equals(13));
    expect(targetEvent.reoccurenceDaysCount, 100);
  });
}

Widget makeTestableWidget({Widget page}) {
  return new MaterialApp(home: page);
}

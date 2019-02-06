import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homekeeper/forms/eventform.dart';
import 'package:homekeeper/model/event.dart';

void main() {
  testWidgets('Given_TaskForm_When_DisplayedWithTask_UpdateTitleShown',
      (WidgetTester tester) async {
    //given
    Event event = new Event();
    EventForm form = new EventForm(
      event: event,
    );
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    //then
    expect(find.text(EventForm.updateTitle), findsOneWidget);
    expect(find.text(EventForm.newTitle), findsNothing);
  });

  testWidgets('Given_TaskForm_When_DisplayedWithoutTask_NewTitleShown',
      (WidgetTester tester) async {
    //given
    EventForm form = new EventForm();
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    //then
    expect(find.text(EventForm.updateTitle), findsNothing);
    expect(find.text(EventForm.newTitle), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_Displayed_CategoryIsShown',
      (WidgetTester tester) async {
    //given
    EventForm form = new EventForm();
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    //then
    expect(find.byKey(Key('category-dropdown')), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_Displayed_TaskTitleIsShown',
      (WidgetTester tester) async {
    //given
    EventForm form = new EventForm();
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    //then
    expect(find.byKey(Key('title-text-field')), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_Displayed_StartDateIsShown',
      (WidgetTester tester) async {
    //given
    EventForm form = new EventForm();
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    //then
    expect(find.byKey(Key('start-date')), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_TitleBlank_ValidationError',
      (WidgetTester tester) async {
    //given
    EventForm form = new EventForm();
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    await tester.tap(find.byKey(Key('submit-button')));
    await tester.pumpAndSettle();

    //then
    expect(
        find.text(EventForm.eventTitleRequiredValidationMessage), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_CategoryBlank_ValidationError',
      (WidgetTester tester) async {
    //given
    EventForm form = new EventForm();
    Widget page = new MaterialApp(home: form);

    //when
    await tester.pumpWidget(page);

    await tester.tap(find.byKey(Key('submit-button')));
    await tester.pumpAndSettle();

    //then
    expect(find.text(EventForm.eventCategoryRequiredValidationMessage),
        findsOneWidget);
  });
}

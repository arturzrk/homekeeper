import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:homekeeper/forms/taskform.dart';
import 'package:homekeeper/model/task.dart';

void main() {

  testWidgets('Given_TaskForm_When_DisplayedWithTask_UpdateTitleShown', (WidgetTester tester) async {
    //given
    Task task = new Task();
    TaskForm form = new TaskForm( task: task,);
    Widget page = new MaterialApp(home: form);
    
    //when
    await tester.pumpWidget(page);

    //then
    expect(find.text(TaskForm.updateTitle), findsOneWidget);
    expect(find.text(TaskForm.newTitle), findsNothing);
  });

  testWidgets('Given_TaskForm_When_DisplayedWithoutTask_NewTitleShown', (WidgetTester tester) async {

    //given
    TaskForm form = new TaskForm();
    Widget page = new MaterialApp(home: form);
    
    //when
    await tester.pumpWidget(page);

    //then
    expect(find.text(TaskForm.updateTitle), findsNothing);
    expect(find.text(TaskForm.newTitle), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_Displayed_CategoryIsShown', (WidgetTester tester) async {

    //given
    TaskForm form = new TaskForm();
    Widget page = new MaterialApp(home: form);
    
    //when
    await tester.pumpWidget(page);

    //then
    expect(find.byKey(Key('category-dropdown')), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_Displayed_TaskTitleIsShown', (WidgetTester tester) async {

    //given
    TaskForm form = new TaskForm();
    Widget page = new MaterialApp(home: form);
    
    //when
    await tester.pumpWidget(page);

    //then
    expect(find.byKey(Key('title-text-field')), findsOneWidget);
  });

  testWidgets('Given_TaskForm_When_Displayed_StartDateIsShown', (WidgetTester tester) async {

    //given
    TaskForm form = new TaskForm();
    Widget page = new MaterialApp(home: form);
    
    //when
    await tester.pumpWidget(page);

    //then
    expect(find.byKey(Key('start-date')), findsOneWidget);
  });

}
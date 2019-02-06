import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/widgets/inputdropdown.dart';
import 'package:intl/intl.dart';

enum FormMode { New, Update }

class EventForm extends StatefulWidget {
  static String eventTitleRequiredValidationMessage = 'Event title is required.';
  static String eventCategoryRequiredValidationMessage =
      'Event Category needs to be selected.';
  static String newTitle = 'New Event';
  static String updateTitle = 'Update Event';
  final Event event;
  final ValueChanged<Event> onSubmit;

  EventForm({this.event, this.onSubmit});

  @override
  State<EventForm> createState() {
    return new EventFormState(
        mode: event == null ? FormMode.New : FormMode.Update);
  }
}

class EventFormState extends State<EventForm> {
  final FormMode mode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Event _formData;
  String title;

  EventFormState({this.mode});

  Future<Null> _selectDate(BuildContext context, DateTime initialDate,
      ValueChanged<DateTime> selectDate) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != initialDate) selectDate(picked);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if (mode == FormMode.New) {
        title = EventForm.newTitle;
        _formData = new Event();
        _formData.startDate = DateTime.now();
      } else {
        title = EventForm.updateTitle;
        _formData = widget.event;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
           padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 8.0),
          child: Form(
              key: _formKey,
              child: ListView(children: [
                TextFormField(
                  key: Key('title-text-field'),
                  decoration: InputDecoration(
                    labelText: 'Description of the task',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                  maxLines: 2,
                  initialValue: _formData.title,
                  validator: _validateTextBoxEntry,
                  style: Theme.of(context).textTheme.title,
                  onSaved: (value) {
                    _formData.title = value;
                  },
                ),
                InputDropDown(
                    key: Key('start-date'),
                    labelText: 'When',
                    valueText: _formData.startDate == null
                        ? 'null'
                        : DateFormat.yMMMd().format(_formData.startDate),
                    valueStyle: Theme.of(context).textTheme.title,
                    onPressed: () {
                      _selectDate(context, _formData.startDate, (DateTime date) {
                        setState(() {
                          _formData.startDate = date;
                        });
                      });
                    }),
                FormField(validator: (value) {
                  if (value == null || value.toString().isEmpty)
                    return EventForm.eventCategoryRequiredValidationMessage;
                  return null;
                }, builder: (FormFieldState state) {
                  final decoration = const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Choose a category',
                      contentPadding: EdgeInsets.zero);

                  return InputDecorator(
                      decoration: decoration.copyWith(errorText: state.errorText),
                      baseStyle: Theme.of(context).textTheme.title,
                      child: DropdownButton<String>(
                          key: Key('category-dropdown'),
                          value: _formData.category,
                          onChanged: (String value) {
                            setState(() {
                              _formData.category = value;
                            });
                            state.didChange(value);
                          },
                          items:
                              TemplateCategory.templateCategories.map((category) {
                            return DropdownMenuItem<String>(
                              key: Key('category-${category.name}'),
                              value: category.name,
                              child: Text(category.name),
                            );
                          }).toList()));
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    key: Key('submit-button'),
                    onPressed: _onSubmitPressed,
                    child: Text('Submit'),
                  ),
                ),
              ])),
        ));
  }

  String _validateTextBoxEntry(String value) {
    if (value.isEmpty) return EventForm.eventTitleRequiredValidationMessage;

    return null;
  }

  void _onSubmitPressed() async {
    if (_formKey.currentState.validate()) {
      await _saveFormData();
      Navigator.pop(context);
    }
  }

  Future _saveFormData() async {
    _formKey.currentState.save();

    if (widget.onSubmit != null) {
      widget.onSubmit(_formData);
    }
  }
}

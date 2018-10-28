import 'package:flutter/material.dart';
import 'package:homekeeper/model/event.dart';

class EventForm extends StatefulWidget {
  @override
  EventFormState createState() {
    return new EventFormState();
  }
}

class EventFormState extends State<EventForm> {

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Event _formData = new Event();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('New Event')
        ),
        body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Description',
              labelText: 'Goal'
            ),
            validator: _validateTextBoxEntry,
            onSaved: (value) { _formData.title = value; },
          ),
          FormField(
            builder: (FormFieldState state) {
              return DropdownButton(
                value: _formData.category,
                onChanged: (EventCategory newValue) {
                  setState(() {
                    _formData.category = newValue;
                    state.didChange(newValue);                    
                  });
                },
                items: EventCategory.values.map(
                   (EventCategory cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat.  toString()));
                    }
                  ).toList()
              );
            },
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: _onSubmitPressed,
                child: Text('Submit'),
              ),
            ),
          ]
        )
      )
    );
  }

 
  String _validateTextBoxEntry(String value) {
    if(value.isEmpty) 
      return 'Please enter something.';
    return null;
  }

  void _onSubmitPressed() {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Processing Data..Event Title = ${_formData.title}')));
    }
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/widgets/inputdropdown.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  final Event event;
  final void Function(Event event) onSubmit;
  
  EventForm({Key key, this.event, this.onSubmit}):super(key: key);

  @override
  EventFormState createState() {
    return new EventFormState();
  }
}

class EventFormState extends State<EventForm> {

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Event _formData;
  String _formTitle = 'New Event';
  DocumentReference reference;

  Future<Null> _selectDate(BuildContext context,ValueChanged<DateTime> selectDate) async {
    
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != _formData.occurenceDate)
      selectDate(picked);
  }

  @override
  void initState() {
    super.initState();
    if(widget.event != null) {
      setState(() {
        _formData = widget.event;
        _formTitle = 'Update Event';
      }); 
    } else
    {
      _formData = new Event();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(_formTitle)
        ),
        body: Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
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
                    onSaved: (value) { _formData.title = value; },
                  ),
                  InputDropDown(
                    labelText: 'When',
                    valueText: _formData.occurenceDate == null ? 'null' : DateFormat.yMMMd().format(_formData.occurenceDate),
                    valueStyle: Theme.of(context).textTheme.title,
                    onPressed: ()  {_selectDate( context, 
                        (DateTime date) {
                          setState(() {
                            _formData.occurenceDate = date;
                          });
                        }
                  );}),  
                  InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      hintText: 'Choose a category',
                      contentPadding: EdgeInsets.zero,
                    ),
                    baseStyle: Theme.of(context).textTheme.title,
                    child: DropdownButton<String>(
                      key: Key('category-dropdown'),
                      value: _formData.category,
                      onChanged: (String value) {
                        setState(() {_formData.category = value;});
                      },
                      items: EventCategory.eventCategories.map( (category) {
                       return DropdownMenuItem<String>(
                         key: Key('category-${category.name}'),
                         value: category.name,
                         child: Text(category.name),
                       );
                      }).toList()
                    )
                  ),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Auto-repeat',
                      hintText: 'Select to activate Auto-repeat feature',
                    ),
                    baseStyle: Theme.of(context).textTheme.title,
                    child:FormField( 
                      builder: (FormFieldState state) {
                        return MergeSemantics(
                          child: Switch(
                          value: _formData.isReoccurence,
                          onChanged: (bool value) { setState(() {_formData.isReoccurence = value;});}
                          )
                        );
                      })
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cycle Days'
                    ),
                    initialValue: _formData.reoccurenceDaysCount.toString(),
                    keyboardType: TextInputType.number,
                    onSaved: (String value) {
                      setState(() {
                        _formData.reoccurenceDaysCount = int.tryParse(value);                              
                      });
                    },
                    style: Theme.of(context).textTheme.title,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        key: Key('submit-button'),
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

  void _onSubmitPressed() async{
    if (_formkey.currentState.validate()) {
      await _saveFormData();
      Navigator.pop(context);
    }
  }

  Future _saveFormData() async {
    _formkey.currentState.save();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text('Processing Data..Event to happen on ${_formData.occurenceDate}, title = ${_formData.title}, reocurence ? ${_formData.isReoccurence}, cycle = ${_formData.reoccurenceDaysCount}')));
    
    if(widget.onSubmit != null)
       widget.onSubmit(_formData);
  }
}
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/widgets/inputdropdown.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  final Template template;
  final void Function(Template event) onSubmit;
  
  EventForm({Key key, this.template, this.onSubmit}):super(key: key);

  @override
  EventFormState createState() {
    return new EventFormState();
  }
}

class EventFormState extends State<EventForm> {

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Template _formData;
  String _formTitle = 'New Event Template';
  DocumentReference reference;

  Future<Null> _selectDate(BuildContext context,ValueChanged<DateTime> selectDate) async {
    
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _formData.occurenceDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != _formData.occurenceDate)
      selectDate(picked);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      if(widget.template != null) {
          _formData = widget.template;
          _formTitle = 'Update Event Template';
        }
        else {
          _formData = new Template();
          _formData.occurenceDate = DateTime.now();
          _formData.isReoccurence = false;
          _formData.reoccurenceDaysCount = 0;
        }
    }); 
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
                    key: Key('occurence-date'),
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
                      items: TemplateCategory.templateCategories.map( (category) {
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
                            key: Key('auto-repeat'),
                            value: _formData.isReoccurence != null? _formData.isReoccurence : false,
                            onChanged: (bool value) { setState(() {_formData.isReoccurence = value;});}
                          )
                        );
                      })
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cycle Days'
                    ),
                    key: Key('cycle-days'),
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
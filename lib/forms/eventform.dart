import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:homekeeper/widgets/inputdropdown.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  @override
  EventFormState createState() {
    return new EventFormState();
  }
}

class EventFormState extends State<EventForm> {

  final _formkey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Injector injector = Injector.getInjector();
  Event _formData = new Event();
  EventStore _service;

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
    _service = injector.get<EventStore>();
    setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('New Event')
        ),
        body: DropdownButtonHideUnderline(
          child: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description of the task',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    maxLines: 5,
                    validator: _validateTextBoxEntry,
                    style: Theme.of(context).textTheme.display1,
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
                      value: _formData.category,
                      onChanged: (String value) {
                        setState(() {_formData.category = value;});
                      },
                      items: EventCategory.eventCategories.map( (category) {
                       return DropdownMenuItem<String>(
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
                    initialValue: '0',
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
                        onPressed: _onSubmitPressed,
                        child: Text('Submit'),
                      ),
                  ),
                ]
              )
            )
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
      _formkey.currentState.save();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Processing Data..Event to happen on ${_formData.occurenceDate}, title = ${_formData.title}, reocurence ? ${_formData.isReoccurence}, cycle = ${_formData.reoccurenceDaysCount}')));
      await _service.createEvent(_formData);
      Navigator.pop(context);
    }
  }
}
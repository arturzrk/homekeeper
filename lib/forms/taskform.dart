import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/task.dart';
import 'package:homekeeper/widgets/inputdropdown.dart';
import 'package:intl/intl.dart';

enum FormMode { New, Update} 

class TaskForm extends StatefulWidget {
  static String newTitle = 'New Task'; 
  static String updateTitle = 'Update Task';
  final Task task;
  final void Function(Task task) onSubmit;
  
  TaskForm({this.task, this.onSubmit});

  @override
  State<TaskForm> createState() {
    return new TaskFormState(mode: task == null? FormMode.New : FormMode.Update);
  }
}

class TaskFormState extends State<TaskForm> {

  final FormMode mode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Task _formData;
  String title;

  TaskFormState({this.mode});

  Future<Null> _selectDate(BuildContext context, DateTime initialDate, ValueChanged<DateTime> selectDate) async {
    
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != initialDate)
      selectDate(picked);
  }

  @override 
  void initState() {
      super.initState();
      setState(() {
        if(mode == FormMode.New){
            title = TaskForm.newTitle;
            _formData = new Task();
            _formData.startDate = DateTime.now();
        } else {
          title = TaskForm.updateTitle;
          _formData = widget.task;
        }     
      });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( title )
      ),
      body: Form(
        key: _formKey,
        child: ListView(
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
              key: Key('start-date'),
              labelText: 'When',
              valueText: _formData.startDate == null ? 'null' : DateFormat.yMMMd().format(_formData.startDate),
              valueStyle: Theme.of(context).textTheme.title,
              onPressed: ()  {_selectDate( context, _formData.startDate,
                  (DateTime date) {
                    setState(() {
                      _formData.startDate = date;
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
      return "Title is mandatory.";

    return null; 
  }

  void _onSubmitPressed() async {
    if(_formKey.currentState.validate()) {
      await _saveFormData();
      Navigator.pop(context);
    }
  }

  Future _saveFormData() async {
    _formKey.currentState.save();
    
    if(widget.onSubmit != null)
       widget.onSubmit(_formData);
  }
}
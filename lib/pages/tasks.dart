import 'package:flutter/material.dart';
import 'package:homekeeper/forms/taskform.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/task.dart';
import 'package:homekeeper/repo/task/taskstore.dart';


class TaskListPage extends StatefulWidget {
  final TaskStore service;

  TaskListPage({this.service});

  @override
  TaskListPageState createState() {
    return new TaskListPageState();
  }
}

class TaskListPageState extends State<TaskListPage> {

  final List<Task> tasks = <Task>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final   _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     body:  buildBody(),
     floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute( 
              builder: (context) => TaskForm(
                onSubmit: (task) {
                  setState(() {
                    widget.service.createTask(task);                                      
                  });
                }
              )
            )
          );
        },
        tooltip: 'Add a New Task',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder<List<Task>>(
      stream:  widget.service.getTasks(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) 
          return LinearProgressIndicator();
        
        return buildTaskList(context, snapshot.data);
      },
    );
  }

  Widget buildTaskList(BuildContext context, List<Task> snapshot) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: snapshot.map((data) => buildTaskRow(context, data)).toList()
    );
  }

  Widget buildTaskRow(BuildContext context, Task task) {
    return ListTile(
      leading: _iconForCategory(task.category),
      title: Text(
        task.title,
        style: _biggerFont,
      ),
      subtitle: buildEventSubtitle(task),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute( 
            builder: (context) => TaskForm(
              task: task,
              onSubmit: (task) {
                setState(() {
                  widget.service.updateTask(task);
                });
              }
            )
          )
        );
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Event reference: ${task.reference.documentID}'))
        );
      },
    );
  }

  Widget buildEventSubtitle(Task task) {
    return Text('Due to start in ${task.startDate.difference(DateTime.now()).inDays} days.'
    );
  }

  Icon _iconForCategory(String category) {
    for(TemplateCategory cat in TemplateCategory.templateCategories) 
      if(cat.name == category) 
        return cat.icon;
    return null;
  }
}
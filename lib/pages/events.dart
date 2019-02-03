import 'package:flutter/material.dart';
import 'package:homekeeper/forms/eventform.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';


class EventListPage extends StatefulWidget {
  final EventStore service;

  EventListPage({this.service});

  @override
  EventListPageState createState() {
    return new EventListPageState();
  }
}

class EventListPageState extends State<EventListPage> {

  final List<Event> tasks = <Event>[];
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
              builder: (context) => EventForm(
                onSubmit: (task) {
                  setState(() {
                    widget.service.createEvent(task);
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
    return StreamBuilder<List<Event>>(
      stream:  widget.service.getEvents(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) 
          return LinearProgressIndicator();
        
        return buildTaskList(context, snapshot.data);
      },
    );
  }

  Widget buildTaskList(BuildContext context, List<Event> snapshot) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: snapshot.map((data) => buildTaskRow(context, data)).toList()
    );
  }

  Widget buildTaskRow(BuildContext context, Event task) {
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
            builder: (context) => EventForm(
              event: task,
              onSubmit: (task) {
                setState(() {
                  widget.service.updateEvent(task);
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

  Widget buildEventSubtitle(Event task) {
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
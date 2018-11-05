import 'package:flutter/material.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/forms/eventform.dart';


class EventListPage extends StatefulWidget {
  @override
  EventListPageState createState() {
    return new EventListPageState();
  }
}

class EventListPageState extends State<EventListPage> {

  final List<Event> events = <Event>[];
  final Injector injector = Injector.getInjector();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  final   _scaffoldKey = GlobalKey<ScaffoldState>();

  EventStore service;

  @override
  void initState() {
    super.initState();
    service = injector.get<EventStore>();
    setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
       title: new Text('Event List'),
      ),
     body:  buildBody(),
     floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute( builder: (context) => EventForm())
          );
        },
        tooltip: 'Add New Event',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder<List<Event>>(
      stream: service.getEvents(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) 
          return LinearProgressIndicator();
        
        return buildEventList(context, snapshot.data);
      },
    );
  }

  Widget buildEventList(BuildContext context, List<Event> snapshot) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: snapshot.map((data) => buildEventRow(context, data)).toList()
    );
  }

  Widget buildEventRow(BuildContext context, Event event) {
    return ListTile(
      leading: _iconForCategory(event.category),
      title: Text(
        event.title,
        style: _biggerFont,
      ),
      subtitle: buildEventSubtitle(event), 
      onTap: () {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Event reference: ${event.reference.documentID}'))
        );
      },
    );
  }

  Widget buildEventSubtitle(Event event) {
    return Text('${event.occurenceDate.difference(DateTime.now()).inDays} days till next occurence.'
    );
  }

  Icon _iconForCategory(String category) {
    EventCategory.eventCategories.forEach((cat) {
      if(cat.name == category) 
        return cat.icon;
    });
    return null;
  }
}
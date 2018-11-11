import 'package:flutter/material.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/forms/eventform.dart';
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

  final List<Event> events = <Event>[];
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
      appBar: new AppBar(
       title: new Text('Event List'),
      ),
     body:  buildBody(),
     floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute( 
              builder: (context) => EventForm(
                event: new Event(isReoccurence: false),
                onSubmit: (event) {
                  setState(() {
                    widget.service.createEvent(event);                                      
                  });
                }
              )
            )
          );
        },
        tooltip: 'Add New Event',
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
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute( 
            builder: (context) => EventForm(
              event: event,
              onSubmit: (event) {
                setState(() {
                  widget.service.updateEvent(event);
                });
              }
            )
          )
        );
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
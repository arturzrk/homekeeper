import 'package:flutter/material.dart';
import 'package:homekeeper/forms/eventform.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:homekeeper/utils/history_describer.dart';
import 'package:homekeeper/widgets/event_row.dart';

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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: buildBody(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EventForm(onSubmit: (task) {
                        setState(() {
                          widget.service.createEvent(task);
                        });
                      })));
        },
        tooltip: 'Add a New Task',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder<List<Event>>(
      stream: widget.service.getEvents(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return buildEventList(context, snapshot.data);
      },
    );
  }

  Widget buildEventList(BuildContext context, List<Event> snapshot) {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: snapshot
            .map((data) => EventRow(
                  event: data,
                  onTap: (event) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventForm(
                                event: event,
                                onSubmit: (task) {
                                  setState(() {
                                    widget.service.updateEvent(task);
                                  });
                                })));
                  },
                ))
            .toList());
  }

  String buildEventSubtitle(Event task) {
    return "Occured ${HistoryDescriber.describe(task.startDate)}";
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/bloc/events_bloc.dart';
import 'package:homekeeper/forms/eventform.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/pages/eventbuttons.dart';
import 'package:homekeeper/pages/eventtemplates.dart';
import 'package:homekeeper/pages/events.dart';
import 'package:homekeeper/repo/event/eventstore.dart';
import 'package:homekeeper/repo/template/templatestore.dart';

class NavigationTabBody {
  Widget child;
  String title;

  NavigationTabBody({this.child, this.title});
}

class NavigationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigationPageState();
  }
}

class NavigationPageState extends State<NavigationPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  TemplateStore _templateService;
  EventStore _eventService;

  @override
  void initState() {
    super.initState();
    var injector = Injector.getInjector();
    _templateService = injector.get<TemplateStore>();
    _eventService = injector.get<EventStore>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<NavigationTabBody> _navigationBodies = <NavigationTabBody>[
      NavigationTabBody(
          title: 'Tap to trigger the Event',
          child: EventButtons(
            templateService: _templateService,
            onEventTriggered: eventTriggered,
          )),
      NavigationTabBody(
          title: 'Event Templates',
          child: TemplateListPage(service: _templateService)),
      NavigationTabBody(
        title: 'Event History',
        child: EventListPage(service: _eventService),
      ),
    ];

    final BottomNavigationBar botNavBar = BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              title: Text('Templates'),
              icon: Icon(Icons.collections),
              activeIcon: Icon(Icons.collections),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
            title: Text('Events'),
            icon: Icon(Icons.list),
            activeIcon: Icon(Icons.list),
            backgroundColor: Colors.blue,
          ),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        });

    return Scaffold(
        appBar: AppBar(title: Text(_navigationBodies[_currentIndex].title)),
        body: Center(child: _navigationBodies[_currentIndex].child),
        bottomNavigationBar: botNavBar);
  }

  void eventTriggered(Template template) async {
    Event _event = EventsBloc.fromTemplate(template);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return EventForm(event: _event, onSubmit: _eventSubmitted,);
            },
            fullscreenDialog: true));
  }

  void _eventSubmitted(Event event) {
    _eventService.createEvent(event);
  }
}

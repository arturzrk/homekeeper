import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:homekeeper/pages/eventtemplates.dart';
import 'package:homekeeper/pages/tasks.dart';
import 'package:homekeeper/repo/task/taskstore.dart';
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

class NavigationPageState extends State<NavigationPage> with TickerProviderStateMixin {

  int _currentIndex = 0;
  TemplateStore _templateService;
  TaskStore _taskService;

  @override
  void initState() {
      super.initState();
      var injector = Injector.getInjector();
      _templateService = injector.get<TemplateStore>();
      _taskService = injector.get<TaskStore>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final List<NavigationTabBody> _navigationBodies = <NavigationTabBody>
      [
        NavigationTabBody( 
          title: 'Tasks List',
          child: TaskListPage(
            service: _taskService
          )
        ),
        NavigationTabBody(
          title: 'Event Templates',
          child: TemplateListPage(
            service: _templateService
          )
        )
      ];

    final BottomNavigationBar botNavBar = BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          title: Text('Home'),
          icon: Icon(Icons.home),
          activeIcon: Icon(Icons.home),
          backgroundColor: Colors.blue
        ),
        BottomNavigationBarItem(
          title: Text('Library'),
          icon: Icon(Icons.library_books),
          activeIcon: Icon(Icons.library_books),
          backgroundColor: Colors.blue
        )
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
        _currentIndex = index;
        });
      }
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_navigationBodies[_currentIndex].title)
      ),
      body: Center(
        child: _navigationBodies[_currentIndex].child
      ),
      bottomNavigationBar: botNavBar
    );
  }

}
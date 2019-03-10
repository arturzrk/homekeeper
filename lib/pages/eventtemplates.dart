import 'package:flutter/material.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/forms/templateform.dart';
import 'package:homekeeper/repo/template/templatestore.dart';

class TemplateListPage extends StatefulWidget {
  final TemplateStore service;

  TemplateListPage({this.service});

  @override
  TemplateListPageState createState() {
    return new TemplateListPageState();
  }
}

class TemplateListPageState extends State<TemplateListPage> {
  final List<Template> templates = <Template>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
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
                  builder: (context) => EventForm(onSubmit: (event) {
                        setState(() {
                          widget.service.createTemplate(event);
                        });
                      })));
        },
        tooltip: 'Add New Event',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder<List<Template>>(
      stream: widget.service.getTemplates(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return buildEventList(context, snapshot.data);
      },
    );
  }

  Widget buildEventList(BuildContext context, List<Template> snapshot) {
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children:
            snapshot.map((data) => buildEventRow(context, data)).toList());
  }

  Widget buildEventRow(BuildContext context, Template event) {
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
                    template: event,
                    onSubmit: (event) {
                      setState(() {
                        widget.service.updateTemplate(event);
                      });
                    })));
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('Event reference: ${event.reference != null ? event.reference : "Empty Reference"}')));
      },
    );
  }

  Widget buildEventSubtitle(Template event) {
    return Text(
        '${event.occurenceDate.difference(DateTime.now()).inDays} days till next occurence.');
  }

  Icon _iconForCategory(String category) {
    for (TemplateCategory cat in TemplateCategory.templateCategories)
      if (cat.name == category) return Icon(cat.icon, size: 20.0);
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/repo/template/templatestore.dart';

class EventButtons extends StatelessWidget {
  final TemplateStore templateService;
  final void Function(Template event) onEventTriggered;

  EventButtons({@required this.templateService, this.onEventTriggered})
      : assert(templateService != null);

  Widget build(BuildContext context) {
    return StreamBuilder<List<Template>>(
      stream: templateService.getTemplates(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: eventButtonList(snapshot.data),
          ),
        );
      },
    );
  }

  List<FlatButton> eventButtonList(List<Template> templates) {
    return templates.map((template) {
      return FlatButton(
        key: Key(template.title),
        child: Text(template.title),
        shape: StadiumBorder(side: BorderSide(width: 2.0, color: Colors.blue)),
        onPressed: () {
          if (onEventTriggered != null) onEventTriggered(template);
        },
      );
    }).toList();
  }
}

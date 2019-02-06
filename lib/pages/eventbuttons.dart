import 'package:flutter/material.dart';
import 'package:homekeeper/model/template.dart';
import 'package:homekeeper/repo/template/templatestore.dart';

class EventButtons extends StatefulWidget {
  final TemplateStore templateService;
  final void Function(Template event) onEventTriggered;

  EventButtons({@required this.templateService, this.onEventTriggered})
      : assert(templateService != null);

  @override
  State<EventButtons> createState() {
    return EventButtonsState();
  }
}

class EventButtonsState extends State<EventButtons> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<Template>>(
      stream: widget.templateService.getTemplates(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return ListView(
          padding: EdgeInsets.all(16.0),
          children: snapshot.data.map((template) {
            return FlatButton(
              key: Key(template.title),
              child: Text(template.title),
              shape: StadiumBorder(side: BorderSide(width: 2.0,color: Colors.blue)) ,
              onPressed: () {
                if(widget.onEventTriggered != null)
                  widget.onEventTriggered(template);
              },
            );
          }).toList(),
        );
      },
    );
  }
}

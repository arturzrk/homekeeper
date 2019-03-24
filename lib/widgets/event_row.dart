import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:homekeeper/model/category.dart';
import 'package:homekeeper/model/event.dart';
import 'package:homekeeper/utils/history_describer.dart';

class EventRow extends StatelessWidget {
  final Event event;
  final ValueChanged<Event> onTap;

  EventRow({this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _rowHeight = 80.0;
    final TextStyle _listItemTitleFont = Theme.of(context).textTheme.title;
    final _subtitleListItemFont =
        const TextStyle(fontStyle: FontStyle.normal, fontSize: 16);
    return InkWell(
      onTap: () => onTap(event),
      child: Container(
        height: _rowHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _iconForCategory(event.category),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        event.title,
                        style: _listItemTitleFont,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      buildEventSubtitle(event),
                      style: _subtitleListItemFont,
                    )
                  ]),
            ),
            Align(
                child: Icon(
                  Icons.chevron_right,
                  size: 40.0,
                ),
                alignment: Alignment.centerRight)
          ],
        ),
      ),
    );
  }

  String buildEventSubtitle(Event task) {
    return "Occured ${HistoryDescriber.describe(task.startDate)}";
  }

  Widget _iconForCategory(String category) {
    for (TemplateCategory cat in TemplateCategory.templateCategories) {
      if (cat.name == category)
        return cat.imageLocation != null
            ? Image.asset(
                cat.imageLocation,
                width: 60,
              )
            : Icon(
                cat.icon,
                size: 20.0,
              );
    }
    return null;
  }
}

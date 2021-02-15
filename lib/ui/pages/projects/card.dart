import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'file:///C:/Projects/Flutter/localize/lib/ui/components/project_chars.dart';
import 'package:localize/ui/utils.dart';

class UiProjectCard extends StatelessWidget {
  final ModelProject project;

  const UiProjectCard({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);
    const double _padding = UiServiceSizing.padding;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: _padding * _scale, vertical: _padding * _scale * 0.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UiProjectIconChars(iChars: project.iChars, scale: _scale),
          SizedBox(width: _padding * _scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${project.name}', textScaleFactor: _scale, style: Theme.of(context).textTheme.headline5),
              Text('author: ${project.author}', textScaleFactor: _scale, style: Theme.of(context).textTheme.caption),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('created', style: Theme.of(context).textTheme.caption, textScaleFactor: _scale),
              Text(project.created.getDate, style: Theme.of(context).textTheme.caption, textScaleFactor: _scale),
            ],
          ),
        ],
      ),
    );
  }
}

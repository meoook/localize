import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'package:localize/ui/pages/projects/icon_chars.dart';
import 'package:localize/ui/utils.dart';

class UiProjectCard extends StatelessWidget {
  final ModelProject project;

  const UiProjectCard({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * _scale, vertical: 6 * _scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UiProjectIconChars(iChars: project.iChars, scale: _scale),
          SizedBox(width: 12.0 * _scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(project.name, textScaleFactor: _scale, style: Theme.of(context).textTheme.headline5),
              Text('author: ${project.author}', textScaleFactor: _scale, style: Theme.of(context).textTheme.subtitle2),
            ],
          ),
          Expanded(child: const SizedBox()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('created', style: Theme.of(context).textTheme.subtitle1, textScaleFactor: _scale),
              Text(project.created.getDate, style: Theme.of(context).textTheme.subtitle2, textScaleFactor: _scale),
            ],
          ),
        ],
      ),
    );
  }
}

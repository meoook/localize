import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';

import 'buttons.dart';

class UiAddProjectFinal extends StatelessWidget {
  final ModelNewProject project;
  final Function prev;
  final Function next;

  const UiAddProjectFinal({Key key, @required this.project, @required this.prev, @required this.next})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: Text('Name ${project.name}')),
        Container(child: Text('Chars ${project.iChars}')),
        Container(child: Text('Lang ${project.langOriginal}')),
        Container(child: Text('Lang2 ${project.translateTo}')),
        UiAddProjectButtons(step: 3, prev: prev, next: next),
      ],
    );
  }
}

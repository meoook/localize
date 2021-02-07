import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';

class UiProjectChange extends StatelessWidget {
  final ModelProject project;

  const UiProjectChange({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Project change'));
  }
}

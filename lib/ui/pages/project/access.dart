import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';

class UiProjectAccess extends StatelessWidget {
  final ModelProject project;

  const UiProjectAccess({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Project access'));
  }
}

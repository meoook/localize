import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigation.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/ui/pages/projects/card.dart';

class UiPageProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _projects = context.watch<NotifierProjects>().list;
    final _navigator = context.watch<NotifierNavigator>();
    if (_projects == null) {
      return Container(
        child: Text('No games'),
      );
    } else {
      return ListView.separated(
        shrinkWrap: true,
        itemCount: _projects.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, index) => FlatButton(
          padding: EdgeInsets.all(0.0),
          child: UiProjectCard(project: _projects[index]),
          onPressed: () => _navigator.navDeep({'id': _projects[index].id}),
        ),
      );
    }
  }
}

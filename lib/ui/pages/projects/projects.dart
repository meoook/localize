import 'package:flutter/material.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/ui/pages/projects/card.dart';

class UiPageProjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _projects = context.watch<NotifierProjects>().list;
    final _navigator = context.watch<ProviderNavigator>();

    if (_projects == null) return Container(child: Text('No games'));
    return ListView.separated(
      itemCount: _projects.length,
      separatorBuilder: (_, __) => Divider(height: 1.0, thickness: 1.0),
      itemBuilder: (_, index) => TextButton(
        // padding: const EdgeInsets.all(0.0),
        child: UiProjectCard(project: _projects[index]),
        onPressed: () {
          _navigator.project = _projects[index];
          _navigator.navigate();
        },
      ),
    );
  }
}

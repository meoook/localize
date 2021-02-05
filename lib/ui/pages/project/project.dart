import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'package:localize/notifier/navigation.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/services/permissions.dart';
import 'package:localize/ui/pages/project/access.dart';
import 'package:localize/ui/pages/project/explorer/explorer.dart';
import 'package:localize/ui/pages/project/options.dart';
import 'package:localize/ui/pages/project/tabbar.dart';
import 'package:localize/ui/pages/projects/card.dart';
import 'package:provider/provider.dart';

class UiPageProject extends StatefulWidget {
  @override
  _UiPageProjectState createState() => _UiPageProjectState();
}

class _UiPageProjectState extends State<UiPageProject> {
  AccessPage _selected;

  void _change(AccessPage page) => setState(() => _selected = page);

  @override
  Widget build(BuildContext context) {
    var _nav = context.read<NotifierNavigator>();
    ModelProject _project = context.read<NotifierProjects>().byID(_nav.params['id']);
    List<AccessPage> _access = _project.permissions.access;
    _selected = _selected ?? _access.first;
    return Container(
      child: Column(
        children: [
          UiProjectCard(project: _project),
          const Divider(),
          if (_access.length > 1) UiProjectTabBar(tabs: _access, selected: _selected, callback: _change),
          if (_access.length > 1) const Divider(),
          if (_selected == AccessPage.FILES) UiProjectExplorer(project: _project),
          if (_selected == AccessPage.ACCESS) UiProjectAccess(project: _project),
          if (_selected == AccessPage.CHANGE) UiProjectChange(project: _project),
        ],
      ),
    );
  }
}

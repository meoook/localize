import 'package:flutter/material.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:provider/provider.dart';

import 'package:localize/model/project.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/notifier/runner.dart';
import 'package:localize/services/permissions.dart';
import 'package:localize/ui/pages/404.dart';
import 'package:localize/ui/pages/project/access.dart';
import 'package:localize/ui/pages/project/explorer/explorer.dart';
import 'package:localize/ui/pages/project/options.dart';
import 'package:localize/ui/pages/project/tabbar.dart';
import 'package:localize/ui/pages/projects/card.dart';

class UiPageProject extends StatefulWidget {
  @override
  _UiPageProjectState createState() => _UiPageProjectState();
}

class _UiPageProjectState extends State<UiPageProject> {
  AccessPage _selected;

  void _change(AccessPage page) => setState(() => _selected = page);

  Widget _getSelected(BuildContext context, ModelProject project) {
    // if (_selected == AccessPage.FILES) UiProjectFileList(project: project),
    if (_selected == AccessPage.MANAGE) {
      final _http = context.read<NotifierRunner>().http;
      return ChangeNotifierProxyProvider<ProviderNavigator, NotifierFolders>(
          create: (_) => NotifierFolders(_http),
          update: (_, _nav, _folders) => _folders..project(_nav?.project),
          child: UiProjectExplorer(project: project));
    }
    if (_selected == AccessPage.ACCESS) return UiProjectAccess(project: project);
    if (_selected == AccessPage.CHANGE) return UiProjectChange(project: project);
    return UiPageUnknown(text: 'Access error');
  }

  @override
  Widget build(BuildContext context) {
    var _nav = context.read<ProviderNavigator>();
    ModelProject _project = context.read<NotifierProjects>().byID(_nav.project);
    List<AccessPage> _access = _project.permissions.access;
    this._selected ??= _access.first;
    return Container(
      child: Column(
        children: [
          UiProjectCard(project: _project),
          const Divider(height: 1.0, thickness: 1.0),
          if (_access.length > 1) UiProjectTabBar(tabs: _access, selected: this._selected, callback: _change),
          if (_access.length > 1) const Divider(height: 1.0),
          Expanded(child: this._getSelected(context, _project)),
        ],
      ),
    );
  }
}

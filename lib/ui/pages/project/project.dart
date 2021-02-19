import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/files.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/services/access.dart';

import '../404.dart';
import '../projects/card.dart';
import 'explorer/explorer.dart';
import 'explorer/file_list.dart';
import 'access.dart';
import 'options.dart';
import 'tabbar.dart';

class UiPageProject extends StatefulWidget {
  @override
  _UiPageProjectState createState() => _UiPageProjectState();
}

class _UiPageProjectState extends State<UiPageProject> {
  AccessPage _selected;

  Widget _getSelected(ProviderNavigator navigator) {
    if (_selected == AccessPage.MANAGE && navigator.project.permissions.canManage) return UiProjectExplorer();
    if (_selected == AccessPage.MANAGE && navigator.project.permissions.isTranslator) return UiFileList();
    if (_selected == AccessPage.ACCESS) return UiProjectAccess();
    if (_selected == AccessPage.CHANGE) return UiProjectChange();
    return UiPageUnknown(text: 'Access error');
  }

  void _change(AccessPage page) => setState(() => _selected = page);

  @override
  Widget build(BuildContext context) {
    final ProviderNavigator _navigator = context.read<ProviderNavigator>();
    final List<AccessPage> _access = _navigator.project.permissions.access;

    this._selected ??= _access.first;

    return Container(
      child: Column(
        children: [
          UiProjectCard(project: _navigator.project),
          const Divider(height: 1.0, thickness: 1.0),
          if (_access.length > 1) UiProjectTabBar(tabs: _access, selected: this._selected, change: _change),
          if (_access.length > 1) const Divider(height: 1.0),
          MultiProvider(
            providers: [
              ChangeNotifierProvider<NotifierFolders>(
                  create: (_) => NotifierFolders(_navigator.http, _navigator.project.id)),
              ChangeNotifierProvider<NotifierAccess>(
                  create: (_) => NotifierAccess(_navigator.http, _navigator.project.id)),
              ChangeNotifierProvider<NotifierFiles>(
                  create: (_) => NotifierFiles(_navigator.http, _navigator.project.id)),
            ],
            child: Expanded(
              child: AnimatedSwitcher(duration: Duration(milliseconds: 300), child: this._getSelected(_navigator)),
            ),
          ),
        ],
      ),
    );
  }
}

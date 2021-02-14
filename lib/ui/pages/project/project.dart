import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/navigator.dart';
import 'package:localize/services/permissions.dart';

import 'package:localize/ui/pages/projects/card.dart';
import 'package:localize/ui/pages/404.dart';
import 'access.dart';
import 'manage/manage.dart';
import 'options.dart';
import 'tabbar.dart';

class UiPageProject extends StatefulWidget {
  @override
  _UiPageProjectState createState() => _UiPageProjectState();
}

class _UiPageProjectState extends State<UiPageProject> {
  AccessPage _selected;

  Widget _getSelected() {
    if (_selected == AccessPage.MANAGE) return UiProjectManage();
    if (_selected == AccessPage.ACCESS) return UiProjectAccess();
    if (_selected == AccessPage.CHANGE) return UiProjectChange();
    return UiPageUnknown(text: 'Access error');
  }

  @override
  Widget build(BuildContext context) {
    var _nav = context.read<ProviderNavigator>();
    List<AccessPage> _access = _nav.project.permissions.access;
    this._selected ??= _access.first;

    void _change(AccessPage page) => setState(() => _selected = page);

    return Container(
      child: Column(
        children: [
          UiProjectCard(project: _nav.project),
          const Divider(height: 1.0, thickness: 1.0),
          if (_access.length > 1) UiProjectTabBar(tabs: _access, selected: this._selected, change: _change),
          if (_access.length > 1) const Divider(height: 1.0),
          Expanded(child: this._getSelected()),
        ],
      ),
    );
  }
}

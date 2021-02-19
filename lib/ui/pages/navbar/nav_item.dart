import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';

class UiNavBarItem extends StatelessWidget {
  final NavChoice choice;

  const UiNavBarItem({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModelNavChoice _model = ModelNavChoice(choice);
    final ProviderNavigator _navigator = context.watch<ProviderNavigator>();
    const double _padding = UiServiceSizing.padding;
    return TextButton(
      onPressed: () {
        if (_model.nav == NavChoice.PROJECTS) _navigator.project = null;
        _navigator.navigate(_model.nav);
      },
      style: _model.nav == _navigator.nav ? TextButton.styleFrom(primary: Theme.of(context).accentColor) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _padding * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_model.icon, size: _padding * 4),
            Text(_model.name),
          ],
        ),
      ),
    );
  }
}

class ModelNavChoice {
  final NavChoice nav;
  String _name;
  IconData _icon;

  String get name => _name;
  IconData get icon => _icon;

  ModelNavChoice(this.nav) {
    switch (this.nav) {
      case NavChoice.PROJECTS:
        _name = 'Games';
        _icon = Icons.apartment;
        break;
      case NavChoice.ADD:
        _name = 'Add';
        _icon = Icons.add_circle_outline;
        break;
      case NavChoice.FILE:
        _name = 'Last file';
        _icon = Icons.insert_drive_file_outlined;
        break;
      case NavChoice.OPTIONS:
        _name = 'Options';
        _icon = Icons.settings;
        break;
      case NavChoice.LOGOUT:
        _name = 'Sing out';
        _icon = Icons.logout;
        break;
    }
  }
}

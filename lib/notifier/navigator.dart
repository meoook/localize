import 'package:flutter/material.dart';
import 'package:localize/services/logger.dart';

enum NavChoice { PROJECTS, ADD, FILE, OPTIONS, LOGOUT }

extension StringNavExtension on NavChoice {
  String get text => this.toString().split('.').last;
}

class ProviderNavigator {
  Function _navigate;
  NavChoice nav = NavChoice.PROJECTS;
  int file;
  int folder;
  String project;

  set navigation(Function navigate) {
    logger.d('Initialize navigation...');
    _navigate = navigate;
  }

  void navigate([NavChoice choice]) {
    if (choice != null) nav = choice;
    if (_navigate != null) _navigate(nav);
    if (_navigate != null) logger.d('Navigate to ${choice.text}');
  }
}

class ModelNavChoice {
  final NavChoice nav;
  String _name;
  IconData _icon;
  bool _bottom = false;

  String get name => _name;
  bool get bottom => _bottom;
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
        _bottom = true;
        break;
      case NavChoice.LOGOUT:
        _name = 'Sing out';
        _icon = Icons.logout;
        _bottom = true;
        break;
    }
  }
}

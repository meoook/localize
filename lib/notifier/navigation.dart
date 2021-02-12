// import 'package:flutter/material.dart';
// import 'package:localize/services/logger.dart';
//
// enum NavChoice { PROJECTS, ADD, FILE, OPTIONS, LOGOUT }
//
// extension StringNavExtension on NavChoice {
//   String get text => this.toString().split('.').last;
// }
//
// class NotifierNavigator with ChangeNotifier {
//   final List<ModelNavChoice> _choices = NavChoice.values.map((e) => ModelNavChoice(e)).toList();
//   List<ModelNavChoice> get choices => _choices;
//   NavChoice _current;
//   NavChoice get current => _current;
//   Map<String, dynamic> _params;
//   Map<String, dynamic> get params => _params ?? {};
//
//   NotifierNavigator() {
//     _current = _choices.first.nav;
//   }
//   void navigate(NavChoice choice) {
//     if (choice == current && _params == null) return;
//     logger.i('Navigate to ${choice.text}');
//     _current = choice;
//     _params = null;
//     notifyListeners();
//   }
//
//   void navDeep(Map<String, dynamic> params, {NavChoice choice}) {
//     if (choice != null) {
//       logger.i('Deep navigation change from ${_current.text} to $choice with $params');
//       _current = choice;
//     } else {
//       logger.i('Deep navigation in ${_current.text} with $params');
//     }
//     _params = params;
//     notifyListeners();
//   }
// }
//
// class ModelNavChoice {
//   final NavChoice nav;
//   String _name;
//   IconData _icon;
//   bool _bottom = false;
//
//   String get name => _name;
//   bool get bottom => _bottom;
//   IconData get icon => _icon;
//
//   ModelNavChoice(this.nav) {
//     switch (this.nav) {
//       case NavChoice.PROJECTS:
//         _name = 'Games';
//         _icon = Icons.apartment;
//         break;
//       case NavChoice.ADD:
//         _name = 'Add';
//         _icon = Icons.add_circle_outline;
//         break;
//       case NavChoice.FILE:
//         _name = 'Last file';
//         _icon = Icons.insert_drive_file_outlined;
//         break;
//       case NavChoice.OPTIONS:
//         _name = 'Options';
//         _icon = Icons.settings;
//         _bottom = true;
//         break;
//       case NavChoice.LOGOUT:
//         _name = 'Sing out';
//         _icon = Icons.logout;
//         _bottom = true;
//         break;
//     }
//   }
//
//   // factory ModelNavChoice.projects() => ModelNavChoice(NavChoice.PROJECTS);
//   // factory ModelNavChoice.add() => ModelNavChoice(NavChoice.ADD);
//   // factory ModelNavChoice.file() => ModelNavChoice(NavChoice.FILE);
//   // factory ModelNavChoice.options() => ModelNavChoice(NavChoice.OPTIONS);
//   // factory ModelNavChoice.logoff() => ModelNavChoice(NavChoice.LOGOUT);
//
//   // @override
//   // String toString() => "Page $_name";
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/notifier/navigation.dart';
import 'package:localize/notifier/runner.dart';
import 'package:localize/ui/utils.dart';
import 'package:localize/ui/pages/navbar/drawer.dart';
import 'package:localize/ui/pages/navbar/navbar.dart';
import 'package:localize/ui/pages/file/file.dart';
import 'package:localize/ui/pages/loading.dart';
import 'package:localize/ui/pages/options/options.dart';
import 'package:localize/ui/pages/project/project.dart';
import 'package:localize/ui/pages/404.dart';
import 'package:localize/ui/pages/add/add.dart';
import 'package:localize/ui/pages/projects/projects.dart';

class UiPageNavWrapper extends StatelessWidget {
  Widget _getPage(BuildContext context, NotifierNavigator navigator) {
    switch (navigator.current) {
      case NavChoice.PROJECTS:
        if (navigator.params != null && navigator.params.containsKey('id')) return UiPageProject();
        return UiPageProjectsList();
      case NavChoice.ADD:
        return UiPageAddProject();
      case NavChoice.FILE:
        return UiPageFile();
      case NavChoice.OPTIONS:
        return UiPageOptions();
      case NavChoice.LOGOUT:
        context.select<NotifierRunner, Function>((value) => value.logout)();
        return UiPageLoading();
      default:
        return UiPageUnknown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _root = context.read<NotifierRunner>();
    final width = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NotifierNavigator>(create: (_) => NotifierNavigator()),
        ChangeNotifierProvider<NotifierProjects>(create: (_) => NotifierProjects.init(_root.http)..start()),
      ],
      child: Scaffold(
        // backgroundColor: Theme.of(context).backgroundColor,
        drawer: UiServiceSizing.scale(width) <= 1 ? UiMenuDrawer(user: _root.user) : null,
        body: Consumer<NotifierNavigator>(builder: (context, navigator, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (UiServiceSizing.scale(width) > 1) UiNavBar(user: _root.user),
              Expanded(child: this._getPage(context, navigator))
            ],
          );
        }),
      ),
    );
  }
}

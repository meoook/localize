import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/navigator.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/notifier/system.dart';

import '404.dart';
import 'add/add.dart';
import 'loading.dart';
import 'navbar/navbar.dart';
import 'options/options.dart';
import 'file/file.dart';
import 'projects/projects.dart';
import 'project/project.dart';

class UiPageNavWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _root = context.read<NotifierSystem>();

    return MultiProvider(
      providers: [
        Provider<ProviderNavigator>(create: (_) => ProviderNavigator(_root.http)),
        ChangeNotifierProvider<NotifierProjects>(create: (_) => NotifierProjects(_root.http)),
      ],
      child: Scaffold(
        body: Consumer<ProviderNavigator>(builder: (context, navigator, child) {
          return UiPageNavigator(navigator: navigator);
        }),
      ),
    );
  }
}

class UiPageNavigator extends StatefulWidget {
  final ProviderNavigator navigator;

  const UiPageNavigator({Key key, @required this.navigator}) : super(key: key);
  @override
  _UiPageNavigatorState createState() => _UiPageNavigatorState();
}

class _UiPageNavigatorState extends State<UiPageNavigator> {
  NavChoice _selected;

  @override
  initState() {
    super.initState();
    widget.navigator.navigation = navigate;
    _selected = widget.navigator.nav;
  }

  void navigate(NavChoice choice) {
    setState(() {
      _selected = choice;
    });
  }

  Widget _getPage() {
    switch (_selected) {
      case NavChoice.PROJECTS:
        if (widget.navigator.project != null) return UiPageProject();
        return UiPageProjectList();
      case NavChoice.ADD:
        return UiPageProjectAdd();
      case NavChoice.FILE:
        return UiPageFile();
      case NavChoice.OPTIONS:
        return UiPageOptions();
      case NavChoice.LOGOUT:
        context.select<NotifierSystem, Function>((value) => value.logout)();
        return UiPageLoading();
      default:
        return UiPageUnknown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UiNavBar(),
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            // transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
            // transitionBuilder: (Widget child, Animation<double> animation) {
            //   final offsetAnimation = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0)).animate(animation);
            //   return SlideTransition(position: offsetAnimation, child: child);
            // },
            child: this._getPage(),
          ),
        ),
      ],
    );
  }
}

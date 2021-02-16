import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/navigator.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/model/project.dart';

import 'final.dart';
import 'languages.dart';
import 'naming.dart';
import 'progress.dart';

class UiPageProjectAdd extends StatefulWidget {
  @override
  _UiPageProjectAddState createState() => _UiPageProjectAddState();
}

class _UiPageProjectAddState extends State<UiPageProjectAdd> {
  ModelNewProject _project = ModelNewProject();
  int _step = 1;

  void _prev() => (_step > 1) ? setState(() => _step -= 1) : null;

  void _next() {
    if ([1, 2].contains(_step))
      setState(() => _step += 1);
    else
      _finish();
  }

  void _finish() async {
    final ProviderNavigator _navigator = this.context.read<ProviderNavigator>();

    _navigator.project = null;
    _navigator.navigate(NavChoice.PROJECTS);

    final ModelProject _new = await this.context.read<NotifierProjects>().create(_project);
    if (_new == null)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating game ${_project.name}')),
      );

    _navigator.project = _new;
    _navigator.navigate(NavChoice.PROJECTS);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 50.0),
      child: Container(
        width: 600,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, offset: Offset(2.0, 1.0))],
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            UiAddProjectProgress(step: _step),
            if (_step == 1) UiAddProjectNaming(project: _project, prev: _prev, next: _next),
            if (_step == 2) UiAddProjectLanguages(project: _project, prev: _prev, next: _next),
            if (_step == 3) UiAddProjectFinal(project: _project, prev: _prev, next: _next),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/project.dart';
import 'package:localize/model/project.dart';

import 'buttons.dart';
import 'final.dart';
import 'languages.dart';
import 'naming.dart';
import 'progress.dart';

class UiPageProjectAdd extends StatefulWidget {
  @override
  _UiPageProjectAddState createState() => _UiPageProjectAddState();
}

class _UiPageProjectAddState extends State<UiPageProjectAdd> {
  int _step = 1;

  void _change(int step) => (_step != step) ? setState(() => _step = step) : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 50.0),
      child: Container(
        width: 600,
        constraints: BoxConstraints(maxHeight: 650),
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, offset: Offset(2.0, 1.0))],
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: Provider<ProviderProject>(
          create: (_) => ProviderProject(ModelProjectBase()),
          child: Consumer<ProviderProject>(builder: (context, project, child) {
            Widget _getStep() {
              if (_step == 3) return UiAddProjectFinal(project: project);
              if (_step == 2) return UiAddProjectLanguages(project: project);
              return UiAddProjectNaming(project: project);
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                UiAddProjectProgress(step: _step),
                Expanded(child: AnimatedSwitcher(duration: Duration(milliseconds: 300), child: _getStep())),
                UiAddProjectButtons(project: project, step: _step, change: _change),
              ],
            );
          }),
        ),
      ),
    );
  }
}

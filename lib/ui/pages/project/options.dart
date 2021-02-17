import 'package:flutter/material.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/pages/add/buttons.dart';
import 'package:localize/ui/pages/add/languages.dart';
import 'package:localize/ui/pages/add/naming.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/project.dart';
import 'package:localize/notifier/projects.dart';

class UiProjectChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ModelProject _project = context.read<ProviderNavigator>().project;
    ModelProjectBase _edit = ModelProjectBase.fromJson(_project.apiMap);
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
          create: (_) => ProviderProject(_edit),
          child: Consumer<ProviderProject>(builder: (context, project, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Edit game options', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 24.0),
                UiAddProjectNaming(project: project),
                UiAddProjectLanguages(project: project),
                ButtonBar(
                  children: [
                    UiAddProjectButton(
                        text: 'Save',
                        onPressed: () async {
                          String _msg = 'Error saving game ${_project.name}';
                          if (project.isOk) {
                            // final bool _success = await context.read<NotifierProjects>().update(_project.id, project);
                            await context.read<NotifierProjects>().update(_project.id, project);
                            // if (_success) _msg = 'Game ${_project.name} options successfully saved';
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_msg)));
                        }),
                  ],
                ),
                // UiAddProjectButtons(project: project, step: _step, change: _change),
              ],
            );
          }),
        ),
      ),
    );
  }
}

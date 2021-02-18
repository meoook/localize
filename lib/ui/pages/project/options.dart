import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/pages/add/buttons.dart';
import 'package:localize/ui/pages/add/languages.dart';
import 'package:localize/ui/pages/add/naming.dart';
import 'package:localize/ui/utils.dart';

class UiProjectChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProviderNavigator _navigator = context.read<ProviderNavigator>();
    const _padding = UiServiceSizing.padding;
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: _padding * 3),
      child: Container(
        width: 600,
        constraints: BoxConstraints(maxHeight: 650),
        padding: EdgeInsets.symmetric(horizontal: _padding * 3, vertical: _padding * 2),
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
                UiAddProjectNaming(project: project, name: _navigator.project.name),
                UiAddProjectLanguages(project: project),
                ButtonBar(
                  children: [
                    UiAddProjectButton(
                        text: 'Save',
                        onPressed: () async {
                          String _msg = 'Error saving game ${_navigator.project.name}';
                          if (project.isOk) {
                            // final bool _success = await context.read<NotifierProjects>().update(_project.id, project);
                            ModelProject _project =
                                await context.read<NotifierProjects>().update(_navigator.project.id, project);
                            if (_project != null) {
                              _msg = 'Game ${_navigator.project.name} options successfully saved';
                              _navigator.project = _project;
                              _navigator.navigate(NavChoice.PROJECTS);
                            }
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

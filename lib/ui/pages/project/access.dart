import 'package:flutter/material.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';

class UiProjectAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProviderNavigator _navigator = context.read<ProviderNavigator>();
    const double _padding = UiServiceSizing.padding;
    return Container(
      width: 600,
      constraints: BoxConstraints(maxHeight: 650),
      padding: EdgeInsets.symmetric(horizontal: _padding * 3, vertical: _padding * 2),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: _padding, offset: Offset(2.0, 1.0))],
        borderRadius: BorderRadius.circular(_padding * 2),
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: ChangeNotifierProvider<NotifierAccess>(
        create: (_) => NotifierAccess(_navigator.http, _navigator.project.id),
        child: Consumer<NotifierAccess>(builder: (context, project, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Edit game options', style: Theme.of(context).textTheme.headline4),
              // UiAddProjectButtons(project: project, step: _step, change: _change),
            ],
          );
        }),
      ),
    );
  }
}

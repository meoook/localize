import 'package:flutter/material.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';

class UiProjectAccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double _padding = UiServiceSizing.padding;
    ProviderNavigator _navigator = context.read<ProviderNavigator>();

    return Container(
      width: 600,
      constraints: BoxConstraints(maxHeight: 650),
      padding: EdgeInsets.symmetric(horizontal: _padding * 3, vertical: _padding * 2),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 8.0, offset: Offset(2.0, 1.0))],
        borderRadius: BorderRadius.circular(16.0),
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: ChangeNotifierProvider<NotifierAccess>(
        create: (_) => NotifierAccess(_edit),
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

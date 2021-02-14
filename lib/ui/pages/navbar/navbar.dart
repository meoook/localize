import 'package:flutter/material.dart';
import 'package:localize/notifier/system.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/pages/navbar/avatar.dart';
import 'package:localize/ui/pages/navbar/nav_item.dart';
import 'package:localize/ui/utils.dart';

class UiNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double _padding = UiServiceSizing.padding;
    bool _canAdd = context.read<NotifierSystem>().user.isCreator;
    bool _canFile = context.watch<ProviderNavigator>().file != null;

    return Container(
      width: UiServiceSizing.navbar,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: [BoxShadow(blurRadius: _padding, offset: Offset(_padding * -0.5, 0.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiNavHeader(),
          UiNavBarItem(choice: NavChoice.PROJECTS),
          if (_canAdd) UiNavBarItem(choice: NavChoice.ADD),
          if (_canFile) UiNavBarItem(choice: NavChoice.FILE),
          const Spacer(),
          const Divider(),
          UiNavBarItem(choice: NavChoice.OPTIONS),
          UiNavBarItem(choice: NavChoice.LOGOUT),
        ],
      ),
    );
  }
}

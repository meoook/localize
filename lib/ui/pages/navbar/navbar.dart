import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/user.dart';
import 'package:localize/notifier/navigation.dart';
import 'package:localize/ui/pages/navbar/avatar.dart';
import 'package:localize/ui/pages/navbar/nav_item.dart';
import 'package:localize/ui/utils.dart';

class UiNavBar extends StatelessWidget {
  final ModelUser user;

  UiNavBar({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigator = context.watch<NotifierNavigator>();
    final List<ModelNavChoice> _bottomItems = _navigator.choices.where((element) => element.bottom).toList();
    final List<ModelNavChoice> _topItems = _navigator.choices.where((element) => !element.bottom).toList();
    return Container(
      width: UiServiceSizing.navbar,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: [BoxShadow(blurRadius: 8.0, offset: Offset(-4.0, 0.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiNavHeader(user: user),
          ..._topItems.map((e) => UiNavBarItem(navigation: e, navigator: _navigator)),
          Expanded(child: const SizedBox()),
          const Divider(),
          ..._bottomItems.map((e) => UiNavBarItem(navigation: e, navigator: _navigator)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/user.dart';
import 'package:localize/notifier/navigation.dart';
import 'package:localize/ui/utils.dart';
import 'package:localize/ui/pages/navbar/avatar.dart';
import 'package:localize/ui/pages/navbar/drawer_item.dart';

class UiMenuDrawer extends StatelessWidget {
  final ModelUser user;

  UiMenuDrawer({Key key, this.user});

  @override
  Widget build(BuildContext context) {
    final _navigator = context.watch<NotifierNavigator>();
    final List<ModelNavChoice> _bottomItems = _navigator.choices.where((element) => element.bottom).toList();
    final List<ModelNavChoice> _topItems = _navigator.choices.where((element) => !element.bottom).toList();

    return Container(
      width: UiServiceSizing.drawer,
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UiNavHeader(user: user, wide: true),
            ..._topItems.map((e) => UiDrawerItem(navigation: e, navigator: _navigator)),
            Expanded(child: const SizedBox()),
            const Divider(),
            ..._bottomItems.map((e) => UiDrawerItem(navigation: e, navigator: _navigator)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize/notifier/navigation.dart';

class UiDrawerItem extends StatelessWidget {
  final ModelNavChoice navigation;
  final NotifierNavigator navigator;

  const UiDrawerItem({Key key, this.navigation, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: navigation.nav == navigator.current,
      leading: Icon(navigation.icon),
      title: Text(navigation.name),
      onTap: navigation.nav == navigator.current
          ? null
          : () {
              Navigator.of(context).pop();
              navigator.navigate(navigation.nav);
            },
    );
  }
}

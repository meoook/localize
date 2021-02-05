import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localize/notifier/navigation.dart';

class UiNavBarItem extends StatelessWidget {
  final ModelNavChoice navigation;
  final NotifierNavigator navigator;

  const UiNavBarItem({Key key, this.navigation, this.navigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => navigator.navigate(navigation.nav),
      // onPressed: () => navigator.navigate(navigation.nav),
      style: navigation.nav == navigator.current ? TextButton.styleFrom(primary: Theme.of(context).accentColor) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(navigation.icon, size: 32.0),
            Text(navigation.name),
          ],
        ),
      ),
    );
  }
}

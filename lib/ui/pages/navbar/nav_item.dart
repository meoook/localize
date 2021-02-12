import 'package:flutter/material.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';
import 'package:provider/provider.dart';

class UiNavBarItem extends StatelessWidget {
  final ModelNavChoice navigation;

  const UiNavBarItem({Key key, this.navigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProviderNavigator _navigator = context.watch<ProviderNavigator>();
    const double _padding = UiServiceSizing.padding;
    return TextButton(
      onPressed: () {
        _navigator.project = null;
        _navigator.navigate(navigation.nav);
      },
      style: navigation.nav == _navigator.nav ? TextButton.styleFrom(primary: Theme.of(context).accentColor) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _padding * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(navigation.icon, size: _padding * 4),
            Text(navigation.name),
          ],
        ),
      ),
    );
  }
}

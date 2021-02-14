import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/services/options.dart';
import 'package:localize/ui/utils.dart';

class UiPageOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 40.0),
      child: Container(
        width: UiServiceSizing.scale(_width) > 2 ? 600 : _width * 0.8,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, spreadRadius: 0.5, offset: Offset(2.0, 1.0))],
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            UiThemeSwitch(),
            const SizedBox(height: 12),
            Text("Font size"),
            const SizedBox(height: 12),
            Text("Language"),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                    color: Theme.of(context).bottomAppBarColor, child: Text('App bar', style: TextStyle(fontSize: 40))),
                Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Text('Scaffold', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(color: Theme.of(context).canvasColor, child: Text('Canvas', style: TextStyle(fontSize: 40))),
                Container(color: Theme.of(context).accentColor, child: Text('Accent', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(
                    color: Theme.of(context).backgroundColor,
                    child: Text(' Back ground ', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(color: Theme.of(context).buttonColor, child: Text('Button', style: TextStyle(fontSize: 40))),
                Container(
                    color: Theme.of(context).dialogBackgroundColor,
                    child: Text('Dialog bg', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Text('Secondary Head', style: TextStyle(fontSize: 40))),
                Container(color: Theme.of(context).shadowColor, child: Text('Shadow', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(
                    color: Theme.of(context).highlightColor, child: Text('High light', style: TextStyle(fontSize: 40))),
                Container(color: Theme.of(context).splashColor, child: Text('Splash', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(
                    color: Theme.of(context).unselectedWidgetColor,
                    child: Text('Un select', style: TextStyle(fontSize: 40))),
                Container(
                    color: Theme.of(context).primaryColor, child: Text('Primary', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(
                    color: Theme.of(context).selectedRowColor, child: Text('* Row *', style: TextStyle(fontSize: 40))),
                Container(
                    color: Theme.of(context).indicatorColor, child: Text('Indicator', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(
                    color: Theme.of(context).toggleableActiveColor,
                    child: Text('Toggle active', style: TextStyle(fontSize: 40))),
                Container(color: Theme.of(context).errorColor, child: Text('Error', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(color: Theme.of(context).hintColor, child: Text('Hint', style: TextStyle(fontSize: 40))),
                Container(
                    color: Theme.of(context).primaryColorLight,
                    child: Text('Primary Light', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                Container(color: Theme.of(context).hoverColor, child: Text('Hover', style: TextStyle(fontSize: 40))),
                Container(
                    color: Theme.of(context).primaryColorDark,
                    child: Text('Primary Dark', style: TextStyle(fontSize: 40))),
              ],
            ),
            Row(
              children: [
                TextButton(child: Text('Text'), onPressed: () {}),
                OutlineButton(child: Text('Outline'), onPressed: () {}),
                ElevatedButton(child: Text('Elevated'), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UiThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _isLight = context.watch<NotifierSystem>().options.theme;
    final NotifierSystem state = context.watch<NotifierSystem>();
    // final ServiceStateManager state = context.select<ServiceStateManager>((value) => value);

    return GestureDetector(
      onTap: () {
        state.option(OptionKey.THEME, !_isLight);
      },
      child: Container(
        height: 40.0,
        width: 180,
        child: Text("Color theme"),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 8.0, spreadRadius: 0.5, offset: Offset(2.0, 1.0))],
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}

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
          color: Theme.of(context).dialogBackgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            UiThemeSwitch(),
            const SizedBox(height: 12),
            Text("Font size"),
            Wrap(children: [
              // Text('Headline1', style: Theme.of(context).textTheme.headline1),
              Text('Headline2', style: Theme.of(context).textTheme.headline2),
              Text('Headline3', style: Theme.of(context).textTheme.headline3),
              Text('Headline4', style: Theme.of(context).textTheme.headline4),
              Text('Headline5', style: Theme.of(context).textTheme.headline5),
              Text('Headline6', style: Theme.of(context).textTheme.headline6),
            ]),
            Row(children: [
              Text('subtitle1', style: Theme.of(context).textTheme.subtitle1),
              Text('subtitle2', style: Theme.of(context).textTheme.subtitle2),
              Text('bodyText1', style: Theme.of(context).textTheme.bodyText1),
              Text('bodyText2', style: Theme.of(context).textTheme.bodyText2),
              Text('caption', style: Theme.of(context).textTheme.caption),
              Text('Over line', style: Theme.of(context).textTheme.overline),
              Text('button', style: Theme.of(context).textTheme.button),
            ]),
            const SizedBox(height: 12),
            Text("Language"),
            const SizedBox(height: 12),
            Row(
              children: [
                _Conte(text: 'Scaffold', color: Theme.of(context).scaffoldBackgroundColor),
                _Conte(text: 'Background', color: Theme.of(context).backgroundColor),
                _Conte(text: 'Dialog bg', color: Theme.of(context).dialogBackgroundColor),
                _Conte(text: 'App bar', color: Theme.of(context).bottomAppBarColor),
              ],
            ),
            Row(
              children: [
                _Conte(text: 'Canvas', color: Theme.of(context).canvasColor),
                _Conte(text: 'Secondary Head', color: Theme.of(context).secondaryHeaderColor),
                _Conte(text: 'Shadow', color: Theme.of(context).shadowColor),
              ],
            ),
            Row(
              children: [
                _Conte(text: 'Accent', color: Theme.of(context).accentColor),
                _Conte(text: 'Button', color: Theme.of(context).buttonColor),
                _Conte(text: 'Toggle active', color: Theme.of(context).toggleableActiveColor),
                _Conte(text: 'Hover', color: Theme.of(context).hoverColor),
              ],
            ),
            Row(
              children: [
                _Conte(text: 'High light', color: Theme.of(context).highlightColor),
                _Conte(text: 'Error', color: Theme.of(context).errorColor),
                _Conte(text: 'Indicator', color: Theme.of(context).indicatorColor),
                _Conte(text: 'Splash', color: Theme.of(context).splashColor),
              ],
            ),
            Row(
              children: [
                _Conte(text: 'Un selected', color: Theme.of(context).unselectedWidgetColor),
                _Conte(text: 'Primary', color: Theme.of(context).primaryColor),
                _Conte(text: 'Selected row', color: Theme.of(context).selectedRowColor),
              ],
            ),
            Row(
              children: [
                _Conte(text: 'Hint', color: Theme.of(context).hintColor),
                _Conte(text: 'Primary Light', color: Theme.of(context).primaryColorLight),
                _Conte(text: 'Primary Dark', color: Theme.of(context).primaryColorDark),
              ],
            ),
            Row(
              children: [
                TextButton(child: Text('Text'), onPressed: () {}),
                OutlinedButton(child: Text('Outline'), onPressed: () {}),
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

class _Conte extends StatelessWidget {
  final String text;
  final Color color;

  const _Conte({Key key, @required this.text, @required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: color, child: Text(text, style: TextStyle(fontSize: 30)));
  }
}

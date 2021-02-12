import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/runner.dart';
import 'package:localize/ui/image/person.dart';

class UiNavHeader extends StatelessWidget {
  final user;
  final bool wide;

  const UiNavHeader({Key key, this.user, this.wide = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String _name = context.read<NotifierRunner>().user.name;

    final _width = wide ? 100.0 : 50.0;
    final _tStyle = wide ? Theme.of(context).textTheme.headline5 : Theme.of(context).textTheme.subtitle2;
    return Container(
      padding: EdgeInsets.only(top: 12.0, bottom: 6.0),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[Colors.deepOrange, Colors.orangeAccent]),
      ),
      child: Column(
        children: [
          Material(
            borderRadius: BorderRadius.circular(_width / 2),
            elevation: 12,
            child: SizedBox(width: _width, height: _width, child: RivePerson()),
          ),
          const SizedBox(height: 4.0),
          Text(_name.split('#')[0], style: _tStyle),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/ui/image/person.dart';

class UiNavHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String _name = context.read<NotifierSystem>().user.name;
    const _width = 50.0;
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
          Text(_name.split('#')[0], style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}

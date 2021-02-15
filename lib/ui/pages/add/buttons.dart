import 'package:flutter/material.dart';

class UiAddProjectButtons extends StatelessWidget {
  final int step;
  final Function prev;
  final Function next;

  const UiAddProjectButtons({Key key, @required this.step, @required this.prev, this.next}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      // buttonMinWidth: 100.0,
      // buttonHeight: 50.0,
      // buttonPadding: EdgeInsets.symmetric(horizontal: 12.0),
      children: [
        if (step > 1)
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            onPressed: prev,
            child: Text('Previous', style: Theme.of(context).textTheme.headline5),
          ),
        RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          onPressed: next,
          child: Text(step < 3 ? 'Next' : 'Finish', style: Theme.of(context).textTheme.headline5),
        ),
      ],
    );
  }
}

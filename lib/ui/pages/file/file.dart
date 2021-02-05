import 'package:flutter/material.dart';

class UiPageFile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Column(
          children: [
            Container(color: Theme.of(context).buttonColor, child: Text('Button', style: TextStyle(fontSize: 72))),
            Container(color: Theme.of(context).primaryColor, child: Text('Primary', style: TextStyle(fontSize: 72))),
            Container(
                color: Theme.of(context).secondaryHeaderColor,
                child: Text('Secondary', style: TextStyle(fontSize: 72))),
            Container(color: Theme.of(context).canvasColor, child: Text('Canvas', style: TextStyle(fontSize: 72))),
            Container(color: Theme.of(context).accentColor, child: Text('Accent', style: TextStyle(fontSize: 72))),
            Container(color: Theme.of(context).cardColor, child: Text('Card', style: TextStyle(fontSize: 72))),
            Container(
                color: Theme.of(context).indicatorColor, child: Text('Indicator', style: TextStyle(fontSize: 72))),
          ],
        ),
      ),
    );
  }
}

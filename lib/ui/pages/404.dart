import 'package:flutter/material.dart';

class UiPageUnknown extends StatelessWidget {
  final String text;

  const UiPageUnknown({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(text != null ? text : '404', style: TextStyle(fontSize: text != null ? 50 : 100)),
      ),
    );
  }
}

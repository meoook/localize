import 'package:flutter/material.dart';

class UiPageUnknown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text('404', style: TextStyle(fontSize: 100)),
      ),
    );
  }
}

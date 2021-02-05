import 'package:flutter/material.dart';

class UiPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SizedBox(
          child: CircularProgressIndicator(strokeWidth: 8.0),
          height: 150.0,
          width: 150.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize/ui/utils.dart';

class UiProjectIconChars extends StatelessWidget {
  const UiProjectIconChars({@required this.iChars, this.scale = 1});
  final String iChars;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final _chars = iChars.length >= 2 ? iChars.capitalize().substring(0, 2) : iChars.capitalize();
    return Container(
      width: scale * 2.2 * 24,
      height: scale * 2.2 * 24,
      transformAlignment: Alignment.center,
      alignment: Alignment.center,
      child: Text(
        _chars,
        style: TextStyle(
          fontSize: scale * 24,
          letterSpacing: scale * 3,
          color: Theme.of(context).primaryColor,
        ),
      ),
      padding: EdgeInsets.only(bottom: scale * 2),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).canvasColor, width: scale.round() * 2.0),
        borderRadius: BorderRadius.circular(scale * 2.4 * 24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: <Color>[Colors.deepPurple, Colors.black26],
        ),
        boxShadow: [BoxShadow(blurRadius: 4.0)],
      ),
    );
  }
}

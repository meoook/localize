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
      width: scale * 2.4 * 24,
      height: scale * 2.2 * 24,
      alignment: Alignment.center,
      child: Text(
        _chars,
        style: TextStyle(
          fontSize: scale * 24,
          letterSpacing: scale * 3,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = scale * 1.5
            ..color = Theme.of(context).accentColor,
        ),
      ),
      // padding: EdgeInsets.only(bottom: 2.0),
      // margin: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Theme.of(context).accentColor, width: scale),
        color: Theme.of(context).primaryColor,
        // boxShadow: [
        //   BoxShadow(
        //       offset: Offset(1.0, 0.0), blurRadius: 2.0, spreadRadius: 1.0)
        // ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize/ui/utils.dart';

class UiFolderOptionItem extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final IconData icon;
  final bool active;

  const UiFolderOptionItem({Key key, @required this.icon, this.text, this.onPressed, this.active = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _padding = UiServiceSizing.padding;
    return RawMaterialButton(
      fillColor: null,
      hoverColor: Colors.white10,
      splashColor: Theme.of(context).splashColor,
      elevation: _padding / 2,
      padding: const EdgeInsets.symmetric(vertical: _padding, horizontal: _padding * 2),
      onPressed: onPressed,
      shape: const StadiumBorder(),
      textStyle: active
          ? Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).accentColor)
          : Theme.of(context).textTheme.subtitle1,
      child: Row(
        children: [
          Icon(icon),
          if (text != null) SizedBox(width: _padding),
          if (text != null) Text(text.cutTo(12), maxLines: 1),
        ],
      ),
    );
  }
}

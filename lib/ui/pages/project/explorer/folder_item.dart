import 'package:flutter/material.dart';
import 'package:localize/ui/utils.dart';

class UiFolderItem extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final bool active;
  final bool isCreate;

  const UiFolderItem({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.active = false,
    this.isCreate = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _style() {
      if (isCreate) return Theme.of(context).textTheme.subtitle1;
      if (active) return Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).accentColor);
      return Theme.of(context).textTheme.subtitle2;
    }

    const double _padding = UiServiceSizing.padding;
    return RawMaterialButton(
      fillColor: isCreate ? Colors.green : null,
      hoverColor: Colors.white10,
      splashColor: Theme.of(context).splashColor,
      elevation: _padding / 2,
      padding: const EdgeInsets.symmetric(vertical: _padding, horizontal: _padding * 2.0),
      onPressed: onPressed,
      shape: const StadiumBorder(),
      textStyle: _style(),
      child: Row(
        children: [
          isCreate ? Icon(Icons.create_new_folder) : Icon(Icons.folder),
          const SizedBox(width: _padding / 2),
          Text(text.cutTo(10), maxLines: 1),
        ],
      ),
    );
  }
}

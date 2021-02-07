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
    const double _padding = UiServiceSizing.padding;
    return RawMaterialButton(
      fillColor: isCreate ? Colors.green : null,
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
          isCreate ? Icon(Icons.create_new_folder) : Icon(Icons.folder),
          SizedBox(width: _padding),
          Text(text.cutTo(12), maxLines: 1),
        ],
      ),
    );
  }
}

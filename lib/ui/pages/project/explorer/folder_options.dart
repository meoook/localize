import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/ui/utils.dart';

class UiFolderOptions extends StatelessWidget {
  final ModelFolder folder;

  const UiFolderOptions({Key key, this.folder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        UiFolderOptionItem(text: 'file list', icon: Icons.format_list_bulleted, onPressed: () {}),
        UiFolderOptionItem(text: 'add files', icon: Icons.file_download, onPressed: () {}),
        UiFolderOptionItem(text: 'modify', icon: Icons.create, onPressed: () {}),
        Expanded(child: const SizedBox()),
        Text('${folder.id} ${folder.files}'),
        UiFolderOptionItem(text: 'delete', icon: Icons.delete, onPressed: () {}),
      ],
    );
  }
}

class UiFolderOptionItem extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final IconData icon;

  const UiFolderOptionItem({Key key, @required this.icon, this.text, this.onPressed}) : super(key: key);

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
      textStyle: Theme.of(context).textTheme.subtitle1,
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

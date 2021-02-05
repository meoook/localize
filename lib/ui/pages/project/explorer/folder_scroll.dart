import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/ui/pages/project/explorer/folder_scroll_item.dart';

class UiFolderScroller extends StatelessWidget {
  final List<ModelFolder> folders;

  const UiFolderScroller({Key key, this.folders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.red,
          // margin: const EdgeInsets.only(left: 20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...folders.map((element) => UiFolderScrollItem(text: element.name)).toList(),
                UiFolderScrollItem(text: 'Amber'),
                UiFolderScrollItem(text: 'Folder'),
                UiFolderScrollItem(text: 'Ask me'),
                UiFolderScrollItem(text: 'Http'),
                UiFolderScrollItem(text: 'Settings'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

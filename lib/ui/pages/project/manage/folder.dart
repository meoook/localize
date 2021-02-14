import 'package:flutter/material.dart';
import 'package:localize/ui/pages/project/manage/help.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/folders.dart';
import 'package:localize/model/folder.dart';

import 'file_list.dart';
import 'folder_options.dart';

class UiFolderManager extends StatefulWidget {
  @override
  _UiFolderManagerState createState() => _UiFolderManagerState();
}

class _UiFolderManagerState extends State<UiFolderManager> {
  FolderOption _selected;

  @override
  initState() {
    super.initState();
    _selected = FolderOption.LIST;
  }

  void _change(FolderOption option) => setState(() => _selected = option);

  @override
  Widget build(BuildContext context) {
    ModelFolder _current = context.watch<NotifierFolders>().selected;

    if (_current == null) return UiManageHelp();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UiFolderOptions(active: _selected, change: _change),
        const Divider(height: 1.0, thickness: 1.0),
        if (_selected == FolderOption.LIST) UiFileList(key: UniqueKey(), folderID: _current.id),
        if (_selected == FolderOption.ADD) Expanded(child: Container(color: Colors.red, child: Text('two'))),
        if (_selected == FolderOption.MODIFY) Expanded(child: Container(color: Colors.green, child: Text('three'))),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/ui/utils.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/folders.dart';

import 'dialogs.dart';
import 'folder_option_item.dart';

enum FolderOption { LIST, ADD, MODIFY }

class UiFolderOptions extends StatelessWidget {
  final FolderOption selected;
  final Function change;

  const UiFolderOptions({Key key, @required this.selected, @required this.change}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NotifierFolders _folders = context.read<NotifierFolders>();
    const double _padding = UiServiceSizing.padding;
    return Row(
      children: [
        if (_folders.selected == null)
          RawMaterialButton(
            onPressed: null,
            padding: const EdgeInsets.symmetric(vertical: _padding, horizontal: _padding * 2),
            child: Text('No folder selected', style: Theme.of(context).textTheme.subtitle1),
          ),
        if (_folders.selected != null) ...[
          UiFolderOptionItem(
            text: 'file list',
            icon: Icons.format_list_bulleted,
            onPressed: () => change(FolderOption.LIST),
            active: this.selected == FolderOption.LIST,
          ),
          UiFolderOptionItem(
            text: 'add files',
            icon: Icons.file_download,
            onPressed: () => change(FolderOption.ADD),
            active: this.selected == FolderOption.ADD,
          ),
          UiFolderOptionItem(
            text: 'modify',
            icon: Icons.create,
            onPressed: () => change(FolderOption.MODIFY),
            active: this.selected == FolderOption.MODIFY,
          ),
          Expanded(child: Text('files ${_folders.selected.files}', style: Theme.of(context).textTheme.subtitle1)),
          UiFolderOptionItem(
            text: 'delete',
            icon: Icons.delete,
            onPressed: () => warningDeleteDialog(context, _folders.delete, 'folder', _folders.selected.name),
          ),
        ],
      ],
    );
  }
}

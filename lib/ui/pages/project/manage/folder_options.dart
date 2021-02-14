import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/folders.dart';

import 'dialogs.dart';
import 'folder_option_item.dart';

enum FolderOption { LIST, ADD, MODIFY }

class UiFolderOptions extends StatelessWidget {
  final FolderOption active;
  final Function change;

  const UiFolderOptions({Key key, @required this.active, @required this.change}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotifierFolders _folders = context.read<NotifierFolders>();

    return Row(
      children: [
        UiFolderOptionItem(
          text: 'file list',
          icon: Icons.format_list_bulleted,
          onPressed: () => change(FolderOption.LIST),
          active: this.active == FolderOption.LIST,
        ),
        UiFolderOptionItem(
          text: 'add files',
          icon: Icons.file_download,
          onPressed: () => change(FolderOption.ADD),
          active: this.active == FolderOption.ADD,
        ),
        UiFolderOptionItem(
          text: 'modify',
          icon: Icons.create,
          onPressed: () => change(FolderOption.MODIFY),
          active: this.active == FolderOption.MODIFY,
        ),
        Expanded(child: Text(' files ${_folders.selected.files}', style: Theme.of(context).textTheme.subtitle1)),
        UiFolderOptionItem(
          text: 'delete',
          icon: Icons.delete,
          onPressed: () => warningDeleteDialog(context, _folders.delete, 'folder', _folders.selected.name),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize/notifier/files.dart';
import 'package:provider/provider.dart';

import 'package:localize/services/http_client.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/ui/utils.dart';

import 'dialogs.dart';
import 'folder_item.dart';
import 'folder.dart';

class UiProjectExplorer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotifierFolders _folders = context.watch<NotifierFolders>();

    void _submit(String name) {
      if (_folders.names.contains(name)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Folder with name $name already exist')),
        );
      } else {
        _folders.create(name);
        Navigator.of(context).pop();
      }
    }

    const double _padding = UiServiceSizing.padding;
    return Row(
      children: [
        Container(
          width: UiServiceSizing.folders,
          margin: const EdgeInsets.symmetric(horizontal: _padding),
          child: Column(
            children: [
              UiFolderItem(text: 'new folder', isCreate: true, onPressed: () => folderCreateDialog(context, _submit)),
              if (_folders.status == ApiStatus.LOADING) Center(child: CircularProgressIndicator()),
              if ([ApiStatus.ERROR, ApiStatus.NO].contains(_folders.status)) Text('Error'),
              if (_folders.status == ApiStatus.OK)
                Expanded(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _folders.list.length,
                    itemBuilder: (context, index) => UiFolderItem(
                      text: _folders.list[index].name,
                      onPressed: () {
                        _folders.selected = _folders.list[index];
                        context.read<NotifierFiles>().get(_folders.selected.id);
                      },
                      active: _folders.selected == _folders.list[index],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const VerticalDivider(width: 1.0, thickness: 1.0),
        Expanded(child: UiFolderManager()),
      ],
    );
  }
}

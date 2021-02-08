import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/project.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/ui/pages/project/explorer/folder_item.dart';
import 'package:localize/ui/pages/project/explorer/dialogs.dart';
import 'package:localize/ui/utils.dart';

import 'folder_manager.dart';

class UiProjectExplorer extends StatelessWidget {
  final ModelProject project; // FIXME: not used in this widget
  const UiProjectExplorer({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotifierFolders _folders = context.watch<NotifierFolders>();
    if (_folders.status == ApiStatus.LOADING) return Center(child: CircularProgressIndicator());
    if ([ApiStatus.ERROR, ApiStatus.NO].contains(_folders.status)) return Text('Error getting folders');

    const double _padding = UiServiceSizing.padding;
    final double _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);

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

    return Row(
      children: [
        Container(
          width: 110 * _scale,
          margin: const EdgeInsets.symmetric(horizontal: _padding),
          child: Column(
            children: [
              UiFolderItem(text: 'new folder', onPressed: () => folderCreateDialog(context, _submit), isCreate: true),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _folders.list.length,
                  itemBuilder: (context, index) => UiFolderItem(
                      text: _folders.list[index].name,
                      onPressed: () => _folders.selected = _folders.list[index],
                      active: _folders.selected == _folders.list[index]),
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

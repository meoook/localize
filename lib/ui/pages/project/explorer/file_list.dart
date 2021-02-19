import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/notifier/files.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/notifier/system.dart';

import 'file_item.dart';
import 'help.dart';

class UiFileList extends StatelessWidget {
  final int folderID;

  const UiFileList({Key key, this.folderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<NotifierFiles>(
        builder: (context, files, child) {
          if (files.list == null) files.get(folderID);
          if (files.status == ApiStatus.LOADING) return Center(child: CircularProgressIndicator());
          if (files.status == ApiStatus.ERROR) return Text('Error getting files');
          if (files.list.isEmpty) {
            if (folderID != null) return UiManageHelp(firstDone: true);
            return Text('No files yet'); // if no folderID -> can't manage
          }
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: files.list.length,
            separatorBuilder: (_, __) => Divider(height: 1.0, thickness: 1.0),
            itemBuilder: (context, index) => UiFileListItem(file: files.list[index]),
          );
        },
      ),
    );
  }
}

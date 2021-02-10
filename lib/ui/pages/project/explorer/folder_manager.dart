import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/files.dart';
import 'package:localize/notifier/navigation.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/ui/utils.dart';
import 'package:localize/model/folder.dart';

import 'file_item.dart';
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

  Widget get _noFolders {
    const double _padding = UiServiceSizing.padding;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: _padding * 1.5, horizontal: _padding * 2),
      child: Text('No folder selected', style: Theme.of(context).textTheme.subtitle1),
    );
  }

  @override
  Widget build(BuildContext context) {
    ModelFolder _current = context.watch<NotifierFolders>().selected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (_current != null) ? UiFolderOptions(active: _selected, change: _change) : _noFolders,
        const Divider(height: 1.0, thickness: 1.0),
        if (_selected == FolderOption.LIST) UiFileList(folderID: _current.id),
        if (_selected == FolderOption.ADD) Expanded(child: Container(color: Colors.red, child: Text('two'))),
        if (_selected == FolderOption.MODIFY) Expanded(child: Container(color: Colors.green, child: Text('three'))),
      ],
    );
  }
}

class UiFileList extends StatelessWidget {
  final int folderID;

  const UiFileList({Key key, this.folderID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ServiceHttpClient _http = context.read<NotifierProjects>().http;
    return Expanded(
      child: ChangeNotifierProxyProvider<NotifierNavigator, NotifierFiles>(
        create: (_) => NotifierFiles(_http),
        update: (_, _nav, _files) {
          if (folderID != null)
            return _files..folder(_nav?.params['id'], folderID);
          else
            return _files..project(_nav?.params['id']);
        },
        child: Consumer<NotifierFiles>(
          builder: (context, files, child) {
            if (files.status == ApiStatus.LOADING) return Center(child: CircularProgressIndicator());
            if (files.status == ApiStatus.ERROR) return Text('Error getting files');
            if (files.list.isEmpty) return Text('No files yet');
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: files.list.length,
              separatorBuilder: (_, __) => Divider(height: 1.0, thickness: 1.0),
              itemBuilder: (context, index) => UiFileListItem(file: files.list[index]),
            );
          },
        ),
      ),
    );
  }
}

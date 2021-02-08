import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/ui/utils.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/folders.dart';

import 'folder_options.dart';

class UiFolderManager extends StatefulWidget {
  @override
  _UiFolderManagerState createState() => _UiFolderManagerState();
}

class _UiFolderManagerState extends State<UiFolderManager> {
  FolderOption _selected;
  Widget _widget;

  @override
  initState() {
    super.initState();
    this._setWidget();
  }

  void _setWidget({FolderOption option}) {
    _selected = option ?? FolderOption.LIST;
    if (_selected == FolderOption.LIST) _widget = Container(color: Colors.amber, child: Text('one'));
    if (_selected == FolderOption.ADD) _widget = Container(color: Colors.red, child: Text('two $_selected'));
    if (_selected == FolderOption.MODIFY) _widget = Container(color: Colors.green, child: Text('three'));
  }

  void _change(FolderOption option) => setState(() => this._setWidget(option: option));

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
        Expanded(child: this._widget),
      ],
    );
  }
}

class UiFileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ModelFolder _current = context.read<NotifierFolders>().selected;
    return Text('test');
    // return
    // ChangeNotifierProxyProvider<NotifierFolders>(create: create, update: update, child: child,)
    //   Container(
    //   child: ListView.builder(
    //     physics: BouncingScrollPhysics(),
    //     itemCount: _folders.list.length,
    //     itemBuilder: (context, index) => UiFolderItem(text: _folders.list[index].name, onPressed: () {}),
    //   ),
    // );
  }
}

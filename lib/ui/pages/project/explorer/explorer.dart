import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/ui/pages/project/explorer/folder_options.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/project.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/ui/pages/project/explorer/folder_item.dart';
import 'package:localize/ui/utils.dart';

class UiProjectExplorer extends StatefulWidget {
  final ModelProject project; // FIXME: not used in this widget
  const UiProjectExplorer({Key key, @required this.project}) : super(key: key);

  @override
  _UiProjectExplorerState createState() => _UiProjectExplorerState();
}

class _UiProjectExplorerState extends State<UiProjectExplorer> {
  ModelFolder _selected;

  void _change(ModelFolder folder) => setState(() => _selected = folder);

  @override
  Widget build(BuildContext context) {
    NotifierFolders _manager = context.watch<NotifierFolders>();
    if (_manager.status == ApiStatus.LOADING) return Center(child: CircularProgressIndicator());
    if ([ApiStatus.ERROR, ApiStatus.NO].contains(_manager.status)) return Text('Error getting folders');

    const double _padding = UiServiceSizing.padding;
    final double _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);

    _selected ??= _manager.list.first;
    return Row(
      children: [
        Container(
          width: 110 * _scale,
          margin: const EdgeInsets.symmetric(horizontal: _padding),
          child: Column(
            children: [
              UiFolderItem(
                  text: 'new folder',
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Create new folder'),
                            content:
                                Container(color: Colors.indigoAccent, child: Text('Enter folder name (any windget)')),
                            actions: [
                              TextButton(onPressed: () {}, child: Text("Chancel")),
                              TextButton(onPressed: () {}, child: Text("Create"))
                            ],
                            elevation: 24.0,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          );
                        });
                  },
                  isCreate: true),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _manager.list.length,
                  itemBuilder: (context, index) => UiFolderItem(
                      text: _manager.list[index].name,
                      onPressed: () {
                        this._change(_manager.list[index]);
                      },
                      active: _manager.list[index] == _selected),
                ),
              ),
            ],
          ),
        ),
        const VerticalDivider(width: 1.0, thickness: 1.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiFolderOptions(folder: _selected),
              const Divider(height: 1.0, thickness: 1.0),
              Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _manager.list.length,
                  itemBuilder: (context, index) => UiFolderItem(text: _manager.list[index].name, onPressed: () {}),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

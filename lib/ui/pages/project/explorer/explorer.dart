import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/model/project.dart';
import 'package:localize/notifier/folders.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/ui/pages/project/explorer/file_scroll_item.dart';
import 'package:localize/ui/pages/project/explorer/folder_scroll.dart';
import 'package:provider/provider.dart';

class UiProjectExplorer extends StatelessWidget {
  final ModelProject project;

  const UiProjectExplorer({Key key, this.project}) : super(key: key);

  // @override
  // bool get _translatorOnly => widget.project.permissions.length == 1 && widget.project.permissions.first == 0;

  Widget _getWidget(BuildContext context, NotifierFolders manager) {
    if (manager.status == ApiStatus.LOADING) return Center(child: CircularProgressIndicator());
    // if (manager.status == ApiStatus.OK) return Text('Get folders ${manager.list.length}');
    if (manager.status == ApiStatus.OK) return _ProjectExplorer(folders: manager.list);
    return Text('Error getting folders');
  }

  @override
  Widget build(BuildContext context) {
    NotifierFolders _manager = context.watch<NotifierFolders>();
    return Expanded(
      child: _getWidget(context, _manager),
      // return ListView(
      //     physics: BouncingScrollPhysics(), scrollDirection: Axis.horizontal, children: [..._folders]);
    );
  }
}

class _ProjectExplorer extends StatefulWidget {
  final List<ModelFolder> folders;

  const _ProjectExplorer({Key key, this.folders}) : super(key: key);
  @override
  __ProjectExplorerState createState() => __ProjectExplorerState();
}

class __ProjectExplorerState extends State<_ProjectExplorer> {
  ScrollController controller = ScrollController();
  bool closeFolders = false;
  double topContainer = 0;

  List<Map<String, dynamic>> itemsData = [
    {'id': 1, 'name': 'xaxa', 'brand': 'xoxoxo', 'price': 2},
    {'id': 2, 'name': 'zzzz', 'brand': 'cccccc', 'price': 3},
    {'id': 3, 'name': 'xxxx', 'brand': 'ccxxcc', 'price': 4},
    {'id': 4, 'name': 'yyyy', 'brand': 'dddddd', 'price': 5},
    {'id': 5, 'name': 'mmmm', 'brand': 'aaaaaa', 'price': 6},
    {'id': 5, 'name': 'asda', 'brand': 'aaaaaa', 'price': 6},
    {'id': 5, 'name': 'xczx', 'brand': 'aaaaaa', 'price': 6},
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      double value = controller.offset / 119;
      setState(() {
        topContainer = value;
        closeFolders = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double foldersHeight = 50.0;
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: closeFolders ? 0 : 1,
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // width: size.width,
              alignment: Alignment.topCenter,
              height: closeFolders ? 0 : foldersHeight,
              child: UiFolderScroller(folders: widget.folders)),
        ),
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: itemsData.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              double scale = 1.0;
              if (topContainer > 0.5) {
                scale = index + 0.5 - topContainer;
                if (scale < 0) {
                  scale = 0;
                } else if (scale > 1) {
                  scale = 1;
                }
              }
              return Opacity(
                opacity: scale,
                child: Transform(
                  transform: Matrix4.identity()..scale(scale, scale),
                  alignment: Alignment.bottomCenter,
                  child: UiFileScrollItem(post: itemsData[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/notifier/folders.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/notifier/system.dart';

import 'folders.dart';
import 'file_list.dart';

class UiProjectManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _withExplorer = context.read<ProviderNavigator>().project.permissions.canManage;

    if (!_withExplorer) return UiFileList();

    final _http = context.read<NotifierSystem>().http;
    return ChangeNotifierProxyProvider<ProviderNavigator, NotifierFolders>(
      create: (_) => NotifierFolders(_http),
      update: (_, _nav, _folders) => _folders..project(_nav.project.id),
      child: UiProjectFolders(),
    );
  }
}

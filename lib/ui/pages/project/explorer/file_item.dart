import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:localize/model/file.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';

import 'package:localize/ui/components/lang_icon.dart';
import 'dialogs.dart';
import 'file_progress.dart';

class UiFileListItem extends StatelessWidget {
  final ModelFile file;

  bool get isError => file.error.isNotEmpty;

  const UiFileListItem({Key key, this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProviderNavigator _nav = context.watch<ProviderNavigator>();

    const double _padding = UiServiceSizing.padding;
    final _tTheme = Theme.of(context).textTheme;

    Widget _name = Container(
      padding: const EdgeInsets.only(bottom: _padding / 2, left: _padding, right: _padding),
      child: Text(file.name, style: _tTheme.headline6),
    );

    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white10,
            padding: const EdgeInsets.only(right: _padding),
            child: Row(
              children: [
                if (!_nav.project.permissions.canTranslate || isError) _name,
                if (_nav.project.permissions.canTranslate && !isError)
                  TextButton(
                      child: _name,
                      onPressed: () {
                        _nav.file = file;
                        _nav.navigate(NavChoice.FILE);
                      }),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                  iconSize: 14.0,
                  splashRadius: 16.0,
                  tooltip: 'Edit file',
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {},
                  iconSize: 14.0,
                  splashRadius: 16.0,
                  tooltip: 'Load new or translated version',
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () => warningDeleteDialog(context, null, 'file', file.name),
                  iconSize: 14.0,
                  splashRadius: 16.0,
                  tooltip: 'Delete file',
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Created ${file.created.getDate}', style: _tTheme.caption),
                        Text('Method ${file.method.isNotEmpty ? file.method : 'unknown'}', style: _tTheme.overline),
                        if (file.warning.isNotEmpty)
                          Text(file.warning, style: _tTheme.bodyText1.copyWith(color: Colors.amber)),
                      ],
                    ),
                  ),
                  if (!isError) ...[
                    Column(
                      children: [
                        Text('Total words', style: _tTheme.caption),
                        Expanded(child: Center(child: Text('${file.words}', style: _tTheme.headline6))),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Original', style: _tTheme.caption),
                          Expanded(child: Center(child: UiLanguageIcon(languageID: file.langOriginal))),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: _padding * 4.5),
                            child: Text('Progress', style: _tTheme.caption),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [...file.progress.map((e) => UiFileItemProgress(progress: e)).toList()],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text('Git status', style: _tTheme.caption),
                          Expanded(
                            child: Center(
                              child: Icon(
                                Icons.account_tree_rounded,
                                color: (file.repoStatus == null)
                                    ? Colors.white60
                                    : file.repoStatus
                                        ? Colors.green
                                        : Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (isError)
                    Expanded(
                      flex: 5,
                      child: Text(file.error, style: _tTheme.headline5.copyWith(color: Colors.redAccent)),
                    ),
                ],
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

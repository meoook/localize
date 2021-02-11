import 'package:flutter/material.dart';
import 'package:localize/model/file.dart';
import 'package:localize/model/language.dart';
import 'package:localize/model/progress.dart';
import 'package:localize/notifier/runner.dart';
import 'package:localize/ui/utils.dart';
import 'package:provider/provider.dart';

class UiFileListItem extends StatelessWidget {
  final ModelFile file;

  const UiFileListItem({Key key, this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double _padding = UiServiceSizing.padding;
    final _theme = Theme.of(context);
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white10,
            child: Row(
              children: [
                SizedBox(width: _padding),
                Text(file.name, style: _theme.textTheme.headline5),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {},
                  iconSize: 14.0,
                  splashRadius: 18.0,
                  tooltip: 'Edit file',
                ),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {},
                  iconSize: 14.0,
                  splashRadius: 18.0,
                  tooltip: 'Load new or translated version',
                ),
                IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () {},
                  iconSize: 14.0,
                  splashRadius: 18.0,
                  tooltip: 'Delete file',
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
                        Text('Created ${file.created.getDate}', style: _theme.textTheme.caption),
                        Text('Method ${file.method}', style: _theme.textTheme.overline),
                        Text('Warning ${file.warning}',
                            style: _theme.textTheme.bodyText1.copyWith(color: Colors.amber)),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text('Total words', style: Theme.of(context).textTheme.caption),
                      Expanded(
                          child: Center(child: Text('${file.words}', style: Theme.of(context).textTheme.headline6))),
                    ],
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text('Progress', style: Theme.of(context).textTheme.caption),
                        ...file.progress.map((e) => UiFileItemProgress(progress: e)).toList(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text('Git status', style: Theme.of(context).textTheme.caption),
                      Expanded(
                        child: Center(child: Text('${file.repoStatus}', style: Theme.of(context).textTheme.bodyText1)),
                      ),
                    ],
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

class UiFileItemProgress extends StatelessWidget {
  final ModelProgress progress;

  const UiFileItemProgress({Key key, this.progress}) : super(key: key);

  Color get _color {
    if (progress.value >= 100) return Color(0xFF44CC00);
    if (progress.value > 90) return Color(0x8844CC00);
    if (progress.value > 70) return Color(0xFFE0C000);
    if (progress.value > 50) return Color(0xFFCC5500);
    if (progress.value > 30) return Color(0xFFCC3300);
    return Color(0x88FF0000);
  }

  @override
  Widget build(BuildContext context) {
    final List<ModelLanguage> _languages = context.read<NotifierRunner>().languages;
    final _language = _languages.firstWhere((lang) => lang.id == progress.language);
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration:
              BoxDecoration(border: Border.all(color: Color(0xFFFFFFFF)), borderRadius: BorderRadius.circular(12.0)),
          child: Text('${_language.shortName}'.capitalize()),
        ),
        Expanded(
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(_color),
            value: progress.value / 100,
          ),
        ),
      ],
    );
  }
}

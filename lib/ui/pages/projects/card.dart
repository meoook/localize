import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'package:localize/ui/components/lang_icon.dart';
import 'file:///C:/Projects/Flutter/localize/lib/ui/components/project_chars.dart';
import 'package:localize/ui/utils.dart';

class UiProjectCard extends StatelessWidget {
  final ModelProject project;

  const UiProjectCard({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);
    const double _padding = UiServiceSizing.padding;

    final _tTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: _padding * _scale, vertical: _padding * _scale * 0.5),
        child: Row(
          children: [
            UiProjectIconChars(iChars: project.iChars, scale: _scale),
            SizedBox(width: _padding * _scale),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${project.name}', style: _tTheme.headline5, textScaleFactor: _scale),
                Row(
                  children: [
                    Text('Original language', style: _tTheme.caption, textScaleFactor: _scale),
                    const SizedBox(width: _padding / 2),
                    UiLanguageIcon(languageID: project.langOriginal),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                Text('author ${project.author}', style: _tTheme.caption, textScaleFactor: _scale),
                Text('created ${project.created.getDate}', style: _tTheme.caption, textScaleFactor: _scale),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

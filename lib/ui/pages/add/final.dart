import 'package:flutter/material.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/ui/components/lang_icon.dart';
import 'package:localize/ui/components/project_chars.dart';
import 'package:localize/ui/utils.dart';

class UiAddProjectFinal extends StatelessWidget {
  final ProviderProject project;

  const UiAddProjectFinal({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _labelTheme = Theme.of(context).textTheme.headline5.copyWith(color: Theme.of(context).primaryColorLight);
    var _valueTheme = Theme.of(context).textTheme.headline5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UiProjectIconChars(iChars: project.iChars, scale: 2),
        Row(
          children: [
            _UiAddProjectFinalCell(child: Text('Game name', style: _labelTheme), right: true),
            _UiAddProjectFinalCell(child: Text('${project.name}', style: _valueTheme)),
          ],
        ),
        Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _UiAddProjectFinalCell(child: Text('Original language', style: _labelTheme), right: true),
            _UiAddProjectFinalCell(child: UiLanguageIcon(languageID: project.langOriginal)),
          ],
        ),
        Row(
          // mainAxisSize: MainAxisSize.max,
          children: [
            _UiAddProjectFinalCell(child: Text('Languages to translate', style: _labelTheme), right: true),
            _UiAddProjectFinalCell(
              child: Row(children: [
                ...project.translateTo.map((e) => Padding(
                      padding: const EdgeInsets.only(right: UiServiceSizing.padding),
                      child: UiLanguageIcon(languageID: e),
                    ))
              ]),
            ),
          ],
        ),
      ],
    );
  }
}

class _UiAddProjectFinalCell extends StatelessWidget {
  final Widget child;
  final bool right;

  const _UiAddProjectFinalCell({Key key, @required this.child, this.right = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const _padding = UiServiceSizing.padding;
    return Expanded(
      child: Container(
        alignment: right ? Alignment.centerRight : Alignment.centerLeft,
        constraints: BoxConstraints(minHeight: _padding * 5),
        margin: EdgeInsets.all(_padding),
        child: child,
      ),
    );
  }
}

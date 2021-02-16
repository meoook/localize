import 'package:flutter/material.dart';
import 'package:localize/ui/components/lang_icon.dart';
import 'package:localize/ui/utils.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/language.dart';
import 'package:localize/model/project.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/ui/components/lang_select.dart';

import 'buttons.dart';

class UiAddProjectLanguages extends StatefulWidget {
  final ModelNewProject project;
  final Function prev;
  final Function next;

  const UiAddProjectLanguages({Key key, @required this.project, @required this.prev, @required this.next})
      : super(key: key);

  @override
  _UiAddProjectLanguagesState createState() => _UiAddProjectLanguagesState();
}

class _UiAddProjectLanguagesState extends State<UiAddProjectLanguages> {
  void _onChangeOriginal(int langID) => setState(() {
        widget.project.langOriginal = langID;
        widget.project.translateTo.remove(langID);
      });
  void _trAdd(int langID) => setState(() => widget.project.translateTo.add(langID));
  void _trRemove(int langID) => setState(() => widget.project.translateTo.remove(langID));

  @override
  Widget build(BuildContext context) {
    final List<ModelLanguage> _languages = context.read<NotifierSystem>().languages;

    if (widget.project.langOriginal == null) {
      final int _ruID = _languages.firstWhere((element) => element.shortName == 'ru')?.id;
      widget.project.langOriginal = _ruID ?? _languages.first.id;
      final int _enID = _languages.firstWhere((element) => element.shortName == 'en')?.id;
      widget.project.translateTo = <int>[_enID ?? _languages.last.id];
    }

    List<ModelLanguage> _choicesTranslate() => _languages
        .where((_e) => ![widget.project.langOriginal, ...widget.project.translateTo].contains(_e.id))
        .toList();

    const double _padding = UiServiceSizing.padding;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select original language.\nNew uploaded files will be parsed using this language.',
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).primaryColorLight),
        ),
        const SizedBox(height: _padding / 2),
        Row(
          children: [
            UiLanguageSelect(languages: _languages, selected: widget.project.langOriginal, onSelect: _onChangeOriginal),
            Container(
                margin: EdgeInsets.symmetric(horizontal: _padding),
                child: UiLanguageIcon(languageID: widget.project.langOriginal)),
          ],
        ),
        const SizedBox(height: _padding),
        Text(
          'Select languages to translate uploaded files.',
          style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).primaryColorLight),
        ),
        const SizedBox(height: _padding / 2),
        Row(
          children: [
            UiLanguageMSelect(languages: _choicesTranslate(), onSelect: _trAdd),
            Row(children: [
              ...widget.project.translateTo.map((langID) => RawMaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_padding)),
                    onPressed: () => _trRemove(langID),
                    child: UiLanguageIcon(languageID: langID),
                    constraints: BoxConstraints(minWidth: 0, minHeight: 0, maxHeight: _padding * 5),
                  )),
              if (widget.project.translateTo.isEmpty)
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: _padding),
                  margin: const EdgeInsets.symmetric(horizontal: _padding, vertical: _padding * 1.7),
                  child: Text('No languages selected', style: Theme.of(context).textTheme.subtitle1),
                ),
            ]),
          ],
        ),
        UiAddProjectButtons(step: 2, prev: widget.prev, next: widget.project.translateTo.isEmpty ? null : widget.next),
        // UiLanguageSelectXX(onSelect: _onSelect),
      ],
    );
  }
}

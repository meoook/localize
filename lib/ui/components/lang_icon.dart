import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/language.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/ui/utils.dart';

class UiLanguageIcon extends StatelessWidget {
  final int languageID;

  const UiLanguageIcon({Key key, this.languageID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<ModelLanguage> _languages = context.read<NotifierSystem>().languages;
    final _language = _languages.firstWhere((lang) => lang.id == languageID);
    final _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UiServiceSizing.padding),
      decoration:
          BoxDecoration(border: Border.all(color: _theme.primaryColor), borderRadius: BorderRadius.circular(12.0)),
      child: Text('${_language.shortName}'.capitalize(), style: _theme.textTheme.bodyText1),
    );
  }
}

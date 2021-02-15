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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration:
          BoxDecoration(border: Border.all(color: Color(0xFFFFFFFF)), borderRadius: BorderRadius.circular(12.0)),
      child: Text('${_language.shortName}'.capitalize()),
    );
  }
}

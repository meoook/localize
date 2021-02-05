import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localize/notifier/runner.dart';
import 'package:provider/provider.dart';

class _LanguageIcon extends StatelessWidget {
  final double size;
  final String chars;

  const _LanguageIcon({Key key, this.size = 24.0, this.chars = 'eu'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          'icons/flags/png/$chars.png',
          package: 'country_icons',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class LanguageNameIcon extends StatelessWidget {
  final String shortName;
  final String name;

  const LanguageNameIcon({Key key, this.shortName = 'eu', this.name = 'Not set'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LanguageIcon(
          size: 24,
          chars: shortName,
        ),
        const SizedBox(width: 4.0),
        Text(
          name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}

class LanguagesDropDown extends StatefulWidget {
  @override
  _LanguagesDropDownState createState() => _LanguagesDropDownState();
}

class _LanguagesDropDownState extends State<LanguagesDropDown> {
  String cellCurrentValue;

  @override
  Widget build(BuildContext context) {
    final languages = context.watch<NotifierRunner>().languages;
    String idToString(int langID) => languages.firstWhere((element) => element.id == langID).name;
    return PopupMenuButton<int>(
      initialValue: languages != null ? int.tryParse(cellCurrentValue) : cellCurrentValue,
      elevation: 16,
      onSelected: (int newValue) {
        print('$newValue ${newValue.runtimeType}');
        cellCurrentValue = idToString(newValue);
        setState(() {});
      },
      // icon: Icon(Icons.arrow_downward),
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0, 6.0, 8.0, 8.0),
        decoration: BoxDecoration(color: Theme.of(context).buttonColor, borderRadius: BorderRadius.circular(2.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              cellCurrentValue ?? "Original",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(width: 12.0),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        if (languages == null) {
          return [PopupMenuItem(child: LinearProgressIndicator())];
        }
        return languages.map<PopupMenuEntry<int>>((value) {
          return PopupMenuItem<int>(
            value: value.id,
            mouseCursor: MaterialStateMouseCursor.clickable,
            child: LanguageNameIcon(
              name: value.name,
              shortName: value.shortName,
            ),
          );
        }).toList();
      },
    );
  }
}

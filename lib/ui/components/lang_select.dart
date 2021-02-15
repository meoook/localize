import 'package:flutter/material.dart';
import 'package:localize/model/language.dart';

class UiLanguageSelect extends StatefulWidget {
  final List<ModelLanguage> languages;
  final int selected;
  final Function onSelect;

  const UiLanguageSelect({Key key, this.languages, this.selected, this.onSelect}) : super(key: key);

  @override
  _UiLanguageSelectState createState() => _UiLanguageSelectState();
}

class _UiLanguageSelectState extends State<UiLanguageSelect> {
  int _selected;

  @override
  Widget build(BuildContext context) {
    if (widget.languages == null || widget.languages.isEmpty) return _ChoiceBox();
    _selected ??= widget.selected ?? widget.languages.first.id;

    String idToString(int langID) => widget.languages?.firstWhere((_e) => _e.id == langID)?.name ?? 'No name';

    return PopupMenuButton<int>(
      initialValue: _selected,
      elevation: 16,
      onSelected: (int newValue) => setState(() {
        _selected = newValue;
        widget.onSelect(newValue);
      }),
      child: _ChoiceBox(text: idToString(_selected)),
      itemBuilder: (context) {
        return widget.languages.map<PopupMenuItem<int>>((value) {
          return PopupMenuItem<int>(
            value: value.id,
            mouseCursor: MaterialStateMouseCursor.clickable,
            child: Text(value.name),
          );
        }).toList();
      },
    );
  }
}

class UiLanguageMSelect extends StatefulWidget {
  final List<ModelLanguage> languages;
  final Function onSelect;

  const UiLanguageMSelect({Key key, this.languages, this.onSelect}) : super(key: key);

  @override
  _UiLanguageMSelectState createState() => _UiLanguageMSelectState();
}

class _UiLanguageMSelectState extends State<UiLanguageMSelect> {
  int _selected;

  @override
  Widget build(BuildContext context) {
    if (widget.languages == null || widget.languages.isEmpty) return _ChoiceBox();
    _selected = widget.languages.first.id;

    String idToString(int langID) => widget.languages?.firstWhere((_e) => _e.id == langID)?.name ?? 'No name';

    return PopupMenuButton<int>(
      initialValue: _selected,
      elevation: 16,
      onSelected: (int newValue) => setState(() {
        widget.onSelect(newValue);
      }),
      child: _ChoiceBox(text: idToString(_selected)),
      itemBuilder: (context) {
        return widget.languages.map<PopupMenuItem<int>>((value) {
          return PopupMenuItem<int>(
            value: value.id,
            mouseCursor: MaterialStateMouseCursor.clickable,
            child: Text(value.name),
          );
        }).toList();
      },
    );
  }
}

class _ChoiceBox extends StatelessWidget {
  final String text;

  const _ChoiceBox({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 6.0, 8.0, 8.0),
      constraints: BoxConstraints(minWidth: 130.0, maxHeight: 40.0),
      decoration: BoxDecoration(color: Theme.of(context).buttonColor, borderRadius: BorderRadius.circular(2.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text == null ? 'No choices' : text, style: Theme.of(context).textTheme.headline6),
          if (text != null) const SizedBox(width: 8.0),
          if (text != null) Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

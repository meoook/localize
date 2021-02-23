import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/system.dart';

class UiAccessUserSelect extends StatelessWidget {
  final String selected;
  final void Function(String) select;

  const UiAccessUserSelect({Key key, @required this.selected, @required this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> _names = context.read<NotifierSystem>().names;
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          textAlignVertical: TextAlignVertical.bottom,
          isEmpty: selected == null,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_add),
            hintText: 'Select user',
            isDense: true,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selected,
              isDense: true,
              onChanged: (String newValue) => select(newValue),
              items: _names.map((_v) => DropdownMenuItem<String>(value: _v, child: Text(_v))).toList(),
            ),
          ),
        );
      },
    );
  }
}

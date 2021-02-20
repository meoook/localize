import 'package:flutter/material.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';

class UiProjectAccess extends StatefulWidget {
  @override
  _UiProjectAccessState createState() => _UiProjectAccessState();
}

class _UiProjectAccessState extends State<UiProjectAccess> {
  String _selected;

  var _currencies = ["Food", "Transport", "Personal", "Shopping", "Medical", "Rent", "Movie", "Salary"];

  @override
  Widget build(BuildContext context) {
    // final ProviderNavigator _navigator = context.read<ProviderNavigator>();
    const double _padding = UiServiceSizing.padding;
    return Consumer<NotifierAccess>(builder: (context, project, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Placeholder()),
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: _padding * 3, vertical: _padding * 2),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: _padding, offset: Offset(2.0, 1.0))],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(_padding * 2)),
              color: Theme.of(context).dialogBackgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User permissions', style: Theme.of(context).textTheme.headline5),
                const SizedBox(height: _padding * 2),
                TextField(
                  textInputAction: TextInputAction.done,
                  onChanged: (String value) {},
                  // controller: _charsController,
                  // validator: (chars) {
                  //   Pattern pattern = r'^[A-Za-z0-9]{1,2}$';
                  //   RegExp regex = new RegExp(pattern);
                  //   if (!regex.hasMatch(chars))
                  //     return 'Invalid icon chars';
                  //   else
                  //     return null;
                  // },

                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_add),
                    labelText: "username",
                    helperText: "Enter username",
                  ),
                ),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(hintText: 'Please select expense'),
                      isEmpty: _selected == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selected,
                          isDense: true,
                          onChanged: (String newValue) => setState(() => _selected = newValue),
                          items: _currencies.map((_v) => DropdownMenuItem<String>(value: _v, child: Text(_v))).toList(),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

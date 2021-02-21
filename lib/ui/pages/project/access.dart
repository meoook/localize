import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:localize/notifier/system.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/utils.dart';

class UiProjectAccess extends StatefulWidget {
  @override
  _UiProjectAccessState createState() => _UiProjectAccessState();
}

class _UiProjectAccessState extends State<UiProjectAccess> {
  String _selected;

  @override
  Widget build(BuildContext context) {
    // final ProviderNavigator _navigator = context.read<ProviderNavigator>();
    final List<String> _names = context.read<NotifierSystem>().names;
    const double _padding = UiServiceSizing.padding;
    return Consumer<NotifierAccess>(builder: (context, access, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Placeholder()),
          Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding * 2),
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
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      textAlignVertical: TextAlignVertical.bottom,
                      isEmpty: _selected == null,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_add),
                        hintText: 'Select user',
                        isDense: true,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selected,
                          isDense: true,
                          onChanged: (String newValue) => setState(() => _selected = newValue),
                          items: _names.map((_v) => DropdownMenuItem<String>(value: _v, child: Text(_v))).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: _padding * 2),
                if (_selected != null) Expanded(child: UiAccessUserCard(name: _selected)),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class UiAccessUserCard extends StatefulWidget {
  final String name;

  const UiAccessUserCard({Key key, @required this.name}) : super(key: key);
  @override
  _UiAccessUserCardState createState() => _UiAccessUserCardState();
}

class _UiAccessUserCardState extends State<UiAccessUserCard> {
  @override
  Widget build(BuildContext context) {
    final NotifierAccess _access = context.watch<NotifierAccess>();
    final UserAccess _user = _access.byName(widget.name);
    return Column(
      children: [
        Text(widget.name),
        SwitchListTile(
          title: Text('Translate'),
          subtitle: Text('Can translate files'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.translate != null,
          onChanged: (bool val) {
            val ? _access.create(_user.name, UserAccess.nTranslate) : _access.delete(_user.translate);
          },
        ),
        SwitchListTile(
          title: Text('Invite'),
          subtitle: Text('Can invite translators'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.invite != null,
          onChanged: (bool val) {
            val ? _access.create(_user.name, UserAccess.nInvite) : _access.delete(_user.invite);
          },
        ),
        SwitchListTile(
          title: Text('Manage'),
          subtitle: Text('Can manage files and folders'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.manage != null,
          onChanged: (bool val) {
            val ? _access.create(_user.name, UserAccess.nManage) : _access.delete(_user.manage);
          },
        ),
        SwitchListTile(
          title: Text('Admin'),
          subtitle: Text('Can manage all access'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.admin != null,
          onChanged: (bool val) {
            val ? _access.create(_user.name, UserAccess.nAdmin) : _access.delete(_user.admin);
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/model/access.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:localize/ui/utils.dart';

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
    const double _padding = UiServiceSizing.padding;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.name, style: Theme.of(context).textTheme.headline6),
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: _padding),
          title: const Text('Translate'),
          subtitle: const Text('Can translate files'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.translate != null,
          onChanged: (bool val) {
            val ? _access.create(_user, UserAccess.nTranslate) : _access.delete(_user, _user.translate);
          },
        ),
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: _padding),
          title: const Text('Invite'),
          subtitle: const Text('Can invite translators'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.invite != null,
          onChanged: (bool val) {
            val ? _access.create(_user, UserAccess.nInvite) : _access.delete(_user, _user.invite);
          },
        ),
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: _padding),
          title: const Text('Manage'),
          subtitle: const Text('Can manage files'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.manage != null,
          onChanged: (bool val) {
            val ? _access.create(_user, UserAccess.nManage) : _access.delete(_user, _user.manage);
          },
        ),
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: _padding),
          title: const Text('Admin'),
          subtitle: const Text('Can manage all access'),
          // secondary: Icon(Icons.ac_unit),
          value: _user.admin != null,
          onChanged: (bool val) {
            val ? _access.create(_user, UserAccess.nAdmin) : _access.delete(_user, _user.admin);
          },
        ),
      ],
    );
  }
}

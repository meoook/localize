import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/permissions.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/ui/utils.dart';

import 'card.dart';
import 'select.dart';

class UiProjectAccess extends StatefulWidget {
  @override
  _UiProjectAccessState createState() => _UiProjectAccessState();
}

class _UiProjectAccessState extends State<UiProjectAccess> {
  String _selected;

  void _select(String name) => setState(() => _selected = name);

  @override
  Widget build(BuildContext context) {
    // final List<String> _names = context.read<NotifierSystem>().names;
    const double _padding = UiServiceSizing.padding;
    return Consumer<NotifierAccess>(builder: (context, access, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: UiAccessUserList()),
          Container(
            width: 260,
            padding: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding),
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
                UiAccessUserSelect(selected: _selected, select: _select),
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

class UiAccessUserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double _padding = UiServiceSizing.padding;
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.green)),
      padding: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Game access list', style: Theme.of(context).textTheme.headline5),
          DataTable(
            columnSpacing: _padding * 3,
            decoration: BoxDecoration(border: Border.all(width: 2.0)),
            showCheckboxColumn: false,
            sortColumnIndex: 1,
            dataTextStyle: Theme.of(context).textTheme.headline6,
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Translate')),
              DataColumn(label: Text('Invite')),
              DataColumn(label: Text('Manage')),
              DataColumn(label: Text('Admin')),
            ],
            rows: [
              DataRow(
                onSelectChanged: (bool selected) {
                  print('row changed selected');
                },
                selected: true,
                cells: [
                  DataCell(FractionallySizedBox(widthFactor: 1.0, child: Text('User name', maxLines: 1))),
                  DataCell(FractionallySizedBox(
                      widthFactor: 1.0, child: Icon(Icons.check_circle_outline, color: Theme.of(context).buttonColor))),
                  DataCell(FractionallySizedBox(
                      widthFactor: 1.0, child: Icon(Icons.remove_circle_outline, color: Theme.of(context).errorColor))),
                  DataCell(FractionallySizedBox(
                      widthFactor: 1.0, child: Icon(Icons.check_circle_outline, color: Theme.of(context).buttonColor))),
                  DataCell(FractionallySizedBox(
                      widthFactor: 1.0, child: Icon(Icons.remove_circle_outline, color: Theme.of(context).errorColor))),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:localize/ui/utils.dart';

class UiManageHelp extends StatelessWidget {
  final bool firstDone;

  const UiManageHelp({Key key, this.firstDone = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double _padding = UiServiceSizing.padding;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!firstDone)
          RawMaterialButton(
            onPressed: null,
            padding: const EdgeInsets.symmetric(vertical: _padding, horizontal: _padding * 2),
            child: Text('No folder selected', style: Theme.of(context).textTheme.subtitle1),
          ),
        if (!firstDone) const Divider(height: 1.0, thickness: 1.0),
        Row(
          children: [
            Container(child: Text('1. Create folder')),
            if (firstDone) Chip(label: Text('done')),
          ],
        ),
        Container(child: Text('2. Open `Add files` menu')),
        Container(child: Text('3. Load files')),
      ],
    );
  }
}

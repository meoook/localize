import 'package:flutter/material.dart';

class UiFolderScrollItem extends StatelessWidget {
  final String text;

  const UiFolderScrollItem({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _padding = 8.0;
    return Container(
      margin: EdgeInsets.only(right: _padding * 2.5),
      padding: const EdgeInsets.symmetric(horizontal: _padding, vertical: _padding / 2),
      // decoration: BoxDecoration(color: Colors.orange.shade400, borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.folder, size: 40.0),
          Padding(
            padding: const EdgeInsets.only(left: _padding, right: _padding),
            child: Text(text, style: Theme.of(context).textTheme.headline6),
          ),
        ],
      ),
    );
  }
}

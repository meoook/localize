import 'package:flutter/material.dart';
import 'package:localize/model/file.dart';

class UiFileListItem extends StatelessWidget {
  final ModelFile file;

  const UiFileListItem({Key key, this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double _padding = 8.0;
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding),
      padding: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding / 2),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1.0)),
        // boxShadow: [BoxShadow(blurRadius: _padding)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(file.name, style: Theme.of(context).textTheme.headline5),
              Text('${file.progress.last.progress}', style: Theme.of(context).textTheme.headline5),
              // const SizedBox(height: _padding / 1.5),
            ],
          ),
        ],
      ),
    );
  }
}

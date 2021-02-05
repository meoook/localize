import 'package:flutter/material.dart';

class UiFileScrollItem extends StatelessWidget {
  final Map<String, dynamic> post;

  const UiFileScrollItem({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const double _padding = 8.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding),
      padding: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_padding / 2)),
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: [BoxShadow(blurRadius: _padding)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(post["name"], style: Theme.of(context).textTheme.headline5),
              const SizedBox(height: _padding / 1.5),
            ],
          ),
          // Image.asset("assets/images/${post["image"]}", height: double.infinity)
        ],
      ),
    );
  }
}

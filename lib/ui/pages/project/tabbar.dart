import 'package:flutter/material.dart';
import 'package:localize/services/permissions.dart';
import 'package:localize/ui/utils.dart';

class UiProjectTabBar extends StatelessWidget {
  final List<AccessPage> tabs;
  final AccessPage selected;
  final Function callback;

  const UiProjectTabBar({Key key, @required this.tabs, this.selected, this.callback}) : super(key: key);

  String _text(AccessPage page) {
    if (page == AccessPage.FILES) return 'Manage files';
    if (page == AccessPage.ACCESS) return 'Manage access';
    if (page == AccessPage.CHANGE) return 'Game options';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);
    Color _getColor(bool selected) => selected ? Theme.of(context).primaryColor : Theme.of(context).buttonColor;
    return Row(
      mainAxisAlignment: _scale == 1 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (_scale > 1) SizedBox(width: 8.0 * _scale),
        ...tabs
            .map((_e) => TextButton(
                  onPressed: () => callback(_e),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0 * _scale, horizontal: 8.0 * _scale),
                    child: Text(_text(_e),
                        style: Theme.of(context).textTheme.subtitle1.copyWith(color: _getColor(selected == _e)),
                        textScaleFactor: _scale),
                  ),
                ))
            .toList()
      ],
    );
  }
}

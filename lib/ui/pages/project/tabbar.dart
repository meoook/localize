import 'package:flutter/material.dart';
import 'package:localize/services/access.dart';
import 'package:localize/ui/utils.dart';

class UiProjectTabBar extends StatelessWidget {
  final List<AccessPage> tabs;
  final AccessPage selected;
  final Function change;

  const UiProjectTabBar({Key key, @required this.tabs, this.selected, this.change}) : super(key: key);

  String _text(AccessPage page) {
    if (page == AccessPage.MANAGE) return 'Manage files';
    if (page == AccessPage.ACCESS) return 'Manage access';
    if (page == AccessPage.CHANGE) return 'Game options';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final _scale = UiServiceSizing.scale(MediaQuery.of(context).size.width);
    const double _padding = UiServiceSizing.padding;
    var _theme = Theme.of(context);
    Color _getColor(bool selected) => selected ? _theme.primaryColor : _theme.primaryColorLight;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: _padding * _scale * 0.5),
        ...tabs.map(
          (_e) => TextButton(
            onPressed: () => change(_e),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: _padding * _scale, vertical: _padding),
              child: Text(_text(_e), style: _theme.textTheme.headline6.copyWith(color: _getColor(selected == _e))),
            ),
          ),
        )
      ],
    );
  }
}

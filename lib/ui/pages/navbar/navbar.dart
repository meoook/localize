import 'package:flutter/material.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/ui/pages/navbar/avatar.dart';
import 'package:localize/ui/pages/navbar/nav_item.dart';
import 'package:localize/ui/utils.dart';

class UiNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<ModelNavChoice> _choices = NavChoice.values.map((e) => ModelNavChoice(e)).toList();
    final List<ModelNavChoice> _top = _choices.where((element) => !element.bottom).toList();
    final List<ModelNavChoice> _bottom = _choices.where((element) => element.bottom).toList();
    const double _padding = UiServiceSizing.padding;
    return Container(
      width: UiServiceSizing.navbar,
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        boxShadow: [BoxShadow(blurRadius: _padding, offset: Offset(_padding * -0.5, 0.0))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiNavHeader(),
          ..._top.map((e) => UiNavBarItem(navigation: e)),
          const Spacer(),
          const Divider(),
          ..._bottom.map((e) => UiNavBarItem(navigation: e)),
        ],
      ),
    );
  }
}

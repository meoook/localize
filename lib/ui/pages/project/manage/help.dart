import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:localize/ui/utils.dart';

import 'folder_item.dart';
import 'folder_option_item.dart';

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
        Padding(
          padding: const EdgeInsets.only(left: _padding, top: _padding),
          child: Text('To upload new files in the game do', style: Theme.of(context).textTheme.headline6),
        ),
        _HelpStep(
            text: '1 Create new folder',
            title: 'new folder',
            icon: Icons.create_new_folder,
            green: true,
            done: firstDone),
        _HelpStep(text: '2 Open menu to add files', title: 'add files', icon: Icons.file_download),
        _HelpStep(text: '3 Select and load files', title: 'load', icon: Icons.file_download),
        _HelpStep(text: '4 Link repository (optional)', title: 'modify', icon: Icons.edit),
      ],
    );
  }
}

class _HelpStep extends StatelessWidget {
  final String text;
  final String title;
  final IconData icon;
  final bool green;
  final bool done;

  const _HelpStep({Key key, this.text, this.title, this.icon, this.green = false, this.done = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tTheme = Theme.of(context).textTheme;
    const _padding = UiServiceSizing.padding;
    return Container(
      constraints: BoxConstraints(maxHeight: 80.0, maxWidth: 400.0),
      margin: const EdgeInsets.only(left: _padding, top: _padding),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0x16FFFFFF),
      ),
      child: Stack(
        alignment: Alignment(-0.7, 0.0),
        children: [
          Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: _padding * 2),
              Text(text, style: _tTheme.headline6),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: RawMaterialButton(
                  fillColor: green ? Colors.green : Colors.white10,
                  elevation: _padding / 2,
                  padding: const EdgeInsets.symmetric(vertical: _padding, horizontal: _padding * 2),
                  onPressed: null,
                  shape: const StadiumBorder(),
                  textStyle: Theme.of(context).textTheme.subtitle1,
                  child: Row(
                    children: [
                      Icon(icon),
                      SizedBox(width: _padding),
                      Text('$title  ', maxLines: 1),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (done)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      const Color(0xFF111133),
                      const Color(0x33000000),
                    ],
                  ),
                ),
              ),
            ),
          if (done)
            Transform.rotate(
              angle: -0.4,
              child: Container(
                padding: const EdgeInsets.only(left: _padding * 2),
                child: Text('Done', style: TextStyle(fontSize: _padding * 3, letterSpacing: 1.0, color: Colors.green)),
              ),
            ),
        ],
      ),
    );
  }
}

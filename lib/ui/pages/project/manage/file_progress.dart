import 'package:flutter/material.dart';
import 'package:localize/model/progress.dart';
import 'package:localize/ui/components/lang_icon.dart';
import 'package:localize/ui/utils.dart';

class UiFileItemProgress extends StatelessWidget {
  final ModelProgress progress;

  const UiFileItemProgress({Key key, this.progress}) : super(key: key);

  Color get _color {
    if (progress.value >= 100) return Color(0xFF44CC00);
    if (progress.value > 90) return Color(0x8844CC00);
    if (progress.value > 70) return Color(0xFFE0C000);
    if (progress.value > 50) return Color(0xFFCC5500);
    if (progress.value > 30) return Color(0xFFCC3300);
    return Color(0x88FF0000);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UiLanguageIcon(languageID: progress.language),
        const SizedBox(width: UiServiceSizing.padding / 2),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_color),
                value: progress.value / 100,
              ),
              Text('${progress.value}%', style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ],
    );
  }
}

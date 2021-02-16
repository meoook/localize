import 'package:flutter/material.dart';

class UiAddProjectProgress extends StatelessWidget {
  final int step;
  const UiAddProjectProgress({Key key, @required this.step}) : super(key: key);

  static const List<String> _stepNames = ['', 'Game naming', 'Game localize', 'Summary'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Create new game cloud storage', style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: 24.0),
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                  value: 0.25 * step,
                ),
                SizedBox(height: 22.0),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                UiAddProjectStepIcon(name: 'Naming', filled: step > 0, icon: Icons.assignment_outlined),
                UiAddProjectStepIcon(name: 'Language', filled: step > 1, icon: Icons.language),
                UiAddProjectStepIcon(name: 'Finish', filled: step > 2, icon: Icons.library_add_check_outlined),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_stepNames[step], style: Theme.of(context).textTheme.headline6),
            Text('Step: $step', style: Theme.of(context).textTheme.headline6),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class UiAddProjectStepIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool filled;

  const UiAddProjectStepIcon({Key key, this.name, this.icon, this.filled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          borderRadius: BorderRadius.circular(30.0),
          elevation: 12,
          color: filled ? Colors.deepPurple : Colors.grey[1],
          child: SizedBox(
            width: 60.0,
            height: 60.0,
            child: Icon(icon, size: 40.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(name, style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}

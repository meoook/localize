import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'package:localize/ui/utils.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/navigator.dart';
import 'package:localize/notifier/projects.dart';

class UiAddProjectButtons extends StatelessWidget {
  final int step;
  final Function change;
  final ProviderProject project;

  const UiAddProjectButtons({Key key, @required this.step, @required this.change, @required this.project})
      : super(key: key);

  bool get _canNext {
    if (step == 1) return project.checkNaming();
    if (step == 2) return project.checkLocales();
    return true;
  }

  void _prev() => (step > 1) ? change(step - 1) : null;
  void _next() => (step < 3 && _canNext) ? change(step + 1) : null;

  void _finish(BuildContext context) async {
    final ProviderNavigator _navigator = context.read<ProviderNavigator>();

    _navigator.project = null;
    _navigator.navigate(NavChoice.PROJECTS);

    final ModelProject _new = await context.read<NotifierProjects>().create(project);
    if (_new == null)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating game ${project.name}')),
      );

    _navigator.project = _new;
    _navigator.navigate(NavChoice.PROJECTS);
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      // buttonMinWidth: 100.0,
      // buttonHeight: 50.0,
      // buttonPadding: EdgeInsets.symmetric(horizontal: 12.0),
      children: [
        if (step > 1) UiAddProjectButton(text: 'Previous', onPressed: _prev),
        if (step < 3) UiAddProjectButton(text: 'Next', onPressed: _next),
        if (step == 3) UiAddProjectButton(text: 'Finish', onPressed: () => _finish(context)),
      ],
    );
  }
}

class UiAddProjectButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const UiAddProjectButton({Key key, @required this.text, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const _padding = UiServiceSizing.padding;

    return RawMaterialButton(
      fillColor: Theme.of(context).buttonColor,
      hoverColor: Colors.white10,
      splashColor: Theme.of(context).splashColor,
      elevation: _padding / 2,
      padding: const EdgeInsets.symmetric(horizontal: _padding * 2, vertical: _padding / 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_padding / 2)),
      textStyle: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).accentColor),
      onPressed: onPressed,
      child: Text(text, style: Theme.of(context).textTheme.headline5),
    );
  }
}

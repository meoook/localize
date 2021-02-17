import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:localize/notifier/projects.dart';
import 'package:localize/ui/components/project_chars.dart';

class UiAddProjectNaming extends StatefulWidget {
  final ProviderProject project;

  const UiAddProjectNaming({Key key, @required this.project}) : super(key: key);

  @override
  _UiAddProjectNamingState createState() => _UiAddProjectNamingState();
}

class _UiAddProjectNamingState extends State<UiAddProjectNaming> {
  final _namingFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _charsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.project.name;
    _charsController.text = widget.project.iChars;
    // Start listening to changes.
    _nameController.addListener(_handleNameChange);
    _charsController.addListener(_handCharsChange);
    widget.project.setCheck = _canNext;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _charsController.dispose();
    super.dispose();
  }

  void _handleNameChange() {
    String text = _nameController.text.toString();
    _charsController.text = _findIconChars(text);
    widget.project.name = _nameController.text.toString();
    widget.project.iChars = _charsController.text.toString();
    setState(() {});
  }

  void _handCharsChange() => setState(() => widget.project.iChars = _charsController.text.toString());

  bool _canNext() =>
      _nameController.text.isNotEmpty &&
      _charsController.text.isNotEmpty &&
      (_namingFormKey?.currentState?.validate() ?? false);

  @override
  Widget build(BuildContext context) {
    final List<String> _names = context.read<NotifierProjects>().names;
    return Form(
      key: _namingFormKey,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            autofocus: true,
            controller: _nameController,
            // keyboardType: TextInputType.text,
            validator: (name) {
              Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(name))
                return 'Invalid project name';
              else if (_names.contains(name))
                return 'Game with this name already exist';
              else
                return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.title),
              labelText: "Project name",
              // errorText: context.select((AuthUser user) => user.error),
              helperText: "Enter your project name here",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(flex: 1, child: const SizedBox()),
              UiProjectIconChars(
                iChars: _charsController.text.length > 0 ? _charsController.text : 'xx',
                scale: 3,
              ),
              Expanded(flex: 2, child: const SizedBox()),
              Expanded(
                flex: 4,
                child: TextFormField(
                  maxLength: 2,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  controller: _charsController,
                  keyboardType: TextInputType.text,
                  validator: (chars) {
                    Pattern pattern = r'^[A-Za-z0-9]{1,2}$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(chars))
                      return 'Invalid icon chars';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    // prefixIcon: Icon(Icons.check_box_outline_blank),
                    prefixText: "Letters for icon: ",
                    // labelText: "Chars for icon",
                    helperText: "Enter 2 letters for icon",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String _findIconChars(String stringVal) {
  String reVal;
  RegExp regex = new RegExp(r'[A-Z]{2,}');
  if (regex.hasMatch(stringVal)) {
    regex = new RegExp(r'[A-Z]');
    var chars = regex.allMatches(stringVal).toList();
    reVal = '${chars[0].group(0)}${chars[1].group(0)}';
  } else {
    var words = stringVal.split(' ');
    if (words.length >= 2 && words[1].length > 0) {
      reVal = '${words[0][0]}${words[1][0]}';
    } else if (stringVal.length >= 2)
      reVal = '${stringVal[0]}${stringVal[1]}';
    else
      reVal = stringVal;
  }
  return reVal;
}

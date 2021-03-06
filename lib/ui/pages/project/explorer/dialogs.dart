import 'package:flutter/material.dart';

// class CustomDialog extends PopupRoute {
//   @override
//   Color get barrierColor => Colors.transparent;
//
//   @override
//   bool get barrierDismissible => true;
//
//   @override
//   String get barrierLabel => null;
//
//   @override
//   Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//     return _builder(context);
//   }
//
//   Widget _builder(BuildContext context) {
//     return Container(child: Text('Any text'));
//   }
//
//   @override
//   Duration get transitionDuration => Duration(milliseconds: 300);
// }

Future<void> folderCreateDialog(BuildContext context, Function submit) async {
  String _value = '';
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create new folder'),
        elevation: 24.0,
        // backgroundColor: Colors.green,
        // buttonPadding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        actions: [
          OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
          ElevatedButton(onPressed: () => submit(_value), child: Text("Create"))
        ],
        content: TextField(
          autofocus: true,
          onChanged: (value) => _value = value,
          onSubmitted: (String value) => submit(value),
          decoration: InputDecoration(hintText: "Enter folder name"),
        ),
      );
    },
  );
}

Future<void> warningDeleteDialog(BuildContext context, Function submit, String type, String name) async {
  void _submit() {
    submit();
    Navigator.of(context).pop();
  }

  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        titleTextStyle: Theme.of(context).textTheme.headline4.copyWith(color: Colors.red),
        title: Text('Warning'),
        elevation: 24.0,
        // backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        actions: [
          OutlinedButton(
            onPressed: _submit,
            child: Text("Delete", style: TextStyle(color: Theme.of(context).errorColor)),
          ),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
        ],
        content: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline5,
            text: 'Are you sure to delete',
            children: [
              TextSpan(text: ' $type', style: TextStyle(fontStyle: FontStyle.italic)),
              TextSpan(text: '\n$name', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      );
    },
  );
}

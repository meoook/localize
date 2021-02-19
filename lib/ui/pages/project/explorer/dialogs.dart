import 'package:flutter/material.dart';

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
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
          TextButton(onPressed: () => submit(_value), child: Text("Create"))
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
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text("Cancel")),
          TextButton(onPressed: _submit, child: Text("Delete", style: TextStyle(color: Theme.of(context).errorColor)))
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

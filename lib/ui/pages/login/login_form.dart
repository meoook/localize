import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize/generated/l10n.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/ui/image/rive_image.dart';
import 'package:provider/provider.dart';

class UiLoginForm extends StatefulWidget {
  @override
  _UiLoginFormState createState() => _UiLoginFormState();
}

class _UiLoginFormState extends State<UiLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool displayError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState.validate()) {
      context.read<NotifierSystem>().login(username: _usernameController.text, password: _passwordController.text);
      displayError = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).login_try_login)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _status = context.watch<NotifierSystem>().status;
    return Container(
      width: 350,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: GestureDetector(
                onTap: () {
                  print('Logo clicked');
                },
                child: RiveImage(path: 'assets/rive/logo.riv', animation: 'go'),
              ),
            ),
            const SizedBox(height: 60),
            TextFormField(
              onChanged: (String text) => displayError = false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              validator: (name) {
                if (displayError && _status == ApiStatus.ERROR) return S.of(context).login_err_incorrect;
                if (name.isEmpty) return S.of(context).login_err_empty;
                Pattern pattern = r'^[A-Za-z0-9\-\_\ ]+$';
                RegExp regex = new RegExp(pattern);
                return !regex.hasMatch(name) ? S.of(context).login_err_invalid_user : null;
              },
              autofocus: true,
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                labelText: S.of(context).login_field_user,
                helperText: S.of(context).login_help_user,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              onChanged: (String text) => displayError = false,
              textInputAction: TextInputAction.done,
              validator: (password) {
                Pattern pattern = r'^.*$'; // no space
                RegExp regex = new RegExp(pattern);
                return !regex.hasMatch(password) ? S.of(context).login_err_invalid_pwd : null;
              },
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded),
                labelText: S.of(context).login_field_pwd,
              ),
            ),
            const SizedBox(height: 12),
            ButtonBar(
              children: [
                TextButton(
                  child: Text(S.of(context).login_forgot),
                  onPressed: () => {},
                ),
                // OutlineButton(
                //   child: new Text('Register'),
                //   onPressed: () => {},
                // ),
                ElevatedButton(
                  autofocus: true,
                  onPressed: _onLogin,
                  child: Text(S.of(context).login_submit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

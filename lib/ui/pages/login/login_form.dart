import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize/notifier/runner.dart';
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
      context.read<NotifierRunner>().login(username: _usernameController.text, password: _passwordController.text);
      displayError = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Try to login...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _status = context.watch<NotifierRunner>().status;
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
                if (displayError && _status == ApiStatus.ERROR) return 'User name or password incorrect';
                if (name.isEmpty) return 'Username can\'t be empty';
                Pattern pattern = r'^[A-Za-z0-9\-\_\ ]+$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(name))
                  return 'Invalid username';
                else
                  return null;
              },
              autofocus: true,
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                labelText: "Username",
                // errorText: context.select((AuthUser user) => user.error),
                helperText: "Enter your username or email here",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              onChanged: (String text) => displayError = false,
              textInputAction: TextInputAction.done,
              validator: (password) {
                Pattern pattern = r'^.*$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(password))
                  return 'Invalid password';
                else
                  return null;
              },
              controller: _passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20.0),
                prefixIcon: Icon(Icons.lock_outline_rounded),
                labelText: "Password",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
            ),
            const SizedBox(height: 12),
            ButtonBar(
              buttonMinWidth: 100.0,
              buttonHeight: 40.0,
              // buttonPadding: EdgeInsets.all(12.0),
              children: [
                TextButton(
                  child: Text('Forgot password ?'),
                  onPressed: () => {},
                ),
                // OutlineButton(
                //   child: new Text('Register'),
                //   onPressed: () => {},
                // ),
                ElevatedButton(
                  autofocus: true,
                  onPressed: _onLogin,
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

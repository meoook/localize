import 'package:flutter/material.dart';
import 'package:localize/ui/pages/login/login_form.dart';

class UiPageLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Abyss localize")),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Expanded(
                  child: SizedBox(),
                  flex: 1,
                ),
                UiLoginForm(),
                Expanded(
                  child: SizedBox(),
                  flex: 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

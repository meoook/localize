import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localize/notifier/runner.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/theme.dart';
import 'package:localize/ui/pages/login/login.dart';
import 'package:localize/ui/pages/splash.dart';
import 'package:localize/ui/pages/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // setWindowTitle('App title');
    setWindowMinSize(const Size(800, 700));
    setWindowMaxSize(Size.infinite);
  }
  runApp(
    ChangeNotifierProvider<NotifierRunner>(
      create: (_) => NotifierRunner(),
      child: AppRunner(),
    ),
  );
}

class AppRunner extends StatelessWidget {
  Widget _displayWidget(BuildContext context, ApiStatus status) {
    if (status == ApiStatus.OK) return UiPageNavWrapper();
    if (status == ApiStatus.NO) return SplashScreen(noConnection: true);
    if (status == ApiStatus.ERROR) return UiPageLogin();
    return SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotifierRunner>(builder: (context, state, child) {
      return MaterialApp(
        theme: state.options.theme ? applicationThemeLight : applicationThemeDark,
        home: SafeArea(
          child: _displayWidget(context, state.status),
        ),
      );
    });
  }
}

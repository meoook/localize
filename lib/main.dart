import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localize/notifier/system.dart';
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
    setWindowMinSize(const Size(800, 750));
    setWindowMaxSize(Size.infinite);
  }
  runApp(
    ChangeNotifierProvider<NotifierSystem>(
      create: (_) => NotifierSystem(),
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
    return Consumer<NotifierSystem>(builder: (context, runner, _) {
      return MaterialApp(
        theme: runner.options.theme ? applicationThemeLight : applicationThemeDark,
        home: SafeArea(
          child: _displayWidget(context, runner.status),
        ),
      );
    });
  }
}

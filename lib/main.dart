import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'package:localize/notifier/system.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/theme.dart';
import 'package:localize/ui/pages/login/login.dart';
import 'package:localize/ui/pages/splash.dart';
import 'package:localize/ui/pages/wrapper.dart';

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
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          S.delegate,
          // Provides localized strings and other values for the Material Components library
          GlobalMaterialLocalizations.delegate,
          // Defines the default text direction, either left-to-right or right-to-left, for the widgets library
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: SafeArea(
          child: _displayWidget(context, runner.status),
        ),
      );
    });
  }
}

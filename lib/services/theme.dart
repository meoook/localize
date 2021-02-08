import 'package:flutter/material.dart';

import 'constants.dart';

// Brand color 0xFF7545D2 (116, 69, 226)
Map<int, Color> _brandMap = {
  50: Color(0xAA7545D2),
  100: Color(0xBB7545D2),
  200: Color(0xCC7545D2),
  300: Color(0xDD7545D2),
  400: Color(0xEE7545D2),
  500: Color(0xFF8645E2),
  600: Color(0xFF9655F2),
  700: Color(0xFFA665F2),
  800: Color(0xFFB675F2),
  900: Color(0xFFB695F2),
};
Map<int, Color> _grayMap = {
  50: Color(0xFF404040),
  100: Color(0xFF4F4F4F),
  200: Color(0xFF5E5E5E),
  300: Color(0xFF6D6D6D),
  400: Color(0xFF7C7C7C),
  500: Color(0xFF8B8B8B),
  600: Color(0xFF9A9A9A),
  700: Color(0xFFAAAAAA),
  800: Color(0xFFBBBBBB),
  900: Color(0xFFCCCCCC),
};

ThemeData applicationThemeDark = ThemeData(
  brightness: Brightness.dark,
  // colorScheme: ColorScheme(),
  primaryColor: Color(0xFFFFFFFF), // Background primary
  accentColor: Color(0xFF7545D2), // Active elements
  // backgroundColor: Color(0xFF2A2A32),
  scaffoldBackgroundColor: Color(0xFF2A2A32),
  dialogBackgroundColor: Color(0xFF202029),
  secondaryHeaderColor: Color(0xFF23232B),
  // accentColor: MaterialColor(0xFF7545D2, _brandMap), // Active elements
  // buttonColor: Color(0xFFAAAAAA),
  // primarySwatch: Colors.deepPurple, // text buttons and so on (only material colors)
  primarySwatch: MaterialColor(0xFFCCCCCC, _grayMap),
  fontFamily: fontNameDefault,
  // textTheme: _textTheme,
);

ThemeData applicationThemeLight = ThemeData(
  brightness: Brightness.light,
  // primaryColor: Color(0xFF4899FE),
  primaryColor: Color(0xFF7545D2),
  accentColor: Color(0xFF05E5C2), // Active elements
  backgroundColor: Color(0xFFCCCCCC),
  primarySwatch: MaterialColor(0xFF6D6D6D, _grayMap),
  // primaryColor: Color.fromRGBO(0, 0, 0, 1.0),
  // scaffoldBackgroundColor: backgroundColor,
  // bottomAppBarColor: Colors.deepPurple,
  // primaryColorLight: Color.fromRGBO(222, 222, 222, 1.0),
  // primaryColorDark: Color.fromRGBO(111, 111, 111, 1.0),
  // canvasColor: Color.fromRGBO(255, 0, 0, 1.0),
  // shadowColor: Color.fromRGBO(0, 0, 0, 1.0),
  // cardColor: Colors.orange.shade100,
  //
  fontFamily: fontNameDefault,
  // textTheme: _textTheme,

  // primaryIconTheme: IconThemeData(
  //   color: Colors.red,
  //   size: 24,
  // ),

  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Colors.red, foregroundColor: Colors.white),

  // buttonTheme: ButtonThemeData(
  //   height: 50,
  //   buttonColor: Colors.blue,
  //   textTheme: ButtonTextTheme.accent,
  // ),
  // visualDensity: VisualDensity.adaptivePlatformDensity,
);

TextTheme _textTheme = TextTheme(
  headline1: TextStyle(
    fontSize: 72,
    letterSpacing: 2,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [Shadow(color: Colors.black12, offset: Offset(2, 1))],
  ),
  headline2: TextStyle(
    fontSize: 46,
    letterSpacing: 2,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [Shadow(color: Colors.black12, offset: Offset(2, 1))],
  ),
  headline3: TextStyle(
    // Screen headline
    fontFamily: fontNameTitle,
    fontSize: mediumTextSize,
    fontWeight: FontWeight.w800,
  ),
  headline4: TextStyle(
    // Main section size
    fontFamily: fontNameTitle,
    fontSize: mediumTextSize,
    fontWeight: FontWeight.w800,
    color: Colors.red,
  ),
  headline6: TextStyle(
      // AppBar title
      fontFamily: fontNameTitle,
      fontSize: mediumTextSize,
      color: Colors.purple),
  bodyText1: TextStyle(fontFamily: fontNameDefault, fontSize: bodyTextSize, color: Colors.green),
);

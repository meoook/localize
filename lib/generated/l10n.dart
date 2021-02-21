// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Games`
  String get nav_games {
    return Intl.message(
      'Games',
      name: 'nav_games',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get nav_add {
    return Intl.message(
      'Add',
      name: 'nav_add',
      desc: '',
      args: [],
    );
  }

  /// `Last file`
  String get nav_last {
    return Intl.message(
      'Last file',
      name: 'nav_last',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get nav_options {
    return Intl.message(
      'Options',
      name: 'nav_options',
      desc: '',
      args: [],
    );
  }

  /// `Sing out`
  String get nav_logout {
    return Intl.message(
      'Sing out',
      name: 'nav_logout',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get login_field_user {
    return Intl.message(
      'Username',
      name: 'login_field_user',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_field_pwd {
    return Intl.message(
      'Password',
      name: 'login_field_pwd',
      desc: '',
      args: [],
    );
  }

  /// `Enter your username or email here`
  String get login_help_user {
    return Intl.message(
      'Enter your username or email here',
      name: 'login_help_user',
      desc: '',
      args: [],
    );
  }

  /// `Username can't be empty`
  String get login_err_empty {
    return Intl.message(
      'Username can\'t be empty',
      name: 'login_err_empty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username`
  String get login_err_invalid_user {
    return Intl.message(
      'Invalid username',
      name: 'login_err_invalid_user',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password`
  String get login_err_invalid_pwd {
    return Intl.message(
      'Invalid password',
      name: 'login_err_invalid_pwd',
      desc: '',
      args: [],
    );
  }

  /// `User name or password incorrect`
  String get login_err_incorrect {
    return Intl.message(
      'User name or password incorrect',
      name: 'login_err_incorrect',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get login_submit {
    return Intl.message(
      'Submit',
      name: 'login_submit',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get login_forgot {
    return Intl.message(
      'Forgot password?',
      name: 'login_forgot',
      desc: '',
      args: [],
    );
  }

  /// `Try to login`
  String get login_try_login {
    return Intl.message(
      'Try to login',
      name: 'login_try_login',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
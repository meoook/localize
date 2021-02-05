import 'dart:async';
import 'package:localize/services/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum OptionKey { TOKEN, THEME, FONT, LANGUAGE }

extension StringOptionExtension on OptionKey {
  String get text => this.toString().split('.').last;
}

class ModelOptions {
  String token; // Secret token - remove from options
  String language = 'English'; // App language
  double font = 16.0; // Font size
  bool theme = false; // Use light theme
}

class ServiceOptions {
  // TODO: Make with Hive
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ModelOptions _options = ModelOptions();
  ModelOptions get options => _options;

  Future<void> optionChange(OptionKey key, dynamic value) async {
    logger.i('Options ${key.text} changed to $value');
    final SharedPreferences prefs = await _prefs;
    if (key == OptionKey.TOKEN) await prefs.setString(key.text, value).then((val) => _options.token = value);
    if (key == OptionKey.LANGUAGE) await prefs.setString(key.text, value).then((val) => _options.language = value);
    if (key == OptionKey.FONT) await prefs.setDouble(key.text, value).then((val) => _options.font = value);
    if (key == OptionKey.THEME) await prefs.setBool(key.text, value).then((val) => _options.theme = value);
  }

  Future<void> optionInit() async {
    final SharedPreferences prefs = await _prefs;
    _options.token = prefs.getString(OptionKey.TOKEN.text) ?? _options.token;
    _options.font = prefs.getDouble(OptionKey.FONT.text) ?? _options.font;
    _options.theme = prefs.getBool(OptionKey.THEME.text) ?? _options.theme;
    _options.language = prefs.getString(OptionKey.LANGUAGE.text) ?? _options.language;
    logger.i('Options init\nlanguage: ${_options.language}\ntoken: ${_options.token}'
        '\nfont: ${_options.font}\ntheme: ${_options.theme ? 'light' : 'dark'}');
  }
}

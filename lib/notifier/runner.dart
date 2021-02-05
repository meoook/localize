import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localize/model/language.dart';
import 'package:localize/model/user.dart';

import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';
import 'package:localize/services/options.dart';

class NotifierRunner with ChangeNotifier {
  List<ModelLanguage> _languages;
  ModelUser _user;
  ApiStatus _status = ApiStatus.ERROR; // Auth status
  final _http = ServiceHttpClient();
  final ServiceOptions _options = ServiceOptions();

  ModelUser get user => _user;
  ApiStatus get status => _status;
  List<ModelLanguage> get languages => _languages;
  ModelOptions get options => _options.options;
  ServiceHttpClient get http => _http;
  NotifierRunner() {
    _startApp();
  }

  void option(OptionKey key, dynamic value) async {
    if (key == OptionKey.TOKEN) throw 'Token is not an option';
    await _options.optionChange(key, value);
    notifyListeners();
  }

  Future<void> _startApp() async {
    logger.d('Initialize application...');
    await _options.optionInit();
    if (_options.options.token != null && _options.options.token.isNotEmpty) await _auth(_options.options.token);
    if (_user != null) await _languagesGet();
    if (_languages != null) notifyListeners();
  }

  Future<void> _languagesGet() async {
    logger.d('Initialize languages...');
    ApiResponse _response = await _http.get('lang');
    if (_response.status == ApiStatus.OK) {
      final _parsed = _response.json.cast<Map<String, dynamic>>();
      _languages = _parsed.map<ModelLanguage>((json) => ModelLanguage.fromJson(json)).toList();
      logger.i('Get ${_languages.length} languages');
    } else {
      logger.w('Get languages ${_response.message}');
    }
  }

  Future<void> _auth(String token) async {
    if (token == null) throw 'set token for auth';
    logger.d('Auth user with token $token');
    _http.token = token;
    ApiResponse _response = await _http.get('auth/user');
    _status = _response.status;
    if (_status == ApiStatus.OK)
      _user = ModelUser.fromJson(_response.json);
    else {
      _http.token = null;
      await _options.optionChange(OptionKey.TOKEN, null);
    }
    logger.i('After auth - $user');
  }

  void login({String username, String password}) async {
    logger.d('Try to login with $username $password');
    _status = ApiStatus.LOADING;
    notifyListeners();
    // var _payload = {"username": username, "password": password};
    var _payload = {"username": "0748-acc5-4c08-f229", "password": "lol"};
    ApiResponse _response = await _http.post('auth/login', data: _payload);
    _status = _response.status;
    if (_status == ApiStatus.OK) {
      _user = ModelUser.fromJson(_response.json);
      _http.token = _user.token;
      await _options.optionChange(OptionKey.TOKEN, _user.token);
      await _languagesGet();
    }
    logger.i('After login - $user');
    notifyListeners();
  }

  void reset() {
    // Go to login page (from err connection page)
    _status = ApiStatus.ERROR;
    notifyListeners();
  }

  void logout() async {
    logger.i('User ${user.name} logout');
    await _options.optionChange(OptionKey.TOKEN, null);
    ApiResponse _response = await http.post('auth/logout');
    _http.token = null;
    if (_response.status != ApiStatus.OK) logger.e('Logout err ${_response.message}');
    _user = null;
    _status = ApiStatus.ERROR;
    this.reset();
  }
}

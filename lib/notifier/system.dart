import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localize/model/language.dart';
import 'package:localize/model/user.dart';

import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';
import 'package:localize/services/options.dart';

class NotifierSystem with ChangeNotifier {
  final ServiceHttpClient http = ServiceHttpClient();
  final ServiceOptions _options = ServiceOptions();
  ApiStatus _status = ApiStatus.ERROR; // Auth status
  ModelUser _user;
  List<ModelLanguage> _languages;

  ApiStatus get status => _status;
  ModelUser get user => _user;
  List<ModelLanguage> get languages => _languages;
  ModelOptions get options => _options.options;

  NotifierSystem() {
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
    ApiResponse _response = await http.get('lang');
    if (_response.status == ApiStatus.OK) {
      _languages = await compute(_isolate, _response.data);
      logger.i('Get ${_languages.length} languages');
    } else {
      logger.w('Get languages ${_response.message}');
    }
  }

  static List<ModelLanguage> _isolate(String data) {
    var _json = jsonDecode(data);
    return List.from(_json).map((e) => ModelLanguage.fromJson(e)).toList();
  }

  Future<void> _auth(String token) async {
    if (token == null) throw 'set token for auth';
    logger.d('Auth user with token $token');
    http.token = token;
    ApiResponse _response = await http.get('auth/user');
    _status = _response.status;
    if (_status == ApiStatus.OK)
      _user = ModelUser.fromJson(_response.json);
    else {
      http.token = null;
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
    ApiResponse _response = await http.post('auth/login', data: _payload);
    _status = _response.status;
    if (_status == ApiStatus.OK) {
      _user = ModelUser.fromJson(_response.json);
      http.token = _user.token;
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
    http.token = null;
    if (_response.status != ApiStatus.OK) logger.e('Logout err ${_response.message}');
    _user = null;
    _status = ApiStatus.ERROR;
    this.reset();
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'constants.dart';
import 'logger.dart';

enum ApiStatus { LOADING, OK, ERROR, NO }

extension StringResponseStatus on ApiStatus {
  String get text => this.toString().split('.').last;
}

class ApiResponse {
  ApiStatus _status = ApiStatus.LOADING;
  int _code;
  String _message = 'loading...';
  String _data;

  ApiStatus get status => _status;
  int get code => _code;
  String get message => _message;
  String get data => _data;
  dynamic get json => data != null ? jsonDecode(_data) : null;

  ApiResponse.noConnect() {
    logger.w('Request connection error');
    _message = 'connection error';
    _status = ApiStatus.NO;
  }
  ApiResponse.exception(String error) {
    logger.wtf('Request unknown error', error);
    _message = _cut(error);
    _status = ApiStatus.NO;
  }

  ApiResponse(http.Response response) {
    _code = response.statusCode;
    _data = response.body.isNotEmpty ? response.body : '';
    if (_code < 300) {
      _status = ApiStatus.OK;
    } else {
      logger.w('Request error code $_code body ${_cut(_data)}');
      _status = ApiStatus.ERROR;
      if (code == 403)
        _message = 'auth error';
      else if (code == 404)
        _message = 'not found error';
      else
        _message = 'request error code $_code';
    }
  }

  String _cut(String message) => message.length > 50 ? message.substring(0, message.length - 3) + '...' : message;

  @override
  String toString() => "Status $status\nCode $_code\nMessage $message\n";
}

class ServiceHttpClient {
  /// Http service with [token] control and return [ApiResponse]
  final Map<String, String> _contentTypeHeader = {HttpHeaders.contentTypeHeader: ContentType.json.toString()};
  Map<String, String> _headers = {HttpHeaders.contentTypeHeader: ContentType.json.toString()};
  Map<String, String> _authHeader;

  String _token;

  set token(String token) {
    if (token != null && token.isNotEmpty) {
      logger.i('Token set in HTTP Client $token');
      _token = token;
      _authHeader = {HttpHeaders.authorizationHeader: "Token $_token"};
    } else {
      logger.w('Token reset in HTTP Client');
      _token = null;
      _authHeader = {};
    }
    _headers = {..._authHeader, ..._contentTypeHeader};
  }

  Future<ApiResponse> get(String url, {Map<String, String> params}) async {
    final _uri = '$apiUrlAddress/$url' + this._queryParameters(params);
    logger.d('Api GET $_uri');
    try {
      final _response = await http.get(_uri, headers: _headers);
      return ApiResponse(_response);
    } on SocketException {
      return ApiResponse.noConnect();
    } catch (e) {
      return ApiResponse.exception(e);
    }
  }

  Future<ApiResponse> post(String url, {dynamic data}) async {
    final String _uri = '$apiUrlAddress/$url';
    return _putOrPost(_uri, data);
  }

  Future<ApiResponse> put(String url, {dynamic data}) async {
    final String _uri = '$apiUrlAddress/$url';
    return _putOrPost(_uri, data, isPut: true);
  }

  Future<ApiResponse> _putOrPost(String uri, data, {bool isPut = false}) async {
    logger.d('Api ${isPut ? 'PUT' : 'POST'} $uri', data);
    try {
      // final _payload = data != null ? jsonEncode(data) : jsonEncode({'any': 'data'});
      final _payload = jsonEncode(data);
      final _response = await http.post(uri, headers: _headers, body: _payload);
      return ApiResponse(_response);
    } on SocketException {
      return ApiResponse.noConnect();
    } catch (e) {
      return ApiResponse.exception(e);
    }
  }

  Future<ApiResponse> delete(String url) async {
    final String _uri = '$apiUrlAddress/$url';
    logger.d('Api DELETE $_uri');
    try {
      final _response = await http.delete(_uri, headers: _headers);
      return ApiResponse(_response);
    } on SocketException {
      return ApiResponse.noConnect();
    } catch (e) {
      return ApiResponse.exception(e);
    }
  }

  String _queryParameters(Map<String, String> params) {
    if (params == null) return "";
    final _jsonString = Uri(queryParameters: params);
    return '?${_jsonString.query}';
  }
}

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
  var _json;

  ApiStatus get status => _status;
  int get code => _code;
  String get message => _message;
  get json => _json;

  ApiResponse.noConnect() {
    logger.w('Request connection error');
    _message = 'connection error';
    _status = ApiStatus.NO;
  }

  ApiResponse(http.Response response) {
    _code = response.statusCode;
    if (_code < 300) {
      _status = ApiStatus.OK;
      _json = response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      logger.w('Request error code $_code'); // TODO: No info about body
      _status = ApiStatus.ERROR;
      if (code == 403)
        _message = 'auth error';
      else if (code == 404)
        _message = 'not found error';
      else
        _message = 'request error code $_code';
    }
  }

  @override
  String toString() => "Status $status\nCode $_code\nMessage $message\n";
}

class ServiceHttpClient {
  // With token control
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
    }
  }

  Future<ApiResponse> post(String url, {dynamic data}) async {
    final String _uri = '$apiUrlAddress/$url';
    logger.d('Api POST $_uri', data);
    try {
      // final _payload = data != null ? jsonEncode(data) : jsonEncode({'any': 'data'});
      final _payload = jsonEncode(data);
      final _response = await http.post(_uri, headers: _headers, body: _payload);
      return ApiResponse(_response);
    } on SocketException {
      return ApiResponse.noConnect();
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
    }
  }

  // Private methods
  String _queryParameters(Map<String, String> params) {
    if (params == null) return "";
    final _jsonString = Uri(queryParameters: params);
    return '?${_jsonString.query}';
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

// FIXME: this class not finished
class UserAccess {
  final String name;
  int admin;
  int manage;
  int invite;
  int translate;

  UserAccess(this.name, List<dynamic> permissions) {
    permissions.forEach((e) {
      if (e['permission'] == nTranslate) translate = e['id'];
      if (e['permission'] == nInvite) invite = e['id'];
      if (e['permission'] == nManage) manage = e['id'];
      if (e['permission'] == nAdmin) admin = e['id'];
    });
  }
  static const int nTranslate = 0;
  static const int nInvite = 5;
  static const int nManage = 8;
  static const int nAdmin = 9;
}

// Notifier
class NotifierAccess with ChangeNotifier {
  final ServiceHttpClient _http;
  final String _projectID;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;

  List<UserAccess> _usersAccess = [];
  List<UserAccess> get list => _usersAccess;
  UserAccess byName(String name) =>
      _usersAccess.firstWhere((element) => element.name == name, orElse: () => UserAccess(name, []));

  NotifierAccess(this._http, this._projectID) {
    _get();
  }

  Future<void> _get() async {
    logger.d('Try to get access list for project $_projectID');
    ApiResponse _response = await _http.get('prj/perm', params: {'save_id': _projectID});
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      _usersAccess = await compute(_isolate, _response.data);
      logger.i('Get ${_usersAccess.length} users access for project $_projectID');
    } else {
      logger.w('Get access ${_response.message}');
    }
    notifyListeners();
  }

  static List<UserAccess> _isolate(String data) {
    var _json = jsonDecode(data);
    var _list = List.from(_json).map((e) => UserAccess(e['first_name'], e['prj_perms'])).toList();
    _list.sort((a, b) => a.name.compareTo(b.name));
    return _list;
  }

  void create(String name, int lvl) {
    logger.i('Try to set permission level $lvl to $name for project $_projectID');
  }

  void delete(int permissionID) {
    logger.i('Try to remove permission with id in project $_projectID');
  }

// void change(ModelFile file) async {
  //   // TODO - finish
  //   final ModelFile _before = _files.firstWhere((element) => element.id == file.id);
  //   if (_before == null) return;
  //   logger.i('Changing $_before name to ${file.name}');
  //   ApiResponse _response = await _http.put('prj/file/${file.id}/', data: {'name': file.name});
  // }
  //
  // void delete(ModelFile file) async {
  //   logger.d('Delete $file');
  //   ApiResponse _response = await _http.delete('prj/folder/${file.id}/');
  //   if (_response.status == ApiStatus.OK) {
  //     logger.i('File ${file.name} deleted');
  //     _files.remove(file);
  //     // _folders.sort((a, b) => a.position.compareTo(b.position));
  //     // _selected = _folders.isNotEmpty ? _folders.first : null;
  //     notifyListeners();
  //   } else {
  //     logger.w('Delete $file fail - ${_response.message}');
  //   }
  // }
}

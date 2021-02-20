import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';
import 'package:localize/services/access.dart';

// FIXME: this class not finished
class _Access {
  final String userName;
  final List<_Perm> permissions;

  static AccessLevel _getLvl(int permissionNumber) {
    if (permissionNumber == 9) return AccessLevel.ADMIN;
    if (permissionNumber == 8) return AccessLevel.MANAGE;
    if (permissionNumber == 5) return AccessLevel.INVITE;
    if (permissionNumber == 0) return AccessLevel.TRANSLATE;
    return null;
  }

  _Access(this.userName, List<dynamic> permissions)
      : permissions = permissions.map((e) => _Perm(e['id'], _getLvl(e['permission']))).toList();
}

class _Perm {
  final int id;
  final AccessLevel lvl;

  _Perm(this.id, this.lvl);

  bool get isOwner => lvl == AccessLevel.OWNER;
  bool get isAdmin => lvl == AccessLevel.ADMIN;
  bool get isManager => lvl == AccessLevel.MANAGE;
  bool get isInviter => lvl == AccessLevel.INVITE;
}

// Notifier
class NotifierAccess with ChangeNotifier {
  final ServiceHttpClient _http;
  final String _projectID;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;

  List<_Access> _usersAccess = [];
  List<_Access> get list => _usersAccess;

  NotifierAccess(this._http, this._projectID) {
    _get();
  }

  Future<void> _get() async {
    logger.d('Get access list for project $_projectID');
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

  static List<_Access> _isolate(String data) {
    var _json = jsonDecode(data);
    var _list = List.from(_json).map((e) => _Access(e['first_name'], e['prj_perms'])).toList();
    _list.sort((a, b) => a.userName.compareTo(b.userName));
    return _list;
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
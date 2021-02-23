import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:localize/model/access.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

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

  void create(UserAccess user, int lvl) async {
    logger.d('Try to set permission level $lvl to ${user.name} for project $_projectID');
    var _data = <String, String>{'save_id': _projectID, 'first_name': user.name, 'permission': '$lvl'};
    ApiResponse _response = await _http.post('prj/perm/', data: _data);
    if (_response.status == ApiStatus.OK) {
      int _permID = _response.json['id'];
      user.add(lvl, _permID);
      int idx = _usersAccess.indexWhere((_e) => _e.name == user.name);
      if (idx == -1)
        _usersAccess.add(user);
      else
        _usersAccess[idx] = user;
      logger.i('Permission with id $_permID lvl $lvl created for ${user.name} in project $_projectID');
      notifyListeners();
    } else {
      logger.w('Permission add fail - ${_response.message}');
    }
  }

  void delete(UserAccess user, int permID) async {
    logger.d('Try to remove permission with id in project $_projectID');
    ApiResponse _response = await _http.delete('prj/perm/$permID/');
    if (_response.status == ApiStatus.OK) {
      user.remove(permID);
      if (user.noAccess) {
        logger.i('User ${user.name} have no more access to project $_projectID');
        _usersAccess.remove(user);
      } else {
        logger.i('Permission with id $permID deleted for user ${user.name} in project $_projectID');
      }
      notifyListeners();
    } else {
      logger.w('Permission $permID delete fail - ${_response.message}');
    }
  }
}

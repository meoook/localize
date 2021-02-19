import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

class NotifierFolders with ChangeNotifier {
  final ServiceHttpClient _http;

  final String _projectID;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;

  ModelFolder _selected;
  ModelFolder get selected => _selected;
  set selected(ModelFolder folder) {
    if (_selected == folder) return;
    _selected = folder;
    logger.d('Changing selected folder to $folder');
    notifyListeners();
  }

  List<ModelFolder> _folders;
  List<ModelFolder> get list => _folders;
  List<String> get names => _folders.map((e) => e.name).toList();

  // FIXME: not used
  ModelFolder byID(int folderID) => _folders?.firstWhere((_e) => _e.id == folderID);

  NotifierFolders(this._http, this._projectID) {
    if (_projectID != null)
      this._get();
    else
      logger.w('Can\'t request folders if no project');
  }

  Future<void> _get() async {
    logger.d('Try to get folders for project $_projectID');
    ApiResponse _response = await _http.get('prj/folder', params: {'save_id': _projectID});
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      _folders = await compute(_isolate, _response.data);
      _selected ??= _folders.isNotEmpty ? _folders.first : null;
      logger.i('Get ${_folders.length} folders');
    } else {
      logger.w('Get folders ${_response.message}');
    }
    notifyListeners();
  }

  static List<ModelFolder> _isolate(String data) {
    var _json = jsonDecode(data);
    var _list = List.from(_json).map((e) => ModelFolder.fromJson(e)).toList();
    _list.sort((a, b) => a.position.compareTo(b.position));
    return _list;
  }

  void create(String name) async {
    logger.d('Try to create folder $name for project $_projectID');
    ApiResponse _response = await _http.post('prj/folder/', data: {'save_id': _projectID, 'name': name});
    if (_response.status == ApiStatus.OK) {
      ModelFolder _folder = ModelFolder.fromJson(_response.json);
      _folders.add(_folder);
      _folders.sort((a, b) => a.position.compareTo(b.position));
      _selected = _folder;
      logger.i('Created $_folder for project $_projectID');
      notifyListeners();
    } else {
      logger.w('Create folder $name fail - ${_response.message}');
    }
  }

  void delete() async {
    if (_selected == null) {
      logger.w('No selected folder to delete');
    } else {
      logger.d('Delete $_selected in project $_projectID');
      ApiResponse _response = await _http.delete('prj/folder/${_selected.id}/');
      if (_response.status == ApiStatus.OK) {
        logger.i('Folder ${_selected.name} deleted in project $_projectID');
        _folders.remove(_selected);
        // _folders.sort((a, b) => a.position.compareTo(b.position));
        _selected = _folders.isNotEmpty ? _folders.first : null;
        notifyListeners();
      } else {
        logger.w('Delete $_selected fail - ${_response.message}');
      }
    }
  }
}

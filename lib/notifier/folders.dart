import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

class NotifierFolders with ChangeNotifier {
  final ServiceHttpClient _http;

  String _projectID;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;

  ModelFolder _selected;
  ModelFolder get selected => _selected;
  set selected(ModelFolder folder) {
    if (_selected == folder) return;
    logger.d('Changing selected folder to $folder');
    _selected = folder;
    notifyListeners();
  }

  List<ModelFolder> _folders = [];
  List<ModelFolder> get list => _folders;
  List<String> get names => _folders.map((e) => e.name).toList();

  // FIXME: not used
  ModelFolder byID(int folderID) => _folders?.firstWhere((_e) => _e.id == folderID);

  NotifierFolders(this._http) {
    logger.d('Initialize folders...');
  }

  void project(String projectID) async {
    if (projectID == null)
      logger.e('Project changed to $projectID');
    else if (_projectID != projectID) {
      _projectID = projectID;
      _selected = null;
      await _get();
      // if (projectID == null) {
      //   logger.d('Project changed to $projectID - reset folders');
      //   _folders = [];
      //   _status = ApiStatus.LOADING;
      // } else {
      //   await _get();
      // }
    } else {
      logger.w('Try to get folders for same project');
    }
  }

  Future<void> _get() async {
    logger.d('Get folders for project $_projectID');
    ApiResponse _response = await _http.get('prj/folder', params: {'save_id': _projectID});
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      _folders = List.from(_response.json).map((e) => ModelFolder.fromJson(e)).toList();
      _folders.sort((a, b) => a.position.compareTo(b.position));
      _selected ??= _folders.isNotEmpty ? _folders.first : null;
      logger.i('Get ${_folders.length} folders');
    } else {
      logger.w('Get folders ${_response.message}');
    }
    notifyListeners();
  }

  void create(String name) async {
    logger.d('Create folder $name for project $_projectID');
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

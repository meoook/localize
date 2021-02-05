import 'package:flutter/material.dart';
import 'package:localize/model/folder.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

class NotifierFolders with ChangeNotifier {
  final ServiceHttpClient _http;

  String _projectID;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;

  List<ModelFolder> _folders;
  List<ModelFolder> get list => _folders;

  ModelFolder byID(int folderID) => _folders?.firstWhere((_e) => _e.id == folderID);

  NotifierFolders(this._http) {
    logger.i('Init Folders');
  }

  void project(String projectID) async {
    if (_projectID != projectID) {
      _projectID = projectID;
      if (projectID == null) {
        logger.d('Project changed to $projectID - reset folders');
        _folders = null;
        _status = ApiStatus.LOADING;
      } else {
        await _get();
      }
      notifyListeners();
    } else {
      logger.w('Try to get folders for same project');
    }
  }

  Future<void> _get() async {
    logger.d('Get folders for project $_projectID');
    ApiResponse _response = await _http.get('prj/folder', params: {'save_id': _projectID});
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      final _parsed = _response.json.cast<Map<String, dynamic>>();
      _folders = _parsed.map<ModelFolder>((json) => ModelFolder.fromJson(json)).toList();
      logger.i('Get ${_folders.length} folders');
    } else {
      logger.w('Get folders ${_response.message}');
    }
  }

// Future<ModelProject> projectAdd(String name, String iChars, int langOrig, List translate) async {
//   var _payload = {'name': name, 'icon_chars': iChars, 'lang_orig': langOrig, 'translate_to': translate};
//   return await _httpClient.post('prj', data: _payload).then((value) => ModelProject.fromJson(value));
// }
//
// Future<ModelProject> projectUpdate(ModelProject project) async {
//   var _payload = project.apiMap;
//   return await _httpClient.post('prj/${project.id}', data: _payload).then((value) => ModelProject.fromJson(value));
// }
//
// Future<bool> projectDelete(String projectID) async {
//   return await _httpClient.request(Method.DELETE, 'prj/$projectID');
// }

// Future<List<ModelFolder>> foldersGet(String projectID) async {
//   logger.i('Get folders for project $projectID');
//   try {
//     var _data = await _apiManager.folderList(projectID);
//     logger.i('Get ${_data.length} folders');
//     return _data.map((e) => ModelFolder.fromJson(e)).toList();
//   } on NoConnectionException {
//     logger.e('Connection error while getting folders');
//   } catch (err) {
//     logger.e('Getting folders ${err.toString()}');
//   }
//   return null;
// }

}

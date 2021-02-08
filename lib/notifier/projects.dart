import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

class NotifierProjects with ChangeNotifier {
  final ServiceHttpClient _http;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;
  List<ModelProject> _projects;
  List<ModelProject> get list => _projects;

  ModelProject byID(String projectID) => _projects?.firstWhere((_e) => _e.id == projectID);

  NotifierProjects.init(ServiceHttpClient http) : this._http = http;

  void start() async {
    logger.d('Initialize projects...');
    await _get();
  }

  Future<void> _get() async {
    ApiResponse _response = await _http.get('prj');
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      _projects = List.from(_response.json).map((e) => ModelProject.fromJson(e)).toList();
      logger.i('Get ${_projects.length} projects');
    } else {
      logger.w('Get projects ${_response.message}');
    }
    notifyListeners();
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

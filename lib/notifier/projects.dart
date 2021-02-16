import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localize/model/project.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

class NotifierProjects with ChangeNotifier {
  final ServiceHttpClient http;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;
  List<ModelProject> _projects;
  List<ModelProject> get list => _projects;
  List<String> get names => _projects.map((e) => e.name).toList();

  NotifierProjects(this.http);

  void init() async {
    logger.d('Initialize projects...');
    await _get();
  }

  Future<void> _get() async {
    ApiResponse _response = await http.get('prj');
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      // _projects = List.from(_response.json).map((e) => ModelProject.fromJson(e)).toList();
      _projects = await compute(_isolate, _response.data);
      logger.i('Get ${_projects.length} projects');
    } else {
      logger.w('Get projects ${_response.message}');
    }
    notifyListeners();
  }

  static List<ModelProject> _isolate(String data) {
    var _json = jsonDecode(data);
    return List.from(_json).map((e) => ModelProject.fromJson(e)).toList();
  }

  Future<ModelProject> create(ModelNewProject project) async {
    logger.d('Try to create project ${project.name}');
    ApiResponse _response = await http.post('prj/', data: project.apiMap);
    if (_response.status == ApiStatus.OK) {
      ModelProject _project = ModelProject.fromJson(_response.json);
      _projects.add(_project);
      logger.i('Created $_project');
      return _project;
    } else {
      logger.w('Create project ${project.name} fail - ${_response.message}');
    }
    return null;
  }

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

class AnyClass<T> {
  T data;
}

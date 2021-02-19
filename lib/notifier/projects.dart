import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:localize/model/project.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

class NotifierProjects with ChangeNotifier {
  /// Class to provide list [ModelProject] - primary objects in application
  /// others do actions with project like: load or translate files, manage access, edit name or locales

  final ServiceHttpClient _http;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;
  List<ModelProject> _projects;
  List<ModelProject> get list => _projects;
  List<String> get names => _projects.map((e) => e.name).toList();

  NotifierProjects(this._http) {
    _get();
  }

  void _get() async {
    logger.d('Try to get projects...');
    ApiResponse _response = await _http.get('prj');
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      _projects = await compute(_isolate, _response.data);
      logger.i('Get ${_projects.length} projects');
    } else {
      logger.w('Get projects ${_response.message}');
    }
    notifyListeners();
  }

  static List<ModelProject> _isolate(String data) {
    var _json = jsonDecode(data);
    var _list = List.from(_json).map((e) => ModelProject.fromJson(e)).toList();
    // var _list = List.from(_json).map((e) => ModelFolder.fromJson(e)).toList();
    _list.sort((a, b) => b.created.compareTo(a.created));
    return _list;
  }

  Future<ModelProject> create(ModelProjectBase project) async {
    logger.d('Try to create project ${project.name}');
    ApiResponse _response = await _http.post('prj/', data: project.apiMap);
    if (_response.status == ApiStatus.OK) {
      ModelProject _project = ModelProject.fromJson(_response.json);
      _projects.insert(0, _project);
      logger.i('Created $_project');
      return _project;
    }
    logger.w('Create project ${project.name} fail - ${_response.message}');
    return null;
  }

  Future<ModelProject> update(String projectID, ModelProjectBase project) async {
    logger.d('Try to update project id $projectID (new name ${project.name})');
    ApiResponse _response = await _http.put('prj/$projectID/', data: project.apiMap);
    if (_response.status == ApiStatus.OK) {
      ModelProject _project = ModelProject.fromJson(_response.json);
      final int _idx = _projects.indexWhere((_prj) => _prj.id == projectID);
      _projects[_idx] = _project;
      logger.i('Updated $_project');
      return _project;
    }
    logger.w('Update project ${project.name} fail - ${_response.message}');
    return null;
  }

  Future<bool> delete(String projectID) async {
    logger.d('Try to delete project $projectID');
    ApiResponse _response = await _http.delete('prj/$projectID/');
    if (_response.status == ApiStatus.OK) {
      _projects.removeWhere((element) => element.id == projectID);
      logger.i('Project $projectID deleted');
      return true;
    }
    logger.w('Delete project $projectID fail - ${_response.message}');
    return false;
  }
}

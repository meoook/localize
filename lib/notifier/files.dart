import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localize/model/file.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

// FIXME: this class not finished - check permissions

class NotifierFiles with ChangeNotifier {
  final ServiceHttpClient _http;
  String _projectID;
  int _folderID;
  // pagination
  int _size = 25;
  int _page = 1;
  int _total = 0;

  ApiStatus _status = ApiStatus.LOADING;
  ApiStatus get status => _status;

  // ModelFile _selected;
  // ModelFile get selected => _selected;
  // set selected(ModelFile file) {
  //   if (_selected == file) return;
  //   logger.d('Changing selected file to $file');
  //   _selected = file;
  //   notifyListeners();
  // }

  List<ModelFile> _files = [];
  List<ModelFile> get list => _files;

  NotifierFiles(this._http) {
    logger.d('Initialize files...');
  }

  Map<String, String> get _params => {
        'save_id': _projectID,
        'folder_id': '$_folderID',
        'page': '$_page',
        'size': '$_size',
      };

  // project files - for translator only
  void project(String projectID) async {
    _projectID = projectID;
    if (_projectID == null)
      logger.e('Can\'t get files if project is null');
    else
      await _get();
  }

  // files in folder - for manager
  void folder(String projectID, int folderID) async {
    if (projectID == null) logger.e('Can\'t get files if project is null');
    if (folderID == null) logger.e('Can\'t get files if folder is null');
    if (projectID == null || folderID == null) return;
    if (_folderID != folderID) {
      _projectID = projectID;
      _folderID = folderID;
      await _get();
    } else {
      logger.w('Try to get files for same folder');
    }
  }

  Future<void> _get() async {
    logger.d('Get files ${_folderID != null ? 'for folder $_folderID in' : 'for'} project $_projectID');
    ApiResponse _response = await _http.get('file', params: _params);
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      var _data = await compute(_isolate, _response.data);
      _files = _data['list'];
      _total = _data['total'];
      logger.i('Get ${_files.length} of $_total files');
    } else {
      logger.w('Get files ${_response.message}');
    }
    notifyListeners();
  }

  static Map<String, dynamic> _isolate(String data) {
    var _json = jsonDecode(data);
    var _list = List.from(_json['results']).map((e) => ModelFile.fromJson(e)).toList();
    _list.sort((a, b) {
      var _errComp = b.error.compareTo(a.error);
      if (_errComp != 0) return _errComp;
      var _warnComp = b.warning.compareTo(a.warning);
      if (_warnComp != 0) return _warnComp;
      return b.created.compareTo(a.created);
    });
    return <String, dynamic>{'list': _list, 'total': _json['count']};
  }

  void change(ModelFile file) async {
    // TODO - finish
    final ModelFile _before = _files.firstWhere((element) => element.id == file.id);
    if (_before == null) return;
    logger.i('Changing $_before name to ${file.name}');
    ApiResponse _response = await _http.put('prj/file/${file.id}/', data: {'name': file.name});
  }

  void delete(ModelFile file) async {
    logger.d('Delete $file');
    ApiResponse _response = await _http.delete('prj/folder/${file.id}/');
    if (_response.status == ApiStatus.OK) {
      logger.i('File ${file.name} deleted');
      _files.remove(file);
      // _folders.sort((a, b) => a.position.compareTo(b.position));
      // _selected = _folders.isNotEmpty ? _folders.first : null;
      notifyListeners();
    } else {
      logger.w('Delete $file fail - ${_response.message}');
    }
  }
}

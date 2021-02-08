import 'package:flutter/material.dart';
import 'package:localize/model/file.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

// FIXME: this class not finished

class NotifierFiles with ChangeNotifier {
  final ServiceHttpClient _http;

  String _projectID;
  int _folderID;

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

  NotifierFiles(this._projectID, this._http) {
    logger.d('Initialize files...');
  }

  Map<String, dynamic> get _params => {'save_id': _projectID, 'folder_id': _folderID};

  void project() async => await _get();

  void folder(int folderID) async {
    if (_folderID == null)
      logger.e('Folder id set to $_folderID');
    else if (_folderID != folderID) {
      _folderID = folderID;
      await _get();
    } else {
      logger.w('Try to get folders for same project');
    }
  }

  Future<void> _get() async {
    logger.d('Get files ${_folderID != null ? 'for folder $_folderID in' : 'for'} project $_projectID');
    ApiResponse _response = await _http.get('file', params: _params);
    _status = _response.status;
    if (_response.status == ApiStatus.OK) {
      _files = List.from(_response.json).map((e) => ModelFile.fromJson(e)).toList();
      _files.sort((a, b) => a.warning.compareTo(b.warning));
      logger.i('Get ${_files.length} files');
    } else {
      logger.w('Get files ${_response.message}');
    }
    notifyListeners();
  }

  void change(ModelFile file) async {
    ModelFile _before = _files.firstWhere((element) => element.id == file.id);
    if (_before == null) return;
    logger.i('Changing file name from ${_before.name} to ${file.name}');
    ApiResponse _response = await _http.put('prj/file/${file.id}/', data: {'name': file.name});
  }

  void delete(ModelFile file) async {
      logger.d('Delete file ${file.name} in project $_projectID');
      ApiResponse _response = await _http.delete('prj/folder/${_selected.id}/');
      if (_response.status == ApiStatus.OK) {
        logger.i('Folder ${_selected.name} deleted in project $_projectID');
        _folders.remove(_selected);
        // _folders.sort((a, b) => a.position.compareTo(b.position));
        _selected = _folders.isNotEmpty ? _folders.first : null;
        notifyListeners();
      } else {
        logger.w('Delete folder ${_selected.name} fail - ${_response.message}');
      }
    }
  }
}

import 'package:localize/model/progress.dart';

class ModelFile {
  final int id;
  String name; // Can be changed
  final String method;

  final int items;
  final int words;

  final int langOriginal;
  final List<ModelProgress> progress;

  final bool repoStatus;

  final String warning;
  final String error;

  final DateTime created;
  final DateTime updated;

  @override
  String toString() => 'file $name id $id';

  ModelFile.fromJson(json)
      : id = json['id'],
        name = json['name'],
        method = json['method'],
        items = json['items'],
        words = json['words'],
        langOriginal = json['lang_orig'],
        progress = List.from(json['translated_set']).map((e) => ModelProgress.fromJson(e, json['items'])).toList(),
        repoStatus = json['repo_status'],
        warning = json['warning'],
        error = json['error'],
        created = DateTime.parse(json['created']),
        updated = DateTime.parse(json['updated']);

  // Map<String, dynamic> get apiMap {
  //   return {
  //     'name': this.name,
  //   };
  // }
}

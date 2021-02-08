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
  String toString() => 'file $id $name';

  ModelFile.fromJson(json)
      : this.id = json['id'],
        this.name = json['name'],
        this.method = json['method'],
        this.items = json['items'],
        this.words = json['words'],
        this.langOriginal = json['lang_orig'],
        // this.progress = json['translated_set'].map((_json) => ModelProgress.fromJson(_json, json['items'])).toList(),
        this.progress = List.from(json['translated_set']).map((e) => ModelProgress.fromJson(e, json['items'])).toList(),
        this.repoStatus = json['repo_status'],
        this.warning = json['warning'],
        this.error = json['error'],
        this.created = DateTime.parse(json['created']),
        this.updated = DateTime.parse(json['updated']);

  // Map<String, dynamic> get apiMap {
  //   return {
  //     'name': this.name,
  //   };
  // }
}

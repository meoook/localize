import 'package:localize/services/permissions.dart';

class ModelProject {
  final String id;
  String name;
  String iChars;
  final String author;
  final DateTime created;
  int langOriginal;
  List<int> translateTo;
  ServicePermissions permissions;

  @override
  String toString() => 'project ${this.name} author ${this.author} id ${this.id}';

  ModelProject.fromJson(Map<String, dynamic> json)
      : this.id = json['save_id'],
        this.name = json['name'],
        this.iChars = json['icon_chars'],
        this.author = json['author'],
        this.created = DateTime.parse(json['created']),
        this.langOriginal = json['lang_orig'],
        this.translateTo = List<int>.from(json['translate_to']),
        this.permissions = ServicePermissions(json['permissions_set']);

  Map<String, dynamic> get apiMap {
    return {
      'name': this.name,
      'icon_chars': this.iChars,
      'lang_orig': this.langOriginal,
      'translate_to': this.translateTo,
    };
  }
}

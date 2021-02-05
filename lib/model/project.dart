import 'package:localize/services/permissions.dart';

class ModelProject {
  final String id;
  String name;
  String iChars;
  final String author;
  final DateTime created;
  int langOriginal;
  List<dynamic> translateTo; // TODO: lang obj
  ServicePermissions permissions;

  ModelProject(
      {this.id, this.name, this.iChars, this.author, this.created, this.langOriginal, this.translateTo, permissions}) {
    this.permissions = ServicePermissions(permissions);
  }
  @override
  String toString() => 'project ${this.name} author ${this.author} id ${this.id}';

  factory ModelProject.fromJson(Map<String, dynamic> json) {
    return ModelProject(
      id: json['save_id'],
      name: json['name'],
      iChars: json['icon_chars'],
      author: json['author'],
      created: DateTime.parse(json['created']),
      langOriginal: json['lang_orig'],
      translateTo: json['translate_to'],
      permissions: json['permissions_set'],
    );
  }
  Map<String, dynamic> get apiMap {
    return {
      'name': this.name,
      'icon_chars': this.iChars,
      'lang_orig': this.langOriginal,
      'translate_to': this.translateTo,
    };
  }
}

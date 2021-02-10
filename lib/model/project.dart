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
  String toString() => 'project $name id $id';

  ModelProject.fromJson(Map<String, dynamic> json)
      : id = json['save_id'],
        name = json['name'],
        iChars = json['icon_chars'],
        author = json['author'],
        created = DateTime.parse(json['created']),
        langOriginal = json['lang_orig'],
        translateTo = List<int>.from(json['translate_to']),
        permissions = ServicePermissions(json['permissions_set']);

  Map<String, dynamic> get apiMap {
    return {
      'name': name,
      'icon_chars': iChars,
      'lang_orig': langOriginal,
      'translate_to': translateTo,
    };
  }
}

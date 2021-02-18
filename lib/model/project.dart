import 'package:localize/services/access.dart';

class ModelProject extends ModelProjectBase {
  final String id;
  final String author;
  final DateTime created;
  final ServiceAccess permissions;

  @override
  String toString() => 'project $name id $id';

  ModelProject.fromJson(Map<String, dynamic> json)
      : id = json['save_id'],
        author = json['author'],
        created = DateTime.parse(json['created']),
        permissions = ServiceAccess(json['permissions_set']),
        super.fromJson(json);
}

class ModelProjectBase {
  String name;
  String iChars;
  int langOriginal;
  List<int> translateTo = [];

  ModelProjectBase();

  ModelProjectBase.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        iChars = json['icon_chars'],
        langOriginal = json['lang_orig'],
        translateTo = List<int>.from(json['translate_to']);

  Map<String, dynamic> get apiMap {
    return {
      'name': name,
      'icon_chars': iChars,
      'lang_orig': langOriginal,
      'translate_to': translateTo,
    };
  }
}

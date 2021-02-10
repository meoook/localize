class ModelLanguage {
  final int id;
  final String name;
  final String shortName;

  @override
  String toString() => 'language $shortName $name id $id';

  ModelLanguage.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        shortName = json['short_name'];
}

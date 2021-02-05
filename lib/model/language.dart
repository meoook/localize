class ModelLanguage {
  final int id;
  final String name;
  final String shortName;

  ModelLanguage({this.id, this.name, this.shortName});
  @override
  String toString() => 'language ${this.id} ${this.shortName} ${this.name}';

  factory ModelLanguage.fromJson(Map<String, dynamic> json) {
    return ModelLanguage(
      id: json['id'], // int.tryParse(json['id']);
      name: json['name'],
      shortName: json['short_name'],
    );
  }
}

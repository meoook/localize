class ModelLanguage {
  final int id;
  final String name;
  final String shortName;

  @override
  String toString() => 'language ${this.id} ${this.shortName} ${this.name}';

  ModelLanguage.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.shortName = json['short_name'];
}

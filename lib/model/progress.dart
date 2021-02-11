class ModelProgress {
  final int items;
  final int language;
  final int value;

  @override
  String toString() => 'language id $language $value%';

  ModelProgress.fromJson(Map<String, dynamic> json, int total)
      : language = json['language'],
        items = json['items'],
        value = (100.0 * json['items'] / total).round();
}

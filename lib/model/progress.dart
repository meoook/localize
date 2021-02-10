class ModelProgress {
  final int items;
  final int language;
  final int progress;

  @override
  String toString() => 'language id $language $progress%';

  ModelProgress.fromJson(Map<String, dynamic> json, int total)
      : language = json['language'],
        items = json['items'],
        progress = (100.0 * json['items'] / total).round();
}

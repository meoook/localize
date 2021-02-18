class ModelProgress {
  int items;
  int language;
  int value;

  @override
  String toString() => 'language id $language $value%';

  // ModelProgress.fromJson(Map<String, dynamic> json, int total)
  //     : language = json['language'],
  //       items = json['items'],
  //       value = (100.0 * json['items'] / total).round();
  ModelProgress.fromJson(Map<String, dynamic> json, int total) {
    language = json['language'];
    items = json['items'];
    value = total != null ? (100.0 * json['items'] / total).round() : 0;
  }
}

class ModelProgress {
  final int items;
  final int language;
  final int progress;

  @override
  String toString() => 'language $language with progress $progress';

  ModelProgress.fromJson(Map<String, dynamic> json, int total)
      : this.language = json['language'],
        this.items = json['items'],
        this.progress = (total / json['items'] * 100).round();
}

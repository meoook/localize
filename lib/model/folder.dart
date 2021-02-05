class ModelFolder {
  final int id;
  // final String project;
  String name;
  int position;
  int files;
  String repoStatus;
  String repoUrl;

  ModelFolder(this.id, this.name);
  @override
  String toString() => 'folder ${this.id} ${this.name} files amount ${this.files}';

  factory ModelFolder.fromJson(json) {
    return ModelFolder(json['id'], json['name'])
      ..position = json['position']
      ..repoStatus = json['repo_status']
      ..repoUrl = json['repo_url']
      ..files = json['files_amount'];
  }
}

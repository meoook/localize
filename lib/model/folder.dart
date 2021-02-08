class ModelFolder {
  final int id;
  String name;
  int position;
  int files;
  String repoStatus;
  String repoUrl;

  @override
  String toString() => 'folder ${this.id} ${this.name} files amount ${this.files}';

  ModelFolder.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.position = json['position'],
        this.files = json['files_amount'],
        this.repoStatus = json['repo_status'],
        this.repoUrl = json['repo_url'];
}

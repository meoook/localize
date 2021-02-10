class ModelFolder {
  final int id;
  String name;
  int position;
  int files;
  String repoStatus;
  String repoUrl;

  @override
  String toString() => 'folder $name id $id';

  ModelFolder.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        position = json['position'],
        files = json['files_amount'],
        repoStatus = json['repo_status'],
        repoUrl = json['repo_url'];
}

class ModelUser {
  final int id;
  final String name;
  final String token;
  final bool isCreator;

  @override
  String toString() => '${this.isCreator ? 'creator' : 'user'} ${this.name} id: ${this.id}';

  ModelUser.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['first_name'],
        this.token = json['token'],
        this.isCreator = json['role'] == 'creator';
}

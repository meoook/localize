class ModelUser {
  final int id;
  final String name;
  final String token;
  final bool isCreator;

  ModelUser({
    this.id,
    this.name,
    this.token,
    this.isCreator,
  });
  @override
  String toString() => '${this.isCreator ? 'creator' : 'user'} ${this.name} id: ${this.id}';

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      id: json['id'],
      name: json['first_name'],
      isCreator: json['role'] == 'creator',
      token: json['token'],
    );
  }
}

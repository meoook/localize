class ModelUser {
  final int id;
  final String name;
  final String token;
  final bool isCreator;

  @override
  String toString() => '${isCreator ? 'creator' : 'user'} $name id $id';

  ModelUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['first_name'],
        token = json['token'],
        isCreator = json['role'] == 'creator';
}

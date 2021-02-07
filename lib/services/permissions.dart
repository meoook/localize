enum AccessLevel { TRANSLATE, INVITE, MANAGE, ADMIN, OWNER }
enum AccessPage { FILES, MANAGE, ACCESS, CHANGE }
// extension AccessExtension on AccessLevel {
//   String get text => this.toString().split('.').last;
// }

class ServicePermissions {
  // final List<AccessLevel> _choices = AccessLevel.values.toList();
  List<AccessLevel> _permissions = [];
  List<AccessLevel> get list => _permissions;

  List<AccessPage> get access => [
        if (translatorOnly) AccessPage.FILES,
        if (canManage) AccessPage.MANAGE,
        if (isOwner || isAdmin || isInviter) AccessPage.ACCESS,
        if (isOwner) AccessPage.CHANGE,
      ];

  bool get isOwner => _permissions.contains(AccessLevel.OWNER);
  bool get isAdmin => _permissions.contains(AccessLevel.ADMIN);
  bool get isManager => _permissions.contains(AccessLevel.MANAGE);
  bool get isInviter => _permissions.contains(AccessLevel.INVITE);
  bool get isTranslator => _permissions.contains(AccessLevel.TRANSLATE);
  bool get canTranslate => isOwner || isTranslator;
  bool get canManage => isOwner || isManager;
  bool get translatorOnly => isTranslator && _permissions.length == 1;

  ServicePermissions(List<dynamic> permissions) {
    if (permissions.isEmpty) _permissions.add(AccessLevel.OWNER);
    if (permissions.contains(9)) _permissions.add(AccessLevel.ADMIN);
    if (permissions.contains(8)) _permissions.add(AccessLevel.MANAGE);
    if (permissions.contains(5)) _permissions.add(AccessLevel.INVITE);
    if (permissions.contains(0)) _permissions.add(AccessLevel.TRANSLATE);
  }
}

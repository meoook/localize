class UserAccess {
  static const int nTranslate = 0;
  static const int nInvite = 5;
  static const int nManage = 8;
  static const int nAdmin = 9;

  final String name;
  int admin;
  int manage;
  int invite;
  int translate;

  UserAccess(this.name, List<dynamic> permissions) {
    permissions.forEach((e) => add(e['permission'], e['id']));
  }

  void add(int lvl, int id) {
    if (lvl == nTranslate) translate = id;
    if (lvl == nInvite) invite = id;
    if (lvl == nManage) manage = id;
    if (lvl == nAdmin) admin = id;
  }

  void remove(int id) {
    if (admin == id) admin = null;
    if (manage == id) manage = null;
    if (invite == id) invite = null;
    if (translate == id) translate = null;
  }

  bool get noAccess {
    if (admin == null && manage == null && invite == null && translate == null) return true;
    return false;
  }

  @override
  toString() => '$name tr:$translate in:$invite ma:$manage ad:$admin';
}

import 'package:localize/model/project.dart';

class ProviderProject extends ModelProjectBase {
  /// Class to create or edit project with validation system [isOk]
  /// [_checkNaming] must be set [setCheck] when `text controller` loaded

  Function _checkNaming;
  set setCheck(Function check) => _checkNaming = check;

  bool checkNaming() => _checkNaming != null ? _checkNaming() : false;

  bool checkLocales() => this.translateTo.isNotEmpty;

  bool get isOk => checkNaming() && checkLocales();

  ProviderProject(ModelProjectBase project) : super.fromJson(project.apiMap);
}

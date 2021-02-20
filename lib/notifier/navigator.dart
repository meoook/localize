import 'package:localize/model/file.dart';
import 'package:localize/model/project.dart';
import 'package:localize/services/http_client.dart';
import 'package:localize/services/logger.dart';

enum NavChoice { PROJECTS, ADD, FILE, OPTIONS, LOGOUT }

extension StringNavExtension on NavChoice {
  String get text => this.toString().split('.').last;
}

class ProviderNavigator {
  final ServiceHttpClient http;
  Function _navigate;
  NavChoice nav = NavChoice.PROJECTS;

  ModelProject project;
  ModelFile file;

  ProviderNavigator(this.http);

  set navigation(Function navigate) {
    logger.d('Initialize navigation...');
    _navigate = navigate;
  }

  void navigate([NavChoice choice]) {
    if (choice != null) nav = choice;
    if (_navigate != null) _navigate(nav);
    if (_navigate != null) logger.d('Navigate to ${nav.text}');
  }
}

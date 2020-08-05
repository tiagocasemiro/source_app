import 'package:source_app/engine/shell/git/git.dart';

class StartRepositoryUseCase {

  void startGitApplication() {
    String _workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";
    String _host = "github.com";
    String _pathDotGit = "tiagocasemiro/documentation.git";
    String _username = "tiagocasemiro";
    String _password = "";

    Git().startRepository(_username, _password, _workDirectory, _host, _pathDotGit).then((success) {
      print("Application is started");
    });
  }
}
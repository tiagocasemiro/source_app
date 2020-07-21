import 'package:source_app/git/shell/git/command/pull.dart';
import 'command/add.dart';
import 'command/branch.dart';
import 'command/commit.dart';
import 'command/fetch.dart';
import 'command/push.dart';
import 'command/tag.dart';

class Git {
  final String _workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";
  final String _host = "github.com";
  final String _repository = "tiagocasemiro/documentation.git";

  String _originWithCredential(String user, String password) {
    return "https://$user:$password@$_host/$_repository";
  }

  Branch branch() {
    return Branch(_workDirectory);
  }

  Tag tag() {
    return Tag(_workDirectory);
  }

  Add add() {
    return Add(_workDirectory);
  }

  Fetch fetch() {
    return Fetch(_workDirectory);
  }

  Commit commit(String message) {
    return Commit(_workDirectory);
  }

  Push push(String username, String password) {
    return Push(_workDirectory);
  }

  Pull pull() {
    return Pull(_workDirectory);
  }
}
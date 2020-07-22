import 'package:source_app/git/shell/git/command/base/base_command.dart';
import 'package:source_app/git/shell/git/command/pull.dart';
import '../terminal.dart';
import 'command/add.dart';
import 'command/branch.dart';
import 'command/commit.dart';
import 'command/fetch.dart';
import 'command/merge.dart';
import 'command/push.dart';
import 'command/stash.dart';
import 'command/tag.dart';

class Git {
  final String _workDirectory = "/home/tiagocasemiro/Documentos/projetos/pessoal/documentation";
  final String _host = "github.com";
  final String _repository = "tiagocasemiro/documentation.git";

  String _originWithCredential(String username, String password) {
    return "https://$username:$password@$_host/$_repository";
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
    return Push(_workDirectory, _originWithCredential(username, password));
  }

  Pull pull() {
    return Pull(_workDirectory);
  }

  Merge merge() {
    return Merge(_workDirectory);
  }

  Stash stash() {
    return Stash(_workDirectory);
  }

  Future<bool> isGitDirectory() async {
    final int processResult = await Terminal(_workDirectory).runAndReturnExitCode(BaseGitCommand.git, parameters: [BaseGitCommand.status]);

    return processResult == 0;
  }
}
import 'package:source_app/git/shell/extension/extension.dart';

import '../../../terminal.dart';

abstract class BaseGitCommand {
  final String git = 'git';
  final String noResult = "";
  String _workDirectory;
  final List<String> parameters = List();

  BaseGitCommand(this._workDirectory);

  Future<String> execute({List<String> parameters = const []}) async {
    String terminalOutput = await  Terminal(_workDirectory).run(git, parameters: parameters);

    return terminalOutput != null? terminalOutput: Shell.empty();
  }

  Future call();
}
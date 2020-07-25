import 'package:source_app/git/shell/git/adapter/commit_adapter.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Commit extends BaseGitCommand {
  Commit(workDirectory) : super(workDirectory) {
    parameters.add("commit");
  }

  Commit message(String message) {
    parameters.add('-m');
    parameters.add(message);

    return this;
  }

  @override
  Future<TerminalOutput> call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return CommitAdapter().commitToObject(terminalOutput);
  }
}

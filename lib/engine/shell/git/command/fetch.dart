import 'package:source_app/engine/shell/git/adapter/fetch_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Fetch extends BaseGitCommand {
  Fetch(workDirectory) : super(workDirectory) {
    parameters.add('fetch');
  }

  Fetch prune() {
    parameters.add('-p');

    return this;
  }

  Fetch all() {
    parameters.add("--all");

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return FetchAdapter(terminalOutput).execute();
  }
}

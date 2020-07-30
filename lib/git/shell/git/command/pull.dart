import 'package:source_app/git/shell/git/adapter/pull_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Pull extends BaseGitCommand {
  Pull(workDirectory) : super(workDirectory) {
    parameters.add('pull');
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return PullAdapter(terminalOutput).execute();
  }
}

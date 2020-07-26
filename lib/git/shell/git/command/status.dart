import 'package:source_app/git/shell/git/adapter/status_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Status extends BaseGitCommand {
  Status(String workDirectory) : super(workDirectory) {
    parameters.add('status');
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return StatusAdapter().confirm(terminalOutput);
  }
}

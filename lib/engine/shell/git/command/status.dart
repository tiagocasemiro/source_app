import 'package:source_app/engine/shell/git/adapter/status_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Status extends BaseGitCommand {
  Status(String workDirectory) : super(workDirectory) {
    parameters.add('status');
  }

  @override
  Future<GitOutput> call() async {
    try {
      TerminalOutput terminalOutput = await super.execute(parameters: parameters);

      return StatusAdapter(terminalOutput).confirm();
    } on Exception {
      return GitOutput("").failure();
    }
  }
}

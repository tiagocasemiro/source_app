
import 'package:source_app/git/shell/git/adapter/remote_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

import 'base/base_command.dart';

class Remote extends BaseGitCommand {
  Remote(String workDirectory) : super(workDirectory) {
    parameters.add('remote');
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return RemoteAdapter(terminalOutput).remote();
  }
}
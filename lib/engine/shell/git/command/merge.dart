import 'package:source_app/engine/shell/git/adapter/merge_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Merge extends BaseGitCommand {
  Merge(String workDirectory) : super(workDirectory) {
    parameters.add('merge');
  }

  Merge branch(String name) {
    parameters.add(name);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return MergeAdapter(terminalOutput).confirm();
  }
}

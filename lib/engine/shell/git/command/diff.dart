import 'package:source_app/engine/shell/git/adapter/diff_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Diff extends BaseGitCommand {
  Diff(String workDirectory) : super(workDirectory) {
    parameters.add('diff');
  }

  Diff nameOnly() {
    parameters.add("--name-only");

    return this;
  }

  Diff cached() {
    parameters.add("--cached");

    return this;
  }

  Diff file(String name) {
    parameters.add(name);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return DiffAdapter(terminalOutput).files();
  }
}
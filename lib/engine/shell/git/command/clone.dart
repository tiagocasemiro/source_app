import 'package:source_app/engine/shell/git/adapter/clone_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Clone extends BaseGitCommand {

  Clone(String workDirectory) : super(workDirectory) {
    parameters.add("clone");
  }

  Clone repo(String url) {
    parameters.add(url);

    return this;
  }

  Clone directory(String path) {
    parameters.add(path);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return CloneAdapter(terminalOutput).execute();
  }
}
import 'package:source_app/engine/model/git_commit.dart';
import 'package:source_app/engine/shell/git/adapter/commit_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Commit extends BaseGitCommand {
  Commit(workDirectory) : super(workDirectory) {
    parameters.add("commit");
  }

  Commit message(String value) {
    parameters.add('-m');
    parameters.add(value);

    return this;
  }

  Commit diffTree(GitCommit gitCommit) {
    parameters.add('diff-tree');
    parameters.add('-p');
    parameters.add(gitCommit.hash);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return CommitAdapter(terminalOutput).execute();
  }
}

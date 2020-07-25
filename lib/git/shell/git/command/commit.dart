import 'package:source_app/git/shell/git/adapter/commit_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
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

  @override
  Future<GitOutput> call() async {
    String gitOutput = await super.execute(parameters: parameters);

    return CommitAdapter().commitToObject(gitOutput);
  }
}

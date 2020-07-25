import 'package:source_app/git/shell/git/adapter/merge_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
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
    String gitOutput = await super.execute(parameters: parameters);

    return MergeAdapter().confirm(gitOutput);
  }
}

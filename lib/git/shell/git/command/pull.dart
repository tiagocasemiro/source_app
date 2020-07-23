import 'package:source_app/git/shell/git/adapter/pull_adapter.dart';
import 'base/base_command.dart';

class Pull extends BaseGitCommand {
  Pull(workDirectory) : super(workDirectory) {
    parameters.add('pull');
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return PullAdapter().confirm(terminalOutput);
  }
}

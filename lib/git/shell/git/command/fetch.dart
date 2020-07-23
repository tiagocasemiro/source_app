import 'package:source_app/git/shell/git/adapter/fetch_adapter.dart';
import 'base/base_command.dart';

class Fetch extends BaseGitCommand {
  Fetch(workDirectory) : super(workDirectory) {
    parameters.add('fetch');
  }

  Fetch prune() {
    parameters.add('-p');

    return this;
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return FetchAdapter().confirm(terminalOutput);
  }
}

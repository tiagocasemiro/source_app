import 'package:source_app/git/shell/git/adapter/log_adapter.dart';
import 'base/base_command.dart';

class Log extends BaseGitCommand {
  Log(String workDirectory) : super(workDirectory) {
    parameters.add('log');
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return LogAdapter().confirm(terminalOutput);
  }
}
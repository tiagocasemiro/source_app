import 'package:source_app/git/shell/git/adapter/log_adapter.dart';
import 'base/base_command.dart';

class Log extends BaseGitCommand {
  static const String historyFormat = "%h - %an - %s - %as";

  Log(String workDirectory) : super(workDirectory) {
    parameters.add('log');
  }

  Log pretty(String format) {
    parameters.add("--pretty=format:$format");

    return this;
  }

  Log graph() {
    parameters.add('--graph');

    return this;
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return LogAdapter().confirm(terminalOutput);
  }
}

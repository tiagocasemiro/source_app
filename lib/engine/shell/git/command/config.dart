import 'package:source_app/engine/shell/git/adapter/config_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Config extends BaseGitCommand {
  Config(workDirectory) : super(workDirectory) {
    parameters.add('config');
  }

  Config store() {
    parameters.add('credential.helper');
    parameters.add('store');

    return this;
  }

  Config url() {
    parameters.add('--get');
    parameters.add('remote.origin.url');

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return ConfigAdapter(terminalOutput).url();
  }
}
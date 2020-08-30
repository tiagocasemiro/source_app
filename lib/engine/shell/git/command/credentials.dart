import 'package:source_app/engine/shell/git/adapter/credentials_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Credentials extends BaseGitCommand {
  Credentials(workDirectory) : super(workDirectory) {
    parameters.add('config');
  }

  Credentials username(String value) {
    parameters.add('user.name');
    parameters.add(value);

    return this;
  }

  Credentials password(String value) {
    parameters.add('user.password');
    parameters.add(value);

    return this;
  }

  Credentials store() {
    parameters.add('credential.helper');
    parameters.add('store');

    return this;
  }


  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return CredentialsAdapter(terminalOutput).execute();
  }
}
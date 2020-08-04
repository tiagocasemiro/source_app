import 'package:source_app/engine/shell/git/adapter/push_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Push extends BaseGitCommand {
  final String _credentials;
  final String _repository;

  Push(workDirectory, this._credentials, this._repository) : super(workDirectory) {
    parameters.add('push');
  }

  Push tags() {
    parameters.add('--tags');

    return this;
  }

  Push delete(String branch) {
    parameters.add(_repository);
    parameters.add('--delete');
    parameters.add(branch);

    return this;
  }

  Push rename(String oldName, String newName) {
    parameters.add(_repository);
    parameters.add(oldName);
    parameters.add(newName);

    return this;
  }

  Push branch(String name) {
    parameters.add('--set-upstream');
    parameters.add(_repository);
    parameters.add(name);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    parameters.add(_credentials);
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return PushAdapter(terminalOutput).execute();
  }
}

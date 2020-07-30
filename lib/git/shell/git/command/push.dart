import 'package:source_app/git/shell/git/adapter/push_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Push extends BaseGitCommand {
  final String _originWithCredential;

  Push(workDirectory, this._originWithCredential) : super(workDirectory) {
    parameters.add('push');
  }

  Push tags() {
    parameters.add('--tags');

    return this;
  }

  Push delete(String branch) {
    parameters.add('origin');
    parameters.add('--delete');
    parameters.add(branch);

    return this;
  }

  Push rename(String oldName, String newName) {
    parameters.add('origin');
    parameters.add(oldName);
    parameters.add(newName);

    return this;
  }

  Push branch(String name) {
    parameters.add('--set-upstream');
    parameters.add('origin');
    parameters.add(name);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    parameters.add(_originWithCredential);
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return PushAdapter(terminalOutput).execute();
  }
}

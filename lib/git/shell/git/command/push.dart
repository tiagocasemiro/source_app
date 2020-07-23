import 'package:source_app/git/shell/git/adapter/push_adapter.dart';
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

  @override
  Future call() async {
    parameters.add(_originWithCredential);
    String terminalOutput = await super.execute(parameters: parameters);

    return PushAdapter().confirm(terminalOutput);
  }
}

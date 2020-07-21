import 'package:source_app/git/shell/git/adapter/push_adapter.dart';
import 'base/base_command.dart';

class Push extends BaseGitCommand {
  final String _originWithCredential;
  Push(workDirectory, this._originWithCredential): super(workDirectory) {
    parameters.add('push');
  }

  @override
  Future call() async {
    parameters.add(_originWithCredential);
    String terminalOutput = await super.execute(parameters: parameters);

    return PushAdapter().confirm(terminalOutput);
  }
}


import 'package:source_app/git/shell/git/adapter/pull_adapter.dart';
import '../../terminal.dart';

class Pull {
  String _workDirectory;
  Pull(this._workDirectory);

  Future<bool> pull() {
    return Terminal(_workDirectory).run("git", parameters: ['pull']).then((String terminalOutput) {
      return PullAdapter().confirm(terminalOutput);
    });
  }
}
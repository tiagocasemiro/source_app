
import 'package:source_app/git/shell/git/adapter/push_adapter.dart';

import '../../terminal.dart';

class Push {
  String _workDirectory;
  Push(this._workDirectory);

  Future<bool> push(String username, String password, String _originWithCredential) {
    return Terminal(_workDirectory).run("git", parameters: ['push', _originWithCredential]).then((String terminalOutput) {
      return PushAdapter().confirm(terminalOutput);
    });
  }
}


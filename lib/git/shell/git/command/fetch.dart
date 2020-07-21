import 'package:source_app/git/shell/git/adapter/fetch_adapter.dart';
import '../../terminal.dart';

class Fetch {
  String _workDirectory;
  Fetch(this._workDirectory);

  Future<bool> prune() {
    return Terminal(_workDirectory).run("git", parameters: ['fetch', '-p']).then((String terminalOutput) {
      return FetchAdapter().confirm(terminalOutput);
    });
  }

  Future<bool> exec() {
    return Terminal(_workDirectory).run("git", parameters: ['fetch']).then((String terminalOutput) {
      return FetchAdapter().confirm(terminalOutput);
    });
  }
}
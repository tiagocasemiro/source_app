import 'package:source_app/git/shell/git/adapter/commit_adapter.dart';
import '../../terminal.dart';

class Commit {
  String _workDirectory;
  Commit(this._workDirectory);

  Future<bool> commit(String message) {
    return Terminal(_workDirectory).run("git", parameters: ['commit', '-m', message]).then((String terminalOutput) {
      return CommitAdapter().confirm(terminalOutput);
    });
  }
}
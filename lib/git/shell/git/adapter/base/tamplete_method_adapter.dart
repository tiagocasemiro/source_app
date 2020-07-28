
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class Adapter {
  TerminalOutput _terminalOutput;

  Adapter(this._terminalOutput);

  GitOutput execute(BaseAdapter baseAdapter) {
    var gitOutput = baseAdapter.toGitOutput(_terminalOutput);
    try {
      if(gitOutput.isFailure()) {
        return gitOutput.failure();
      }
      return baseAdapter.execute(gitOutput).success();
    } catch (e) {
      return gitOutput.failure();
    }
  }
}
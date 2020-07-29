
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class Transformation {
  TerminalOutput _terminalOutput;

  Transformation(this._terminalOutput);

  GitOutput execute(BaseAdapter baseAdapter) {
    var gitOutput = baseAdapter.toGitOutput(_terminalOutput);
    try {
      if(gitOutput.isFailure()) {
        return gitOutput.failure();
      }
      return baseAdapter.transform(gitOutput).success();
    } catch (e) {
      return gitOutput.failure();
    }
  }
}
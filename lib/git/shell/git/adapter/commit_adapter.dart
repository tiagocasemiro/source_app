import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class CommitAdapter extends BaseAdapter {
  GitOutput commitToObject(TerminalOutput terminalOutput) {
    var gitOutput = toGitOutput(terminalOutput);
    try {
      if (gitOutput.isFailure()) {
        return gitOutput;
      }
      toLines(terminalOutput.message).forEach((line) {
        if (line.contains("error: ")) {
          return gitOutput.failure();
        }
      });

      return gitOutput.success();
    } catch (e) {

      return gitOutput.failure();
    }
  }
}

import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';
import '../../../model/git_branch.dart';

class BranchAdapter extends BaseAdapter {
  int _singleResult = 1;

  GitOutput toBranches(TerminalOutput terminalOutput) {
    var gitOutput = toGitOutput(terminalOutput);
    try {
      if(gitOutput.isFailure()) {
        return gitOutput;
      }
      List<GitBranch> branches = List();
      toLines(terminalOutput.message).forEach((line) {
        if (line.isNotEmpty) {
          branches.add(GitBranch(clean(line)));
        }
      });

      return gitOutput.success(object: branches);
    } catch (e) {

      return gitOutput.failure();
    }
  }

  GitOutput toBranch(TerminalOutput terminalOutput) {
    var gitOutput = toGitOutput(terminalOutput);
    try {
      if(gitOutput.isFailure()) {
        return gitOutput.failure();
      }
      List<String> lines = toLines(terminalOutput.message);
      String branch = lines.firstWhere(
          (line) =>
              lines.length == _singleResult ||
              (line.isNotEmpty && line.startsWith("*")),
          orElse: () => null);

      return branch != null
          ? gitOutput.success(object: GitBranch(clean(branch)))
          :gitOutput.failure();
    } catch (e) {

      return gitOutput.failure();
    }
  }
}

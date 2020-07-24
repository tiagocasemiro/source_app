import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';
import '../../../model/git_branch.dart';

class BranchAdapter extends BaseAdapter {
  TerminalOutput<List<GitBranch>> toBranches(String _terminalOutput) {
    try {
      List<GitBranch> branches = List();
      toLines(_terminalOutput).forEach((line) {
        if (line.isNotEmpty) {
          branches.add(GitBranch(clean(line)));
        }
      });

      return TerminalOutput(object: branches);
    } catch (e) {
      return TerminalOutput(isSuccess: false);
    }
  }

  TerminalOutput<GitBranch> toBranch(String terminalOutput) {
    try {
      String branch = toLines(terminalOutput).firstWhere(
          (line) => line.isNotEmpty && line.startsWith("*"),
          orElse: () => null);

      return branch != null
          ? TerminalOutput(object: GitBranch(clean(branch)))
          : TerminalOutput(isSuccess: false);
    } catch (e) {
      return TerminalOutput(isSuccess: false);
    }
  }
}

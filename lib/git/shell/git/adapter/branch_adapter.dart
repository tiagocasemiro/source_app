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

      return TerminalOutput().success(object: branches);
    } catch (e) {
      return TerminalOutput().failure(_terminalOutput);
    }
  }

  TerminalOutput<GitBranch> toBranch(String _terminalOutput) {
    try {
      String branch = toLines(_terminalOutput).firstWhere(
          (line) => line.isNotEmpty && line.startsWith("*"),
          orElse: () => null);

      return branch != null
          ? TerminalOutput().success(object: GitBranch(clean(branch)))
          : TerminalOutput().failure(_terminalOutput);
    } catch (e) {
      return TerminalOutput().failure(_terminalOutput);
    }
  }
}

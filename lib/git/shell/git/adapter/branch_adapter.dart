import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';
import '../../../model/git_branch.dart';

class BranchAdapter extends BaseAdapter {
  int _singleResult = 1;

  TerminalOutput toBranches(String _terminalOutput) {
    try {
      List<GitBranch> branches = List();
      toLines(_terminalOutput).forEach((line) {
        if (line.isNotEmpty) {
          branches.add(GitBranch(clean(line)));
        }
      });

      return TerminalOutput(_terminalOutput).success(object: branches);
    } catch (e) {
      return TerminalOutput(_terminalOutput).failure();
    }
  }

  TerminalOutput toBranch(String _terminalOutput) {
    try {
      print("_terminalOutput: " + _terminalOutput);
      List<String> lines = toLines(_terminalOutput);
      String branch = lines.firstWhere(
          (line) =>
              lines.length == _singleResult ||
              (line.isNotEmpty && line.startsWith("*")),
          orElse: () => null);

      return branch != null
          ? TerminalOutput(_terminalOutput).success(object: GitBranch(clean(branch)))
          : TerminalOutput(_terminalOutput).failure();
    } catch (e) {
      return TerminalOutput(_terminalOutput).failure();
    }
  }
}

import 'base/base_adapter.dart';
import '../../../model/git_branch.dart';

class BranchAdapter extends BaseAdapter {
  List<GitBranch> toBranches(String terminalOutput) {
    List<GitBranch> branches = List();
    toLines(terminalOutput).forEach((line) {
      if (line.isNotEmpty) {
        branches.add(GitBranch(clean(line)));
      }
    });

    return branches;
  }

  GitBranch toBranch(String terminalOutput) {
    String branch = toLines(terminalOutput).firstWhere(
        (line) => line.isNotEmpty && line.startsWith("*"),
        orElse: () => null);

    return branch != null ? GitBranch(clean(branch)) : null;
  }
}

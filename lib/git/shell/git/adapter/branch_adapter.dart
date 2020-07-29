import 'package:source_app/git/shell/git/model/git_output.dart';
import 'base/base_adapter.dart';
import '../../../model/git_branch.dart';

class BranchAdapter extends BaseAdapter {
  int _singleResult = 1;

  BranchAdapter(terminalOutput) : super(terminalOutput);

  GitOutput toBranches() {
    return execute(transform: (gitOutput) {
      List<GitBranch> branches = List();
      toLines(gitOutput.message).forEach((line) {
        if (line.isNotEmpty) {
          branches.add(GitBranch(clean(line)));
        }
      });

      return gitOutput.withObject(branches);
    });
  }

  GitOutput toBranch() {
    return execute(transform: (gitOutput) {
      List<String> lines = toLines(gitOutput.message);
      String branch = lines.firstWhere(
              (line) =>
          lines.length == _singleResult ||
              (line.isNotEmpty && line.startsWith("*")),
          orElse: () => null);

      return branch != null
          ? gitOutput.withObject(GitBranch(clean(branch))).success()
          : gitOutput.failure();
    });
  }
}

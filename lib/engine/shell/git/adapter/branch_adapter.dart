import 'package:source_app/engine/domain/model/git_branch.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'base/base_adapter.dart';


class BranchAdapter extends BaseAdapter {
  int _singleResult = 1;

  BranchAdapter(terminalOutput) : super(terminalOutput);

  GitOutput toBranches() {
    return execute(transform: (gitOutput) {
      List<GitBranch> branches = List();
      gitOutput.lines.forEach((line) {
        if (!line.contains("HEAD ->") && line.isNotEmpty) {
          if(line.startsWith("*")) {
            branches.add(GitBranch(clean(line), current: true));
          } else {
            branches.add(GitBranch(clean(line)));
          }
        }
      });
      branches.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      return gitOutput.withObject(branches);
    });
  }

  GitOutput toBranch() {
    return execute(transform: (gitOutput) {
      List<String> lines = gitOutput.lines;
      String branch = lines.firstWhere(
              (line) =>
          lines.length == _singleResult ||
              (line.isNotEmpty && line.startsWith("*")),
          orElse: () => null);

      return branch != null
          ? gitOutput.withObject(GitBranch(clean(branch), current: true)).success()
          : gitOutput.failure();
    });
  }
}

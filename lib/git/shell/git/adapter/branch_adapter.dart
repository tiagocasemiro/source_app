import 'package:source_app/git/shell/git/model/git_output.dart';
import 'base/base_adapter.dart';
import '../../../model/git_branch.dart';

class BranchAdapter extends BaseAdapter {
  int _singleResult = 1;

  GitOutput toBranches(String _gitOutput) {
    try {
      List<GitBranch> branches = List();
      toLines(_gitOutput).forEach((line) {
        if (line.isNotEmpty) {
          branches.add(GitBranch(clean(line)));
        }
      });

      return GitOutput(_gitOutput).success(object: branches);
    } catch (e) {
      return GitOutput(_gitOutput).failure();
    }
  }

  GitOutput toBranch(String _gitOutput) {
    try {
      print("_gitOutput: " + _gitOutput);
      List<String> lines = toLines(_gitOutput);
      String branch = lines.firstWhere(
          (line) =>
              lines.length == _singleResult ||
              (line.isNotEmpty && line.startsWith("*")),
          orElse: () => null);

      return branch != null
          ? GitOutput(_gitOutput).success(object: GitBranch(clean(branch)))
          : GitOutput(_gitOutput).failure();
    } catch (e) {
      return GitOutput(_gitOutput).failure();
    }
  }
}

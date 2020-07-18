import 'adapter/BrancheAdapter.dart';
import 'model/Branch.dart';
import 'shell/Terminal.dart';

class Git {
  String _path;
  Git(this._path);

  Future<List<Branch>> branches() {
    return Terminal(_path).git(['branch', '-r']).then((String terminalOutput) {
      return BranchAdapter().toBranches(terminalOutput != null ? terminalOutput: "");
    });
  }

  Future<Branch> branch() {
    return Terminal(_path).git(['branch']).then((String terminalOutput) {
      return BranchAdapter().toBranch(terminalOutput != null ? terminalOutput: "");
    });
  }
}
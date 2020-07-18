import 'adapter/BrancheAdapter.dart';
import 'model/Branch.dart';
import 'shell/Terminal.dart';

class Git  {

  Future<List<Branch>> branches() {
    return Terminal().git(['branch', '-r']).then((String terminalOutput) {
      return BranchAdapter().toBranches(terminalOutput);
    });
  }

  Future<Branch> branch() {
    return Terminal().git(['branch']).then((String terminalOutput) {
      return BranchAdapter().toBranch(terminalOutput);
    });
  }
}
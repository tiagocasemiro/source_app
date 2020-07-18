import 'BaseAdapter.dart';
import '../model/Branch.dart';

class BranchAdapter extends BaseAdapter {

  List<Branch> toBranches(String terminalOutput) {
    List<Branch> branches = List();
    toLines(terminalOutput).forEach((line) {
      if(line.isNotEmpty) {
        branches.add(Branch(clean(line)));
      }
    });

    return branches;
  }

  Branch toBranch(String terminalOutput) {
    String branch = toLines(terminalOutput).firstWhere(
      (line) => line.isNotEmpty && line.startsWith("*"),
      orElse: () => null
    );

    return branch != null ? Branch(clean(branch)) : null;
  }
}
import 'BaseAdapter.dart';
import '../model/Branch.dart';

class BranchAdapter extends BaseAdapter {

  List<Branch> toBranches(String terminalOutput) {
    List<Branch> branchs = List();
    toLines(terminalOutput).forEach((line) {
      if(line.isNotEmpty) {
        branchs.add(Branch(clean(line)));
      }
    });

    return branchs;
  }

  Branch toBranch(String terminalOutput) {
    if(terminalOutput.isNotEmpty) {
      return Branch(clean(terminalOutput));
    }

    return null;
  }
}
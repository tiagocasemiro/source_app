import 'package:source_app/git/model/git_commit.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';

class LogAdapter extends BaseAdapter {

  List<GitCommit> confirm(String terminalOutput) {
    // TODO implement
    print(terminalOutput);
    return List();
  }
}
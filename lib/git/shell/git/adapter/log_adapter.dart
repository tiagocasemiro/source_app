import 'package:source_app/git/model/git_commit.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class LogAdapter extends BaseAdapter {
  //https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  TerminalOutput<List<GitCommit>> confirm(String terminalOutput) {
    // TODO implement
    print(terminalOutput);
    return TerminalOutput().success(object: List());
  }
}

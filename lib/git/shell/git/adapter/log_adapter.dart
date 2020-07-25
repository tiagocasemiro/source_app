import 'package:source_app/git/model/git_commit.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class LogAdapter extends BaseAdapter {
  //https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  TerminalOutput confirm(String _terminalOutput) {
    // TODO implement
    print(_terminalOutput);
    return TerminalOutput(_terminalOutput).success(object: List());
  }
}

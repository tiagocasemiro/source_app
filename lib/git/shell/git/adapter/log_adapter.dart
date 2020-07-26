import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class LogAdapter extends BaseAdapter {
  //https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  GitOutput confirm(TerminalOutput terminalOutput) {
    //TODO implement

    return toGitOutput(terminalOutput);
  }
}

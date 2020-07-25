import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class PushAdapter extends BaseAdapter {
  GitOutput confirm(TerminalOutput terminalOutput) {
    //TODO implement

    return toGitOutput(terminalOutput);
  }
}

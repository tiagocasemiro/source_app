import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class StatusAdapter extends BaseAdapter {
  GitOutput confirm(TerminalOutput terminalOutput) {
    return toGitOutput(terminalOutput);
  }
}

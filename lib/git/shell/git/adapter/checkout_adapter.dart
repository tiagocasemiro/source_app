import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class CheckoutAdapter extends BaseAdapter {

  GitOutput confirm(TerminalOutput terminalOutput) {
    return toGitOutput(terminalOutput);
  }
}
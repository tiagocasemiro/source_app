import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class PullAdapter extends BaseAdapter {

  PullAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput confirm() {
    //TODO implement

    return execute();
  }
}

import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class StatusAdapter extends BaseAdapter {

  StatusAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput confirm() {
    return execute();
  }
}

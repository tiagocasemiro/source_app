import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class StashAdapter extends BaseAdapter {

  StashAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput confirm() {
    //TODO implement

    return execute();
  }
}

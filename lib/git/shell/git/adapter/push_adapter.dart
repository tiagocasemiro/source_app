import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class PushAdapter extends BaseAdapter {
  TerminalOutput confirm(String _terminalOutput) {
    // TODO implement
    print(_terminalOutput);
    return TerminalOutput(_terminalOutput);
  }
}

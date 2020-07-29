import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class AddAdapter extends BaseAdapter {
  TerminalOutput _terminalOutput;

  AddAdapter(this._terminalOutput);

  GitOutput all() {
    return execute(_terminalOutput);
  }

  GitOutput files() {
    return execute(_terminalOutput);
  }
}

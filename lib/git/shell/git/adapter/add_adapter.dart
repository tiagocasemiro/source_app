import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class AddAdapter extends BaseAdapter {
  TerminalOutput allConfirm(String terminalOutput) {
    return super.noOutputIsSuccess(terminalOutput);
  }

  TerminalOutput filesConfirm(String terminalOutput) {
    return super.noOutputIsSuccess(terminalOutput);
  }
}

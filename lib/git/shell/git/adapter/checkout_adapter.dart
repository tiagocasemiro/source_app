import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class CheckoutAdapter extends BaseAdapter {

  TerminalOutput confirm(String _terminalOutput) {
    print(_terminalOutput);
    return noOutput(_terminalOutput);
  }
}
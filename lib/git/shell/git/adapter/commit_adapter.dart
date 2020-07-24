import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class CommitAdapter extends BaseAdapter {
  TerminalOutput commitToObject(String _terminalOutput) {
    print("Terminal output: " + _terminalOutput);

    toLines(_terminalOutput).forEach((line) {
      if(line.contains("error: ")) {
        return TerminalOutput().failure(_terminalOutput);
      }
    });
    
    return TerminalOutput().success();
  }
}

import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class CommitAdapter extends BaseAdapter {
  TerminalOutput commitToObject(String _terminalOutput) {
    print("Terminal output: " + _terminalOutput);

    toLines(_terminalOutput).forEach((line) {
      if(line.contains("error: ")) {
        print("Falha no commit");
        return TerminalOutput(_terminalOutput).failure();
      }
    });
    print("uhuuuuu sucesso no commit");
    return TerminalOutput(_terminalOutput).success();
  }
}

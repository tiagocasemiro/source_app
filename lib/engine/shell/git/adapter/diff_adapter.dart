import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class DiffAdapter extends BaseAdapter {

  DiffAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput files() {
    return execute(transform: (gitOutput) {
      List<String> files = List();
      gitOutput.lines.forEach((String line) {
        files.add(clean(line));
      });

      return gitOutput.withObject(files);
    });
  }
}

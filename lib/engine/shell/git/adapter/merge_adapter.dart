import 'package:source_app/engine/domain/model/git_merge.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class MergeAdapter extends BaseAdapter {

  MergeAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput confirm() {
    return execute(transform: (gitOutput) {
      Merge merge = Merge();

      gitOutput.lines.forEach((line) {
        if (line.contains('CONFLICT')) {
          merge.hasConflict = true;
        }
      });

      return gitOutput.withObject(merge);
    });
  }
}

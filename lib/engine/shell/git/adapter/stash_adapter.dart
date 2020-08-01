import 'package:source_app/engine/model/git_stash.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class StashAdapter extends BaseAdapter {

  StashAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput toList() {
    return execute(transform: (gitOutput) {
      List<GitStash> stashes = List();
      gitOutput.lines.forEach((line) {
        List<String> parts = line.split(":");
        stashes.add(GitStash(
            parts[0].trim(),
            parts[1].replaceAll("On", "").trim(),
            parts[2].trim()
        ));
      });

      return gitOutput;
    });
  }

  GitOutput toDetails() {
    return execute(transform: (gitOutput) {
      List<String> alterations = gitOutput.lines;

      return gitOutput.withObject(alterations);
    });
  }
}

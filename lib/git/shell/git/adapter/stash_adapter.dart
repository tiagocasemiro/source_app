import 'package:source_app/git/model/git_stash.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class StashAdapter extends BaseAdapter {

  StashAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput toList() {
    return execute(transform: (gitOutput) {
      List<GitStash> stashes = List();
      toLines(gitOutput.message).forEach((line) {
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
}

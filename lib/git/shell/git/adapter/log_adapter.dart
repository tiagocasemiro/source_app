import 'package:source_app/git/model/git_commit.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/command/log.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class LogAdapter extends BaseAdapter {

  LogAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  // to try get color of line -> https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  GitOutput toCommits() {
    return execute(transform: (gitOutput) {
      List<GitCommit> commits = List();
      toLines(gitOutput.message).forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> brokedLine = line.split(Log.breakGraphCharacter);
        commits.add(GitCommit(
            brokedLine[0], brokedLine[1], brokedLine[2], brokedLine[3],
            brokedLine[4]));
      });
      return gitOutput.withObject(commits).success();
    });
  }
}


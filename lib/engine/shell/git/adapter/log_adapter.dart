import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/engine/shell/git/command/log.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class LogAdapter extends BaseAdapter {

  LogAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  // to try get color of line -> https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  GitOutput toCommits() {
    return execute(transform: (gitOutput) {
      List<GitCommit> commits = List();

      gitOutput.lines.forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> breakLine = line.split(Log.breakGraphCharacter);
        if(breakLine.length > 0) {
          if(breakLine.length == 5) {
            commits.add(GitCommit(
                asciiGraph: breakLine[0],
                abbreviatedHash: breakLine[1],
                author: breakLine[2],
                message: breakLine[3],
                date: breakLine[4]));
          } else {
            commits.add(GitCommit(asciiGraph: breakLine[0]));
          }
        }
      });

      return gitOutput.withObject(commits).success();
    });
  }
}


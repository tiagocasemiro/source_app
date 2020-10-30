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

      List<String> hashes = List();

      gitOutput.lines.forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> breakLine = line.split(Log.breakWord);
        if(breakLine.length > 0) {
          if(breakLine.length == 6) {
            List<String> hashesAux;
            if(hashes.length > 0) {
              hashes.add(breakLine[0].trim());
              hashesAux = hashes;
              hashes = List();
            }
            if(commits.length > 0) {
              commits.last.beforeHash = breakLine[1];
            }
            commits.add(GitCommit(
              asciiGraph: breakLine[0].trim(),
              abbreviatedHash: breakLine[1],
              author: breakLine[2],
              message: breakLine[3],
              date: breakLine[4],
              hash: breakLine[5],
              asciiGraphs: hashesAux
            ));
          } else {
            hashes.add(breakLine[0].trim());
          }
        }
      });

      return gitOutput.withObject(commits).success();
    });
  }
}


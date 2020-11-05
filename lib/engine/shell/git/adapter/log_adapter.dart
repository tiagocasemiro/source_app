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
      String beforeLine = "";
      int index = 0;
      gitOutput.lines.forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> breakLine = line.split(Log.breakWord);
        String nextGraph = "";
        if((index + 1) < gitOutput.lines.length) {
          nextGraph = gitOutput.lines[(index + 1)].split(Log.breakWord)[0];
        }
        List<Graph> graph = mountGraph(
            beforeLine.trim().replaceAll("\"", "").split("|"),
            breakLine[0].trim().replaceAll("\"", "").split("|"),
            nextGraph.trim().replaceAll("\"", "").split("|"));
        if(breakLine.length > 0) {
          if(breakLine.length == 6) {
            if(commits.length > 0) {
              commits.last.beforeHash = breakLine[1];
            }
            commits.add(GitCommit(
              graph: graph,
              abbreviatedHash: breakLine[1],
              author: breakLine[2],
              message: breakLine[3],
              date: breakLine[4],
              hash: breakLine[5],
            ));
          }
        }
        beforeLine = breakLine[0];
        index++;
      });

      return gitOutput.withObject(commits).success();
    });
  }

  List<Graph> mountGraph(List<String> beforeGraph, List<String> graph, List<String> nextGraph) {
    print(beforeGraph);
    print(graph);
    print(nextGraph);

    return null;
  }
}


import 'package:flutter/material.dart';
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
      List<Graph> headLine = List();
      gitOutput.lines.forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> breakLine = line.split(Log.breakWord);
        String nextGraph = "";
        if((index + 1) < gitOutput.lines.length) {
          nextGraph = gitOutput.lines[(index + 1)].split(Log.breakWord)[0];
        }
        List<Graph> graph = mountGraph(
            headLine,
            breakLine[0].trim().replaceAll("\"", "").split("|"),
            nextGraph.trim().replaceAll("\"", "").split("|"));
        headLine = graph; // todo verificar se todos esses blocos ficam dentro da condicional
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

  List<Graph> mountGraph(List<Graph> beforeGraph, List<String> hashs, List<String> nextHashs) {
    List<Graph> graphLine = List();
   // graphLine.add(Graph(hash: hashs[0]));

    int index = 0;
    beforeGraph.forEach((currentGraph) {
      int graphLineIndex = graphLine.length - 1 < 0 ? 0 : graphLine.length - 1;
      if(currentGraph.hash == hashs[0]) {
        Graph graph = Graph(hash: hashs[0]);
        graph.commit = true;
        graphLine.add(mount(index, graphLineIndex, graph));
      } else {
        Graph graph = Graph(hash: currentGraph.hash);
        graphLine.add(mount(index, graphLineIndex, graph));
      }
      index++;
    });

    print(hashs);

    return null;
  }

  Graph mount(int from, int current, Graph graph) {

  }
}


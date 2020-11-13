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
      List<Graph> headLine;
      gitOutput.lines.forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> breakedLine = line.split(Log.breakWord);

        List<Graph> graph = createLineGraph(headLine, breakedLine[0]);
        headLine = graph; // todo verificar se todos esses blocos ficam dentro da condicional
        if(breakedLine.length > 0) {
          if(breakedLine.length == 6) {
            if(commits.length > 0) {
              commits.last.beforeHash = breakedLine[1];
            }
            commits.add(GitCommit(
              graph: graph,
              abbreviatedHash: breakedLine[1],
              author: breakedLine[2],
              message: breakedLine[3],
              date: breakedLine[4],
              hash: breakedLine[5],
            ));
          }
        }
      });

      return gitOutput.withObject(commits).success();
    });
  }


  List<Graph> createLineGraph(List<Graph> beforeGraph, String commitWithParents) {
    String hash = commitWithParents.split("|")[0].trim();
    List<String> parents = commitWithParents.split("|")[1].trim().split(" ");

    if(beforeGraph == null) {
      return firstLineGraph(parents);
    }

    return lineGraph(beforeGraph, hash, parents);
  }

  List<Graph> firstLineGraph(List<String> parents) {
    List<Graph> graphLine = List();
    int index = 0;
    parents.forEach((parent) {
      Graph graph = Graph(hash: parent);
      graphLine.add(graph);
      if(index == 0) {
        graph.commit = true;
      } else {
        Graph before = graphLine.last;
        before.vertical = true;
        graph.right_to_right  = true;
      }
      index++;
    });

    return graphLine;
  }

  List<Graph> lineGraph(List<Graph> beforeGraphs, String hash, List<String> parents) {
    List<Graph> graphLine = List();
    beforeGraphs.forEach((beforeGraph) {
      Graph graph = Graph();
      graphLine.add(graph);
    });
    int index = 0;
    beforeGraphs.forEach((beforeGraph) {
      Graph graph = graphLine[index];
      if(beforeGraph.hash == hash) {
        graph.commit = true;
      } else {
        if(beforeGraph.vertical || beforeGraph.left_from_down || beforeGraph.right_from_down) {
          int indexParent = haveHash(parents, beforeGraphs[index].hash);
          if(indexParent != null) {
            newMerge(graphLine, index, indexParent);
          } else {
            graph.vertical = true;
            graph.hash = beforeGraphs[index].hash;
          }
        }
      }
      index++;
    });

    int indexFrom = 0;
    graphLine.forEach((graph) {
      if(graph.commit) {
        parents.forEach((parent) {
          int indexTo = 0;
          bool parentIsNoUsed = true;
          graphLine.forEach((toGraph) {
            if(parent == toGraph.hash) {
              parentIsNoUsed = false;
              toBranch(graphLine, indexFrom, indexTo);
            }
            indexTo++;
          });
          if(parentIsNoUsed) {
            newBranch(graphLine, indexFrom);
          }
        });
      }
      indexFrom++;
    });

    return graphLine;
  }

  int haveHash(List<String> hashs, String hash) {
    int index = 0;
    hashs.forEach((element) {
      if(element == hash) {
        return index;
      }
      index++;
    });

    return null;
  }

  void newMerge(List<Graph> graphLine, int current, int from) {
    if(current > 0) {
      // todo
    }
    if(current < (graphLine.length - 1)) {
      // todo
    }
  }

  void toBranch(List<Graph> graphLine, int current, int to) {
    if(current > 0) {
      // todo
    }
    if(current < (graphLine.length - 1)) {
      // todo
    }
  }

  void newBranch(List<Graph> graphLine, int current) {

  }
}


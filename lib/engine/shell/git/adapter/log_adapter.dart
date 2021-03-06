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
      List<GitCommit> commits = [];
      List<Graph> headLine;
      gitOutput.lines.forEach((line) {
        line = line.replaceAll("\"", "");
        List<String> breakedLine = line.split(Log.breakWord);
        if(breakedLine.length == 6) {
          List<Graph> graph = createLineGraph(headLine, breakedLine[0]);
          headLine = graph;
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
      });

      return gitOutput.withObject(commits).success();
    });
  }

  List<Graph> createLineGraph(List<Graph> beforeGraph, String commitWithParents) {
    String hash = commitWithParents.split("|")[0].trim();
    List<String> parents = commitWithParents.split("|")[1].trim().split(" ");

    if(beforeGraph == null) {
      return firstLineGraph(parents, hash);
    }

    return lineGraph(beforeGraph, hash, parents);
  }

  List<Graph> firstLineGraph(List<String> parents, String hash) {
    List<Graph> graphLine = [];
    Graph graph = Graph(hash: parents[0]);
    graph.start_commit = true;
    graphLine.add(graph);

    for(int index = 1; index < parents.length; index++) {
      fromBottomNewGraph(graphLine, 0, parents[index]);
    }

    return graphLine;
  }

  List<Graph> lineGraph(List<Graph> beforeGraphs, String hash, List<String> parents) {
    int indexCommitGraph;
    List<Graph> graphLine = [];
    beforeGraphs.forEach((beforeGraph) {
      graphLine.add(Graph());
    });

    int index = 0;
    graphLine.forEach((graph) {
      if(beforeGraphs[index].hash == hash) {
        if(parents != null && parents.length > 0) {
          graph.hash = parents[0];
          graph.commit = true;
        } else {
          graph.end_commit = true;
        }
        indexCommitGraph = index;
      } else if((beforeGraphs[index].vertical || beforeGraphs[index].bottom_right || beforeGraphs[index].bottom_left || beforeGraphs[index].commit || beforeGraphs[index].start_commit)
          && beforeGraphs[index].hash != null) {
        graph.vertical = true;
        graph.hash = beforeGraphs[index].hash;
      }
      index++;
    });

    if(indexCommitGraph == null) {
      Graph graph = Graph();
      graph.start_commit = true;
      graphLine.add(graph);
      indexCommitGraph = index;
    }

    List<int> indexBefores = haveHash(beforeGraphs, hash);
    indexBefores.forEach((indexBefore) {
      fromUpGraph(graphLine, indexCommitGraph, indexBefore);
    });

    parents.forEach((parent) {
      int indexTo = 0;
      bool parentIsNoUsed = true;
      graphLine.forEach((toGraph) {
        if(parent == toGraph.hash && parentIsNoUsed) {
          parentIsNoUsed = false;
          fromBottomGraph(graphLine, indexCommitGraph, indexTo);
        }
        indexTo++;
      });
      if(graphLine[indexCommitGraph].hash == null && parentIsNoUsed) {
        parentIsNoUsed = false;
        graphLine[indexCommitGraph].hash = parent;
      }
      if(parentIsNoUsed) {
        fromBottomNewGraph(graphLine, indexCommitGraph, parent);
      }
    });

    while(graphLine.last.hash == null && !graphLine.last.end_commit && !graphLine.last.top_left) {
      graphLine.removeLast();
    }

    for(int i = 1; i < graphLine.length; i++) {
      Graph before = graphLine[i - 1];
      Graph current = graphLine[i];

      if(before.isEmpty() && current.onlyVertical()) {  
        before.hash = current.hash;
        before.bottom_right = true;

        current.hash = null;
        current.vertical = false;
        current.top_left = true;
      }
    }

    return graphLine;
  }

  List<int> haveHash(List<Graph> beforeGraphs, String hash) {
    List<int> indexs = [];
    int indexCheck = 0;
    beforeGraphs.forEach((beforeGraph) {
      if(beforeGraph.hash == hash) {
        indexs.add(indexCheck);
      }

      indexCheck++;
    });

    return indexs;
  }

  void fromUpGraph(List<Graph> graphLine, int current, int from) {
    int start;
    int end;
    if(current != from) {
      if(current < from) {
        graphLine[current].right_to_right = true;
        graphLine[from].top_left = true;
        graphLine[from].vertical = false;
        graphLine[from].hash = null;
        start = current;
        end = from;
      } else {
        graphLine[current].left_to_left = true;
        graphLine[from].top_right = true;
        graphLine[from].vertical = false;
        graphLine[from].hash = null;
        start = from;
        end = current;
      }
      int index = 0;
      graphLine.forEach((graph) {
        if(index > start && index < end) {
          graph.horizontal = true;
        }
        index++;
      });
    }
  }

  void fromBottomGraph(List<Graph> graphLine, int current, int to) {
    int start;
    int end;
    if(current < to) {
      graphLine[current].right_to_right = true;
      graphLine[to].bottom_left = true;
      start = current;
      end = to;
    } else if(current > to) {
      graphLine[current].left_to_left = true;
      graphLine[to].bottom_right = true;
      start = to;
      end = current;
    }

    if(start != null && end != null ){
      int index = 0;
      graphLine.forEach((graph) {
        if(index > start && index < end) {
          graph.horizontal = true;
        }
        index++;
      });
    }
  }

  void fromBottomNewGraph(List<Graph> graphLine, int current, String hash) {
    int size = graphLine.length;
    int indexOfEmpty;
    for(int index = 0; index < size; index++) {
      if(graphLine[index].hash == null) {
        indexOfEmpty = index;
      }
    }
    if(indexOfEmpty == null) {
      indexOfEmpty = size;
    }
    Graph graph = Graph(hash: hash);
    graphLine.add(graph);
    fromBottomGraph(graphLine, current, indexOfEmpty);
  }
}
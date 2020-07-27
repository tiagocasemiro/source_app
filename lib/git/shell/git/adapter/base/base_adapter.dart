import 'dart:convert';

import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class BaseAdapter {
  String prefixOutputError = "error: ";

  String removeBreakLine(String line) {
    return line?.replaceAll("\n", "");
  }

  String removePointer(String line) {
    return line?.replaceAll("*", "");
  }

  String clean(String line) {
    return removePointer(removeBreakLine(line))?.trim();
  }

  List<String> toLines(String gitOutput) {
    return const LineSplitter().convert(gitOutput);
  }

  GitOutput toGitOutput(TerminalOutput terminalOutput) {
    try {
      print("Terminal output: " + terminalOutput.toString());
      var gitOutput = GitOutput(terminalOutput.message);
      if (terminalOutput.isFailure()) {
        return gitOutput.failure();
      }
      toLines(terminalOutput.message).forEach((line) {
        if (line.contains(prefixOutputError)) {
          return gitOutput.failure();
        }
      });

      return gitOutput.success();
    } catch (e) {
      e.printStackTrace();
      return GitOutput(terminalOutput.message).failure();
    }
  }
}

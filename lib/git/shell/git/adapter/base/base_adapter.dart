import 'dart:convert';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

abstract class BaseAdapter {
  String _prefixOutputError = "error: ";
  TerminalOutput _terminalOutput;

  BaseAdapter(this._terminalOutput);

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

  GitOutput execute({GitOutput transform(GitOutput gitOutput)}) {
    try {
      print("Terminal output: " + _terminalOutput.toString());
      var gitOutput = GitOutput(_terminalOutput.message);
      if (_terminalOutput.isFailure()) {
        return gitOutput.failure();
      }
      toLines(_terminalOutput.message).forEach((line) {
        if (line.contains(_prefixOutputError)) {
          return gitOutput.failure();
        }
      });

      return ((transform != null)? transform(gitOutput) : gitOutput).success();
    } catch (e) {
      e.printStackTrace();

      return GitOutput(_terminalOutput.message).failure();
    }
  }
}

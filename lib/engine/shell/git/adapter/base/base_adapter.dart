import 'dart:convert';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

abstract class BaseAdapter {
  String _prefixOutputError = "error: ";
  String _prefixOutputFatal = "fatal: ";
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

  GitOutput execute({GitOutput transform(GitOutput gitOutput)}) {
    try {
      print("Terminal output: " + _terminalOutput.toString());
      var gitOutput = GitOutput(_terminalOutput.message);
      if (_terminalOutput.isFailure()) {
        return gitOutput.failure();
      }
      gitOutput.lines.forEach((line) {
        if (line.contains(_prefixOutputError) || line.contains(_prefixOutputFatal)) {
          return gitOutput.failure();
        }
      });

      return ((transform != null)? transform(gitOutput) : gitOutput).success();
    } catch (e) {
      return GitOutput(_terminalOutput.message).failure();
    }
  }
}

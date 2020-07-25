import 'dart:convert';
import 'package:source_app/git/shell/model/terminal_output.dart';

class BaseAdapter {
  String _prefixOutputError = "error: ";

  String removeBreakLine(String line) {
    return line?.replaceAll("\n", "");
  }

  String removePointer(String line) {
    return line?.replaceAll("*", "");
  }

  String clean(String line) {
    return removePointer(removeBreakLine(line))?.trim();
  }

  List<String> toLines(String terminalOutput) {
    return const LineSplitter().convert(terminalOutput);
  }

  TerminalOutput noOutput(String _terminalOutput) {
    print("Terminal output: " + _terminalOutput);
    bool isSuccess = _terminalOutput.trim().isEmpty;

    return isSuccess
        ? TerminalOutput(_terminalOutput).success()
        : noError(_terminalOutput);
  }

  TerminalOutput noError(String _terminalOutput) {
    print("Terminal output: " + _terminalOutput);
    toLines(_terminalOutput).forEach((line) {
      if(line.contains(_prefixOutputError)) {
        return TerminalOutput(_terminalOutput).failure();
      }
    });

    return TerminalOutput(_terminalOutput).success();
  }
}

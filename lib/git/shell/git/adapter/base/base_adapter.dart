import 'dart:convert';
import 'package:source_app/git/shell/model/terminal_output.dart';

class BaseAdapter {
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

  TerminalOutput noOutputIsSuccess(String _terminalOutput) {
    print("Terminal output: " + _terminalOutput);
    bool isSuccess = _terminalOutput.trim().isEmpty;

    return isSuccess
        ? TerminalOutput().success()
        : TerminalOutput().failure(_terminalOutput);
  }
}

import 'dart:convert';
import 'package:source_app/git/shell/git/model/git_output.dart';

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

  List<String> toLines(String gitOutput) {
    return const LineSplitter().convert(gitOutput);
  }

  GitOutput noOutput(String _gitOutput) {
    print("Terminal output: " + _gitOutput);
    bool isSuccess = _gitOutput.trim().isEmpty;

    return isSuccess
        ? GitOutput(_gitOutput).success()
        : noError(_gitOutput);
  }

  GitOutput noError(String _gitOutput) {
    print("Terminal output: " + _gitOutput);
    toLines(_gitOutput).forEach((line) {
      if(line.contains(_prefixOutputError)) {
        return GitOutput(_gitOutput).failure();
      }
    });

    return GitOutput(_gitOutput).success();
  }
}

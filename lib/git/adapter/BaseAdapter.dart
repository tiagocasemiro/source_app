
class BaseAdapter {

  String removeBreakLine(String line) {
    return line.replaceAll("\n", "");
  }

  String removePointer(String line) {
    return line.replaceAll("*", "");
  }

  String clean(String line) {
    return removePointer(removeBreakLine(line)).trim();
  }

  List<String> toLines(String terminalOutput) {
    return terminalOutput.split("\n");
  }

}
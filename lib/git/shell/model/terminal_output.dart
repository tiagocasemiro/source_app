import 'package:source_app/git/shell/extension/extension.dart';

class TerminalOutput<T> {
  TerminalOutput({this.isSuccess = true, this.message ="", this.object});

  bool isSuccess;
  String message;
  T object;
}

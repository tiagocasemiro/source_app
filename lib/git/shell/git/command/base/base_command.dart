import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import '../../../terminal.dart';

abstract class BaseGitCommand {
  static const String _language = 'LANG=en_GB ';
  static const String _git = '$_language git';

  final List<String> parameters = List();
  String _workDirectory;

  BaseGitCommand(this._workDirectory);

  Future<TerminalOutput> execute({List<String> parameters = const []}) async {
    _printCommand(parameters);
    TerminalOutput gitOutput = await Terminal(_workDirectory).run(_git, parameters: parameters);

    return gitOutput;
  }

  void _printCommand(List<String> parameters) {
    print("Directory: " + _workDirectory);
    var allParameters = "";
    parameters.forEach((element) {
      allParameters += " " + element;
    });
    print("Command : " + _git + allParameters);
  }

  Future<GitOutput> call();
}

class NoParameterException implements Exception {
  final String msg;
  const NoParameterException({this.msg = "No parameter. Call some method like current() to result"});
  String toString() => 'NoParameterException: $msg';
}

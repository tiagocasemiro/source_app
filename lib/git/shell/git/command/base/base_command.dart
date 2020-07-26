import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import '../../../terminal.dart';

abstract class BaseGitCommand {
  static const String _git = 'git';

  final List<String> parameters = List();
  String _workDirectory;

  BaseGitCommand(this._workDirectory);

  Future<TerminalOutput> execute({List<String> parameters = const []}) async {
    print("Directory: " + _workDirectory);
    var allParameters = "";
    parameters.forEach((element) {
      allParameters += " " + element;
    });
    print("Command : " + _git + allParameters);

    TerminalOutput gitOutput = await Terminal(_workDirectory).run(_git, parameters: parameters);

    return gitOutput;
  }

  Future<GitOutput> call();
}

class NoParameterException implements Exception {
  final String msg;
  const NoParameterException({this.msg = "No parameter. Call some method like current() to result"});
  String toString() => 'NoParameterException: $msg';
}

import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import '../../../terminal.dart';

abstract class BaseGitCommand {
  static const Map<String, String> _language = {'LANG':'en_GB'};
  static const String _git = 'git';

  final List<String> parameters = List();
  String _workDirectory;

  BaseGitCommand(this._workDirectory);

  Future<TerminalOutput> execute({List<String> parameters = const []}) async {
    //_printCommand(parameters);
    TerminalOutput gitOutput = await Terminal(_workDirectory).run(_git, parameters: parameters, environment: _language);

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

  Future<GitOutput> call(); //todo add try catch to all
}

class NoParameterException implements Exception {
  final String msg;
  const NoParameterException({this.msg = "No parameter. Call some method like current() to result"});
  String toString() => 'NoParameterException: $msg';
}

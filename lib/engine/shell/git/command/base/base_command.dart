import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import '../../../terminal.dart';

abstract class BaseGitCommand {
  Map<String, String> _environmentVariable = {'LANG':'en_GB'};
  static const String _git = 'git';

  final List<String> parameters = [];
  String _workDirectory;

  BaseGitCommand(this._workDirectory);

  Future<TerminalOutput> execute({List<String> parameters = const []}) async {
    //_printCommand(parameters);
    try {
      TerminalOutput gitOutput = await Terminal(_workDirectory).run(
          _git, parameters: parameters, environment: _environmentVariable);

      return gitOutput;
    } catch (e) {
      TerminalOutput gitOutput = TerminalOutput(e.toString(), 1);

      return gitOutput;
    }
  }

  // ignore: unused_element
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

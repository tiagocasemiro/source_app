import 'package:source_app/git/shell/extension/extension.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import '../../../terminal.dart';

abstract class BaseGitCommand {
  static const String git = 'git';
  static const String status = 'status';

  final List<String> parameters = List();
  String _workDirectory;

  BaseGitCommand(this._workDirectory);

  Future<String> execute({List<String> parameters = const []}) async {
    String terminalOutput =
        await Terminal(_workDirectory).run(git, parameters: parameters);

    return terminalOutput != null ? terminalOutput : Shell.empty();
  }

  Future<int> executeAndReturnExitCode(
      {List<String> parameters = const []}) async {
    final int processResult = await Terminal(_workDirectory)
        .runAndReturnExitCode(git, parameters: parameters);

    return processResult;
  }

  Future<TerminalOutput> call();
}

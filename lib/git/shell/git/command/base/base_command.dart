import '../../../terminal.dart';

abstract class BaseGitCommand {
  final String git = 'git';
  final String noResult = "";
  String workDirectory;
  final List<String> parameters = List();

  BaseGitCommand(this.workDirectory);

  String execute({List<String> parameters = const []}) {
    String terminalOutput = Terminal(workDirectory).run(git, parameters: parameters) as String;

    return terminalOutput != null ? terminalOutput: "";
  }
}
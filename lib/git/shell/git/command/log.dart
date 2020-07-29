import 'package:source_app/git/shell/git/adapter/log_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Log extends BaseGitCommand {
  static const String breakGraphCharacter = "#";
  static const String historyFormat = "$breakGraphCharacter %h $breakGraphCharacter %an $breakGraphCharacter %s $breakGraphCharacter %as";

  Log(String workDirectory) : super(workDirectory) {
    parameters.add('--no-pager');
    parameters.add('log');
  }

  Log pretty(String format) {
    parameters.add("--pretty=format:\"$format\"");

    return this;
  }

  Log graph() {
    parameters.add('--graph');

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return LogAdapter(terminalOutput).toCommits();
  }
}

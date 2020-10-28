import 'package:source_app/engine/shell/git/adapter/log_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Log extends BaseGitCommand {
  static const String breakGraphCharacter = "#";
  static const String historyFormat = "%h|%p|%d$breakGraphCharacter %h $breakGraphCharacter %an $breakGraphCharacter %s $breakGraphCharacter %as $breakGraphCharacter %H";
  //git log --all --date-order --pretty="%H|%P|%d"

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

  Log all() {
    parameters.add('--all');

    return this;
  }

  Log dateOrder() {
    parameters.add('--date-order');

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return LogAdapter(terminalOutput).toCommits();
  }
}

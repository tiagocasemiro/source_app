import 'package:source_app/git/shell/git/adapter/tag_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Tag extends BaseGitCommand {
  Tag(workDirectory) : super(workDirectory) {
    parameters.add('tag');
  }

  Tag create(String name) {
    parameters.add(name);

    return this;
  }

  Tag delete(String name) {
    parameters.add('-d');
    parameters.add(name);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return TagAdapter().toTags(terminalOutput);
  }
}

import 'package:source_app/engine/shell/git/adapter/add_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Add extends BaseGitCommand {
  String _dot = ".";

  Add(workDirectory) : super(workDirectory) {
    parameters.add("add");
  }

  Add all() {
    parameters.add(_dot);

    return this;
  }

  Add files(List<String> files) {
    parameters.addAll(files);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return AddAdapter(terminalOutput).execute();
  }
}


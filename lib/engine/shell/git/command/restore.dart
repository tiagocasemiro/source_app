import 'package:source_app/engine/shell/git/adapter/restore_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Restore extends BaseGitCommand {
  Restore(String workDirectory) : super(workDirectory) {
    parameters.add('restore');
  }

  Restore all() {
    parameters.add('--staged');
    parameters.add('.');
        
    return this;
  }

  Restore files(List<String> files) {
    parameters.add('--staged');
    parameters.addAll(files);

    return this;
  }
  
  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return RestoreAdapter(terminalOutput).execute();
  }
}
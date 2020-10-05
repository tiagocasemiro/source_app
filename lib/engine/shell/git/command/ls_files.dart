import 'package:source_app/engine/shell/git/adapter/ls_files_adapter.dart';
import 'package:source_app/engine/shell/git/command/base/base_command.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class LsFiles extends BaseGitCommand {
  LsFiles(String workDirectory) : super(workDirectory) {
    parameters.add('ls-files');
  }

  LsFiles others() {
    parameters.add("--others");

    return this;
  }

  LsFiles excludeStandard() {
    parameters.add("--exclude-standard");

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return LsFilesAdapter(terminalOutput).files();
  }
}
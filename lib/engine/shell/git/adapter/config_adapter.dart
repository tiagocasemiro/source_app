import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class ConfigAdapter extends BaseAdapter {
  ConfigAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput url() {
    return execute(transform: (GitOutput gitOutput) {
      GitRemote gitRemote = GitRemote();
      gitRemote.url = clean(gitOutput.message);
      gitOutput.object = gitRemote;

      return gitOutput;
    });
  }
}
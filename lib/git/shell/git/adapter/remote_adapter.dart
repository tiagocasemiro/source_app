import 'package:source_app/git/model/git_remote.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class RemoteAdapter extends BaseAdapter {

  RemoteAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput remote() {
    return execute(transform: (gitOutput) {
      String name = gitOutput.message.trim();
      GitRemote gitRemote = GitRemote(name);

      return gitOutput.withObject(gitRemote);
    });
  }
}
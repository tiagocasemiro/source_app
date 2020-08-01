import 'package:source_app/git/model/git_remote.dart';
import 'package:source_app/git/shell/git/adapter/remote_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Remote extends BaseGitCommand {
  _Variant _variant;

  Remote(String workDirectory) : super(workDirectory) {
    parameters.add('remote');
  }

  Remote show(GitRemote gitRemote) {
    parameters.add('show');
    parameters.add(gitRemote.name);
    _variant = _Variant.show;

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    switch(_variant) {
      case _Variant.show:
        return RemoteAdapter(terminalOutput).show();
        break;
    }

    return RemoteAdapter(terminalOutput).remote();
  }
}

enum _Variant { show }

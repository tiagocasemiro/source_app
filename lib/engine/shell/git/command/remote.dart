import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/adapter/remote_adapter.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Remote extends BaseGitCommand {
  _Variant _variant;

  Remote(String workDirectory) : super(workDirectory) {
    parameters.add('remote');
  }

  Remote showFrom(String origin) {
    parameters.add('show');
    parameters.add(origin);
    _variant = _Variant.show;

    return this;
  }

  Remote show() {
    parameters.add('show'); 
  
    return this;
  }

  Remote showWithCredentials(GitRemote gitRemote) {
    parameters.add('show');
    parameters.add(Git.credentials());
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

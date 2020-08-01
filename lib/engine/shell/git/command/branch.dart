import 'package:source_app/engine/shell/git/adapter/branch_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Branch extends BaseGitCommand {
  _Variant _variant;

  Branch(String _workDirectory) : super(_workDirectory) {
    parameters.add('branch');
  }

  Branch remote() {
    _variant = _Variant.remote;
    parameters.add('-r');

    return this;
  }

  Branch current() {
    _variant = _Variant.current;
    parameters.add('--show-current');

    return this;
  }

  Branch create(String name) {
    parameters.add(name);

    return this;
  }

  Branch rename(String oldName, String newName) {
    parameters.add('-m');
    parameters.add(oldName);
    parameters.add(newName);

    return this;
  }

  Branch delete(String name) {
    parameters.add('-d');
    parameters.add(name);

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    switch (_variant) {
      case _Variant.current:
        return BranchAdapter(terminalOutput).toBranch();
      case _Variant.remote:
        return BranchAdapter(terminalOutput).toBranches();
      default:
        return BranchAdapter(terminalOutput).execute();
    }
  }
}

enum _Variant { current, remote }

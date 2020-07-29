import 'package:source_app/git/shell/git/adapter/branch_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Branch extends BaseGitCommand {
  _Variant _variant = _Variant.multiple;

  Branch(String _workDirectory) : super(_workDirectory) {
    parameters.add('branch');
  }

  Branch remote() {
    _variant = _Variant.multiple;
    parameters.add('-r');

    return this;
  }

  Branch current() {
    _variant = _Variant.single;
    parameters.add('--show-current');

    return this;
  }

  Branch create(String name) {
    _variant = _Variant.noOutput;
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
    _variant = _Variant.noOutput;

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    switch (_variant) {
      case _Variant.single:
        return BranchAdapter(terminalOutput).toBranch();
      case _Variant.multiple:
        return BranchAdapter(terminalOutput).toBranches();
      case _Variant.noOutput:
        return BranchAdapter(terminalOutput).execute();
      default:
        throw NoParameterException();
    }
  }
}

enum _Variant { single, multiple, noOutput }

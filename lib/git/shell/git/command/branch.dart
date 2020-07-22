import 'package:source_app/git/shell/extension/extension.dart';
import 'package:source_app/git/shell/git/adapter/branch_adapter.dart';
import 'base/base_command.dart';

class Branch extends BaseGitCommand  {
  _Variant _variant;

  Branch(String _workDirectory): super(_workDirectory) {
    parameters.add('branch');
  }

  Branch remote() {
    _variant = _Variant.multiple;
    parameters.add('-r');

    return this;
  }

  Branch local() {
    _variant = _Variant.multiple;

    return this;
  }

  Branch current() {
    _variant = _Variant.single;
    parameters.add('--show-current');

    return this;
  }

  Branch create(String name) {
    _variant = _Variant.single;
    parameters.add(name);

    return this;
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    switch(_variant) {
      case _Variant.single: return BranchAdapter().toBranch(terminalOutput);
      case _Variant.multiple: return BranchAdapter().toBranches(terminalOutput);
      default: return Shell.empty();
    }
  }
}

enum _Variant {
  single, multiple
}
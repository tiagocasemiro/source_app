import 'package:source_app/git/shell/git/adapter/branch_adapter.dart';
import 'base/base_command.dart';

class Branch extends BaseGitCommand  {
  _Variant _variant;

  Branch(String workDirectory): super(workDirectory) {
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

  Future call() async {
    String terminalOutput = super.execute(parameters: parameters);

    switch(_variant) {
      case _Variant.single: return BranchAdapter().toBranch(terminalOutput);
      case _Variant.multiple: return BranchAdapter().toBranches(terminalOutput);
      default: return noResult;
    }
  }
}

enum _Variant {
  single, multiple
}
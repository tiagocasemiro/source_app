import 'package:source_app/git/shell/extension/extension.dart';
import 'package:source_app/git/shell/git/adapter/add_adapter.dart';
import 'package:source_app/git/shell/git/command/base/base_command.dart';

class Add extends BaseGitCommand {
  String _dot = ".";
  _Variant _variant;

  Add(workDirectory): super(workDirectory) {
    parameters.add("add");
  }

  Add all() {
    parameters.add(_dot);
    _variant = _Variant.all;

    return this;
  }

  Add files(List<String> files) {
    parameters.addAll(files);
    _variant = _Variant.files;

    return this;
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    switch(_variant) {
      case _Variant.all: return AddAdapter().filesConfirm(terminalOutput);
      case _Variant.files: return AddAdapter().allConfirm(terminalOutput);
      default: return Shell.empty();
    }
  }
}

enum _Variant {
  all, files
}
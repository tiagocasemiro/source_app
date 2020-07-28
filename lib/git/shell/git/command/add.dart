import 'package:source_app/git/shell/git/adapter/add_adapter.dart';
import 'package:source_app/git/shell/git/adapter/add_adapter.dart';
import 'package:source_app/git/shell/git/adapter/base/tamplete_method_adapter.dart';
import 'package:source_app/git/shell/git/command/base/base_command.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class Add extends BaseGitCommand {
  String _dot = ".";
  _Variant _variant;

  Add(workDirectory) : super(workDirectory) {
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
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    switch (_variant) {
      case _Variant.all:
        return Adapter(terminalOutput).execute(AddFilesAdapter());
      case _Variant.files:
        return Adapter(terminalOutput).execute(AddAllAdapter());
      default:
        throw NoParameterException();
    }
  }
}

enum _Variant { all, files }

import 'package:source_app/git/model/git_stash.dart';
import 'package:source_app/git/shell/git/adapter/stash_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Stash extends BaseGitCommand {
  _Variant _variant;

  Stash(String workDirectory) : super(workDirectory) {
    parameters.add('stash');
  }

  Stash list() {
    parameters.add('list');
    _variant = _Variant.list;

    return this;
  }

  Stash apply(GitStash gitStash) {
    parameters.add('apply');
    parameters.add(gitStash.reference);

    return this;
  }

  Stash create(String name) {
    parameters.add('save');
    parameters.add(name);

    return this;
  }

  Stash drop(GitStash gitStash) {
    parameters.add('drop');
    parameters.add(gitStash.reference);

    return this;
  }
  
  Stash show(GitStash gitStash) {
    parameters.add('show');
    parameters.add(gitStash.reference);
    _variant = _Variant.show;

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    switch(_variant) {
      case _Variant.list:
        return StashAdapter(terminalOutput).toList();
        break;
      case _Variant.show:
        return StashAdapter(terminalOutput).toDetails();
        break;
    }

    return StashAdapter(terminalOutput).execute();
  }
}

enum _Variant { list, show }

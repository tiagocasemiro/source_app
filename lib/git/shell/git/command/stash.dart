import 'package:source_app/git/shell/git/adapter/stash_adapter.dart';
import 'base/base_command.dart';

class Stash extends BaseGitCommand {
  Stash(String workDirectory) : super(workDirectory) {
    parameters.add('stash');
  }

  Stash list() {
    parameters.add('list');

    return this;
  }

  Stash apply() {
    parameters.add('apply');

    return this;
  }

  Stash create(String name) {
    parameters.add('create');
    parameters.add(name);

    return this;
  }

  Stash drop(String name) {
    parameters.add('drop');
    parameters.add(name);

    return this;
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return StashAdapter().confirm(terminalOutput);
  }
}

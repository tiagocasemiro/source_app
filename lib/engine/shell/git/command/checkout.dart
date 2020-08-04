import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/shell/git/adapter/checkout_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_command.dart';

class Checkout extends BaseGitCommand {
  final String _repository;
  Checkout(String workDirectory, this._repository) : super(workDirectory) {
    parameters.add('checkout');
  }

  Checkout branch(String name) {
    parameters.add(name);

    return this;
  }

  Checkout commit(GitCommit gitCommit) {
    parameters.add(gitCommit.hash);

    return this;
  }

  Checkout remoteBranch(String localName, String remoteName) {
    parameters.add('-b');
    parameters.add(localName);
    parameters.add('$_repository/$remoteName');

    return this;
  }

  @override
  Future<GitOutput> call() async {
    TerminalOutput terminalOutput = await super.execute(parameters: parameters);

    return CheckoutAdapter(terminalOutput).execute();
  }
}

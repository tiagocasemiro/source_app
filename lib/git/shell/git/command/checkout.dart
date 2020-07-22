import 'package:source_app/git/model/git_commit.dart';
import 'package:source_app/git/shell/git/adapter/checkout_adapter.dart';
import 'base/base_command.dart';

class Checkout extends BaseGitCommand {
  Checkout(String workDirectory) : super(workDirectory) {
    parameters.add('checkout');
  }

  Checkout banch(String name) {
    parameters.add(name);

    return this;
  }

  Checkout commit(GitCommit gitCommit) {
    parameters.add(gitCommit.hash);

    return this;
  }

  @override
  Future call() async {
    String terminalOutput = await super.execute(parameters: parameters);

    return CheckoutAdapter().confirm(terminalOutput);
  }

}
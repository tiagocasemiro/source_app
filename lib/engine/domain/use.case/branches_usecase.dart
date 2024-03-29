import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class BranchesUseCase {
  Future<GitOutput> current() async {
    return Git().branch().current().call();
  }

  Future<GitOutput> local() async {
    return Git().branch().local().call();
  }

  Future<GitOutput> delete(String name) async {
    return Git().branch().delete(name).call();
  }

  Future<GitOutput> remote() async {
    return Git().branch().remote().call();
  }

  Future<GitOutput> newBranch(String branchName) async {
    return Git().branch().create(branchName).call();
  }

  Future<GitOutput> mergeWith(String branchName) async {
    return Git().merge().branch(branchName).call();
  }

  Future<GitOutput> checkoutLocalBranch(String branchName) async {
    return Git().checkout().localBranch(branchName).call();
  }

  Future<GitOutput> checkoutTag(String name) async {
    return Git().checkout().tag(name).call();
  }

  Future<GitOutput> checkoutRemoteBranch(String branchName) async {
    String repository = Git.origin();

    return Git().checkout().remoteBranch(branchName.replaceAll("$repository/", ""), branchName).call();
  }
}

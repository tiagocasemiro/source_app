import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class BranchesUseCase {
  Future<GitOutput> local() async {
    return Git().branch().call();
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
}

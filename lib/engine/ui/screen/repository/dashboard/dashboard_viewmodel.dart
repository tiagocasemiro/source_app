import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/model/git_stash.dart';
import 'package:source_app/engine/domain/use.case/branches_usecase.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'package:source_app/engine/domain/use.case/stashes_usecase.dart';
import 'package:source_app/engine/domain/use.case/tags_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'dart:async';

class DashboardViewModel {
  final StreamController<bool> _localBranchesController = StreamController<bool>.broadcast();
  Stream<bool> get localBranchesOutput => _localBranchesController.stream;

  Future<bool> checkCredentialAndInitRepository(Repository repository, String username, String password) async {
    StartApplicationUseCase startApplicationUseCase = StartApplicationUseCase();
    bool isStarted = await startApplicationUseCase.startGitApplicationWithCredentials(repository.workDirectory, username, password);
    if(isStarted) {
      return await startApplicationUseCase.checkCredentials(repository.workDirectory);
    }

    return false;
  }

  Future<bool> checkCredentials(Repository repository) async {
    return await StartApplicationUseCase().checkCredentials(repository.workDirectory);
  }

  void refreshLocalBranches() async {
    _localBranchesController.sink.add(true);
  }

  Future<GitOutput> localBranches() async {
    GitOutput gitOutput = await BranchesUseCase().local();


    return gitOutput;
  }

  Future<GitOutput> remoteBranches() async {
    GitOutput gitOutput = await BranchesUseCase().remote();

    return gitOutput;
  }

  Future<GitOutput> checkoutLocalBranch(String name) async {
    GitOutput gitOutput = await BranchesUseCase().checkoutLocalBranch(name);
    if(gitOutput.isSuccess()) {
      refreshLocalBranches();
    }

    return gitOutput;
  }

  Future<GitOutput> checkoutRemoteBranch(String name) async {
    GitOutput gitOutput = await BranchesUseCase().checkoutRemoteBranch(name);
    if(gitOutput.isSuccess()) {
      refreshLocalBranches();
    }

    return gitOutput;
  }

  Future<GitOutput> tags() async {
    GitOutput gitOutput = await TagsUseCase().all();

    return gitOutput;
  }

  Future<GitOutput> stashs() async {
    GitOutput gitOutput = await StashesUseCase().all();

    return gitOutput;
  }

  Future<GitOutput> apply(GitStash stash) async {
    GitOutput gitOutput = await StashesUseCase().apply(stash);

    return gitOutput;
  }

  void dispose() {
    _localBranchesController.close();
  }
}
import 'package:source_app/engine/domain/model/git_stash.dart';
import 'package:source_app/engine/domain/model/git_tag.dart';
import 'package:source_app/engine/domain/use.case/branches_usecase.dart';
import 'package:source_app/engine/domain/use.case/stashes_usecase.dart';
import 'package:source_app/engine/domain/use.case/tags_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'dart:async';

class BodyLeftViewModel {
  final StreamController<bool> _localBranchesController = StreamController<bool>.broadcast();
  Stream<bool> get localBranchesOutput => _localBranchesController.stream;

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

  Future<GitOutput> checkoutTag(GitTag tag) async {
    GitOutput gitOutput = await BranchesUseCase().checkoutTag(tag.name);

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
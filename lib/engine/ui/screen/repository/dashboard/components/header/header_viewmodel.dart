import 'dart:async';
import 'package:source_app/engine/domain/model/git_branch.dart';
import 'package:source_app/engine/domain/use.case/branches_usecase.dart';
import 'package:source_app/engine/domain/use.case/fetch_usecase.dart';
import 'package:source_app/engine/domain/use.case/pull_usecase.dart';
import 'package:source_app/engine/domain/use.case/push_usecase.dart';
import 'package:source_app/engine/domain/use.case/stashes_usecase.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-right/body_right_viewmodel.dart';

class HeaderViewModel {
  final BodyLeftViewModel _bodyLeftViewModel;
  final BodyRightViewModel _bodyRightViewModel;

  HeaderViewModel(this._bodyLeftViewModel, this._bodyRightViewModel);

  Future<GitOutput> push() async {
    GitOutput gitOutput = await BranchesUseCase().current();

    if(gitOutput.isSuccess()) {
      GitBranch gitBranch = gitOutput.object as GitBranch;

      gitOutput = await PushUseCase().push(gitBranch.name);
    }

    return gitOutput;
  }

  void displayCommit() {
    _bodyRightViewModel.displayCommit();
  }

  Future<GitOutput> pull(GitBranch branch) async {
    if(branch != null) {
      String origin = Git.origin();
      String name = branch.name.replaceFirst("${Git.origin()}/", "");

      return await PullUseCase().pullOtherBranch(origin, name);
    }

    return await PullUseCase().pull();
  }

  Future<GitOutput> remoteBranches() async {
    return await BranchesUseCase().remote();
  }

  Future<GitOutput> fetch() async {
    GitOutput gitOutput = await FetchUseCase().fetch();

    if(gitOutput.isSuccess()) {
      _bodyLeftViewModel.refreshLocalBranches();
    }
    return gitOutput;
  }

  Future<GitOutput> newBranch(String name) async {
    GitOutput gitOutput = await BranchesUseCase().newBranch(name);

    if(gitOutput.isSuccess()) {
      _bodyLeftViewModel.refreshLocalBranches();
    }
    return gitOutput;
  }

  Future<GitOutput> newBranchAndCheckout(String name) async {
    GitOutput gitOutput = await BranchesUseCase().newBranch(name);

    if(gitOutput.isSuccess()) {
      gitOutput = await  BranchesUseCase().checkoutLocalBranch(name);
    }

    if(gitOutput.isSuccess()) {
      _bodyLeftViewModel.refreshLocalBranches();
    }
    return gitOutput;
  }

  Future<GitOutput> createStash(String name) async {
    GitOutput gitOutput = await StashesUseCase().create(name);

    if(gitOutput.isSuccess()) {
      _bodyLeftViewModel.refreshStash();
    }

    return gitOutput;
  }

  Future<GitOutput> merge(GitBranch branch) async {
    if(branch == null) {
      return GitOutput("It is necessary to select a branch").failure();
    }
    GitOutput gitOutput = await BranchesUseCase().mergeWith(branch.name);

    return gitOutput;
  }

  Future<GitOutput> localBranches() async {
    return await BranchesUseCase().local();
  }
}
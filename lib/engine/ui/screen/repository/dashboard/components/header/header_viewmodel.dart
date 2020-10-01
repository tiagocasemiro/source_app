import 'dart:async';
import 'dart:io';

import 'package:source_app/engine/domain/model/git_branch.dart';
import 'package:source_app/engine/domain/use.case/branches_usecase.dart';
import 'package:source_app/engine/domain/use.case/commit_usecase.dart';
import 'package:source_app/engine/domain/use.case/fetch_usecase.dart';
import 'package:source_app/engine/domain/use.case/pull_usecase.dart';
import 'package:source_app/engine/domain/use.case/push_usecase.dart';
import 'package:source_app/engine/domain/use.case/stashes_usecase.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/screen/repository/dashboard/components/body-left/body_left_viewmodel.dart';

class HeaderViewModel {
  final BodyLeftViewModel _bodyLeftViewModel;

  HeaderViewModel(this._bodyLeftViewModel);

  Future<GitOutput> push() async {
    GitOutput gitOutput = await BranchesUseCase().current();

    if(gitOutput.isSuccess()) {
      GitBranch gitBranch = gitOutput.object as GitBranch;

      gitOutput = await PushUseCase().push(gitBranch.name);
    }

    return gitOutput;
  }

  Future<GitOutput> pull() async {
    return await PullUseCase().pull();
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
    return await StashesUseCase().create(name);
  }
}
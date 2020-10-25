import 'dart:async';
import 'dart:convert';
import 'package:source_app/engine/domain/model/git_commit.dart';
import 'package:source_app/engine/domain/model/git_file_modified.dart';
import 'package:source_app/engine/domain/use.case/commit_usecase.dart';
import 'package:source_app/engine/domain/use.case/log_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';

class BodyRightViewModel {
  final StreamController<String> _rightDashboardController = StreamController<String>.broadcast();
  Stream<String> get rightDashboardOutput => _rightDashboardController.stream;

  final StreamController<GitFileModified> _fileDiffDashboardController = StreamController<GitFileModified>.broadcast();
  Stream<GitFileModified> get fileDiffDashboardOutput => _fileDiffDashboardController.stream;

  final StreamController<bool> _stagedDashboardController = StreamController<bool>.broadcast();
  Stream<bool> get stagedDashboardOutput => _stagedDashboardController.stream;

  final StreamController<bool> _unStagedDashboardController = StreamController<bool>.broadcast();
  Stream<bool> get unStagedDashboardOutput => _unStagedDashboardController.stream;

  final StreamController<GitOutput> _historyCommitController = StreamController<GitOutput>.broadcast();
  Stream<GitOutput> get historyCommitOutput => _historyCommitController.stream;

  final StreamController<GitCommit> _commitDetailsController = StreamController<GitCommit>.broadcast();
  Stream<GitCommit> get commitDetailsOutput => _commitDetailsController.stream;

  void displayCommitDetails(GitCommit gitOutput) {
    _commitDetailsController.sink.add(gitOutput);
  }

  void displayHistoryCommit(GitOutput gitOutput) {
    _historyCommitController.sink.add(gitOutput);
  }

  void displayFileDiff(GitFileModified file) {
    _fileDiffDashboardController.sink.add(file);
  }

  void displayHistory() async {
    _rightDashboardController.sink.add(rightHistory);
  }

  void displayCommit() async {
    _rightDashboardController.sink.add(rightCommit);
  }

  void updateCommitDashboard() {
    _stagedDashboardController.sink.add(true);
    _unStagedDashboardController.sink.add(true);
  }

  Future<GitOutput> add(String file) async {
    GitOutput gitOutput = await CommitUseCase().add(file);
    if(gitOutput.isSuccess()) {
      updateCommitDashboard();
    }

    return gitOutput;
  }

  Future<GitOutput> remove(String file) async {
    GitOutput gitOutput = await CommitUseCase().remove(file);
    if(gitOutput.isSuccess()) {
      updateCommitDashboard();
    }

    return gitOutput;
  }

  Future<GitOutput> diff(GitFileModified fileModified) async {
    GitOutput gitOutput;
    if(fileModified.stageFile == StageFile.staged) {
      gitOutput = await CommitUseCase().diffCached(fileModified.name);
    } else if(fileModified.stageFile == StageFile.unstaged)
      gitOutput = await CommitUseCase().diff(fileModified.name);
    else {
      gitOutput = await CommitUseCase().diffCommitted(fileModified.beforeCommitHash, fileModified.commitHash, fileModified.name);
    }
    if(gitOutput.isSuccess()) {
      List<String> modifiedFile = gitOutput.lines;
      gitOutput.lines = (filter(modifiedFile));
    }

    return gitOutput;
  }

  Future<GitOutput> commit(String message) async {
    return await CommitUseCase().commit(message);
  }

  List<String> filter(List<String> fullList) {
    List<String> newList = List();
    bool canAdd = false;
    fullList.forEach((element) {
      if(canAdd) {
        newList.add(element);
      }
      if(element.contains("@@")) {
        canAdd = true;
      }
    });

    return newList;
  }

  Future<GitOutput> unStagedFiles() async {
    GitOutput unCommitted = await CommitUseCase().uncommittedFiles();
    if(unCommitted.isFailure()) {
      return unCommitted;
    }
    GitOutput unTracked = await CommitUseCase().untrackedFiles();
    if(unTracked.isFailure()) {
      return unTracked;
    }
    GitOutput gitOutput = GitOutput("").success();
    List<String> allFiles = List();
    allFiles.addAll(unCommitted.object as List<String>);
    allFiles.addAll(unTracked.object as List<String>);
    gitOutput.withObject(allFiles);

    return gitOutput;
  }

  Future<GitOutput> stagedFiles() async {
    return await CommitUseCase().stagedFiles();
  }

  Future<GitOutput> history() async {
    GitOutput gitOutput = await LogUseCase().history();

    if(gitOutput.isSuccess()) {
      displayHistoryCommit(gitOutput);
    }

    return gitOutput;
  }

  Future<GitOutput> modifiedFilesFromCommit(GitCommit commit) async {
    GitOutput gitOutput = await CommitUseCase().filesModifieds(commit.hash.trim());

    if(gitOutput.isSuccess() && gitOutput.object != null && gitOutput.object is List<GitFileModified>) {
      List<GitFileModified> files = gitOutput.object;
      files.forEach((file) {
        file.commitHash = commit.hash.trim();
        file.beforeCommitHash = commit.beforeHash.trim();
      });
      gitOutput.withObject(files);
    }

    return gitOutput;
  }

  void dispose() {
    _rightDashboardController.close();
    _fileDiffDashboardController.close();
    _stagedDashboardController.close();
    _unStagedDashboardController.close();
    _historyCommitController.close();
    _commitDetailsController.close();
  }
}
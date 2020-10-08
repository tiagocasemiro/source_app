import 'dart:async';
import 'package:source_app/engine/domain/use.case/commit_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';

class BodyRightViewModel {
  final StreamController<String> _rightDashboardController = StreamController<String>.broadcast();
  Stream<String> get rightDashboardOutput => _rightDashboardController.stream;

  final StreamController<String> _fileDiffDashboardController = StreamController<String>.broadcast();
  Stream<String> get fileDiffDashboardOutput => _fileDiffDashboardController.stream;

  final StreamController<bool> _stagedDashboardController = StreamController<bool>.broadcast();
  Stream<bool> get stagedDashboardOutput => _stagedDashboardController.stream;

  final StreamController<bool> _unStagedDashboardController = StreamController<bool>.broadcast();
  Stream<bool> get unStagedDashboardOutput => _unStagedDashboardController.stream;


  void displayFileDiff(String file) {
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

  Future<GitOutput> diff(String file) async {
    return await CommitUseCase().diff(file);
  }

  Future<GitOutput> uncommittedFiles() async {
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


  void dispose() {
    _rightDashboardController.close();
    _fileDiffDashboardController.close();
    _stagedDashboardController.close();
    _unStagedDashboardController.close();
  }
}
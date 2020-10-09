import 'dart:async';
import 'package:source_app/engine/domain/use.case/commit_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';

class BodyRightViewModel {
  final StreamController<String> _rightDashboardController = StreamController<String>.broadcast();
  Stream<String> get rightDashboardOutput => _rightDashboardController.stream;

  final StreamController<MapEntry<String, String>> _fileDiffDashboardController = StreamController<MapEntry<String, String>>.broadcast();
  Stream<MapEntry<String, String>> get fileDiffDashboardOutput => _fileDiffDashboardController.stream;

  final StreamController<bool> _stagedDashboardController = StreamController<bool>.broadcast();
  Stream<bool> get stagedDashboardOutput => _stagedDashboardController.stream;

  final StreamController<bool> _unStagedDashboardController = StreamController<bool>.broadcast();
  Stream<bool> get unStagedDashboardOutput => _unStagedDashboardController.stream;


  void displayFileDiff(MapEntry<String, String> file) {
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

  Future<GitOutput> diff(MapEntry<String, String> file) async {
    GitOutput gitOutput;
    if(file.key == staged) {
      gitOutput = await CommitUseCase().diffCached(file.value);
    } else {
      gitOutput = await CommitUseCase().diff(file.value);
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
        print(element);
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

  void dispose() {
    _rightDashboardController.close();
    _fileDiffDashboardController.close();
    _stagedDashboardController.close();
    _unStagedDashboardController.close();
  }
}
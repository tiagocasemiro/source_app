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

  void displayFileDiff(String file) {
    _fileDiffDashboardController.sink.add(file);
  }

  void displayHistory() async {
    _rightDashboardController.sink.add(rightHistory);
  }

  void displayCommit() async {
    _rightDashboardController.sink.add(rightCommit);
  }

  Future<GitOutput> diff(String file) async {
    return await CommitUseCase().diff(file);
  }

  void dispose() {
    _rightDashboardController.close();
    _fileDiffDashboardController.close();
    _stagedDashboardController.close();
  }
}
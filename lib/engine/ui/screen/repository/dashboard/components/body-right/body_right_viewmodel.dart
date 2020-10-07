import 'dart:async';
import 'package:source_app/engine/domain/use.case/commit_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/ui/utils/default_values.dart';

class BodyRightViewModel {
  final StreamController<String> _rightDashboardController = StreamController<String>.broadcast();
  Stream<String> get rightDashboardOutput => _rightDashboardController.stream;

  final StreamController<String> _fileDiffDashboardController = StreamController<String>.broadcast();
  Stream<String> get fileDiffDashboardOutput => _fileDiffDashboardController.stream;

  void displayFileDiff(String _content) {
    _fileDiffDashboardController.sink.add(_content);
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
  }
}
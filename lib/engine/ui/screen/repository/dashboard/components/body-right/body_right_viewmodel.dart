import 'dart:async';
import 'package:source_app/engine/ui/utils/default_values.dart';

class BodyRightViewModel {
  final StreamController<String> _rightDashboardController = StreamController<String>.broadcast();
  Stream<String> get rightDashboardOutput => _rightDashboardController.stream;

  void displayHistory() async {
    _rightDashboardController.sink.add(rightHistory);
  }

  void displayCommit() async {
    _rightDashboardController.sink.add(rightCommit);
  }

  void dispose() {
    _rightDashboardController.close();
  }
}
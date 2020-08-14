import 'dart:async';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';

class SelectRepositoryViewModel {
  final StreamController<Repository> _statusController = StreamController<Repository>.broadcast();
  Sink<Repository> get statusInput => _statusController.sink;
  Stream<String> get statusOutput => _statusController.stream.asyncMap((repository) => _status(repository));

  Future<List<Repository>> all() async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return RepositoryUseCase().allLocalRepository();
    });
  }

  Future<String> _status(Repository repository) {
    return RepositoryUseCase().statusOfRepository(repository);
  }

  Future newRepository() async {
    // todo implement
    return null;
  }

  void dispose() {
    _statusController.close();
  }
}
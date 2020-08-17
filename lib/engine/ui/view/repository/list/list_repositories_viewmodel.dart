import 'dart:async';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';

class SelectRepositoryViewModel {
  final StreamController<Repository> _deleteController = StreamController<Repository>.broadcast();
  Sink<Repository> get deleteInput => _deleteController.sink;
  Stream<bool> get deleteOutput => _deleteController.stream.asyncMap((repository) => _delete(repository));

  final StreamController<Repository> _statusController = StreamController<Repository>.broadcast();
  Sink<Repository> get statusInput => _statusController.sink;
  Stream<Repository> get statusOutput => _statusController.stream.asyncMap((repository) => _status(repository));



  Future<List<Repository>> all() async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return RepositoryUseCase().allLocalRepository();
    });
  }

  Future<Repository> _status(Repository _repository) async {
    Repository repository = await RepositoryUseCase().statusOfRepository(_repository);

    return repository;
  }

  Future newRepository() async {
    // todo implement
    return null;
  }

  void dispose() {
    _statusController.close();
    _deleteController.close();
  }

  Future<bool> _delete(Repository repository) {
    print("*** -> deleted");
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return RepositoryUseCase().deleteLocalRepository(repository);
    });
  }
}
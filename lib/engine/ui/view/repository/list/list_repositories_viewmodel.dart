import 'dart:async';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class SelectRepositoryViewModel {
  final StreamController<Repository> _deleteController = StreamController<Repository>.broadcast();
  Sink<Repository> get deleteInput => _deleteController.sink;
  Stream<bool> get deleteOutput => _deleteController.stream.asyncMap((repository) => delete(repository));

  final StreamController<Repository> _statusController = StreamController<Repository>.broadcast();
  Sink<Repository> get statusInput => _statusController.sink;
  Stream<Repository> get statusOutput => _statusController.stream.asyncMap((repository) => status(repository));

  final StreamController<Repository> _saveController = StreamController<Repository>.broadcast();
  Sink<Repository> get saveInput => _saveController.sink;
  Stream<bool> get saveOutput => _saveController.stream.asyncMap((repository) => save(repository));

  Future<List<Repository>> all() async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return RepositoryUseCase().allLocalRepository();
    });
  }

  Future<Repository> status(Repository _repository) async {
    Repository repository = await RepositoryUseCase().statusOfRepository(_repository);

    return repository;
  }

  Future<bool> save(Repository repository) async {
    GitOutput gitOutput = await RepositoryUseCase().addLocalRepository(repository);

    return gitOutput.isSuccess();
  }

  void dispose() {
    _statusController.close();
    _deleteController.close();
    _saveController.close();
  }

  Future<bool> delete(Repository repository) {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return RepositoryUseCase().deleteLocalRepository(repository);
    });
  }
}
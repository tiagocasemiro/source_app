import 'dart:async';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class SelectRepositoryViewModel {
  final StreamController<Repository> _deleteController = StreamController<Repository>.broadcast();
  Sink<Repository> get deleteInput => _deleteController.sink;
  Stream<bool> get deleteOutput => _deleteController.stream.asyncMap((repository) => delete(repository));

  final StreamController<Repository> _statusController = StreamController<Repository>.broadcast();
  Sink<Repository> get statusInput => _statusController.sink;
  Stream<Repository> get statusOutput => _statusController.stream.asyncMap((repository) => status(repository));

  Future<bool> hasCredential(Repository _repository) async {
    return await StartApplicationUseCase().checkCredentials(_repository.workDirectory);
  }

  Future<List<Repository>> all() async {
    return RepositoryUseCase().allLocalRepository();
  }

  Future<Repository> status(Repository _repository) async {
    Repository repository = await RepositoryUseCase().statusOfRepository(_repository);

    return repository;
  }

  Future<bool> clone(Repository _repository) async {

  }

  Future<bool> save(Repository repository) async {
    if(repository == null)
      return false;

    GitOutput gitOutput = await RepositoryUseCase().addLocalRepository(repository);

    if(gitOutput.isSuccess()) {
      deleteInput.add(null);
      statusInput.add(repository);
    }

    return gitOutput.isSuccess();
  }

  void dispose() {
    _statusController.close();
    _deleteController.close();
  }

  Future<bool> delete(Repository repository) async {
    if(repository == null)
      return false;

    return RepositoryUseCase().deleteLocalRepository(repository);
  }
}
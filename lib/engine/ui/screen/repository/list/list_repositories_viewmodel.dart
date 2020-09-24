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

  Future<bool> startGitApplication(Repository repository) async {
    return await StartApplicationUseCase().startGitApplication(repository);
  }

  Future<List<Repository>> all() async {
    return RepositoryUseCase().allLocalRepository();
  }

  Future<Repository> status(Repository _repository) async {
    Repository repository = await RepositoryUseCase().statusOfRepository(_repository);

    return repository;
  }

  Future<GitOutput> clone(Repository _repository) async {
    GitOutput gitOutput = await RepositoryUseCase().clone(_repository);

    if(gitOutput.isSuccess()) {
      _deleteController.add(null);
      statusInput.add(_repository);
    }

    return gitOutput;
  }

  Future<GitOutput> save(Repository repository) async {
    GitOutput gitOutput = await RepositoryUseCase().addLocalRepository(repository);

    if(gitOutput.isSuccess()) {
      _deleteController.add(null);
      statusInput.add(repository);
    }

    return gitOutput;
  }

  Future<bool> existRepository(Repository repository) async {
    return await RepositoryUseCase().existRepository(repository);
  }

  void dispose() {
    _statusController.close();
    _deleteController.close();
  }

  Future<bool> delete(Repository repository) async {
    if(repository == null)
      return false;

    bool isDeleted = await RepositoryUseCase().deleteLocalRepository(repository);

    if(isDeleted) {
      statusInput.add(null);
    }

    return isDeleted;
  }
}
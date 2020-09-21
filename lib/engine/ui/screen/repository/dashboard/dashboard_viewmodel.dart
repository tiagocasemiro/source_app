import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'dart:async';

class DashboardViewModel {
  Future<bool> initRepository(Repository repository, String username, String password) async {
    StartApplicationUseCase startApplicationUseCase = StartApplicationUseCase();
    String credentials = await startApplicationUseCase.startGitApplicationWithCredentials(repository.workDirectory, username, password);
    if(credentials != null) {
      repository.credentials = credentials;
      return await RepositoryUseCase().updateLocalRepository(repository);
    }

    return false;
  }



  Future<bool> checkCredentials(Repository repository) async {
    return await StartApplicationUseCase().checkCredentials(repository.workDirectory);
  }
}
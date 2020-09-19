import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'dart:async';

class DashboardViewModel {
  Future<bool> checkCredentialAndInitRepository(Repository repository, String username, String password) async {
    StartApplicationUseCase startApplicationUseCase = StartApplicationUseCase();
    bool isStarted = await startApplicationUseCase.startGitApplicationWithCredentials(repository.workDirectory, username, password);
    if(isStarted) {
      return await startApplicationUseCase.checkCredentials(repository.workDirectory);
    }

    return false;
  }

  Future<bool> checkCredentials(Repository repository) async {
    return await StartApplicationUseCase().checkCredentials(repository.workDirectory);
  }
}
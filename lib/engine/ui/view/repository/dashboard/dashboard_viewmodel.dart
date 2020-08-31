import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'dart:async';

class DashboardViewModel {
  final StreamController<GitOutput> _localBranchesController = StreamController<GitOutput>.broadcast();
  Stream<GitOutput> get localBranchesOutput => _localBranchesController.stream;

  Future<bool> checkCredentialAndInitRepository(Repository repository, String username, String password) async {
    StartApplicationUseCase startApplicationUseCase = StartApplicationUseCase();
    bool isStarted = await startApplicationUseCase.startGitApplication(repository.workDirectory, username, password);
    if(isStarted) {
      return await startApplicationUseCase.checkCredentials(repository.workDirectory);
    }

    return false;
  }

  Future<bool> checkCredentials(Repository repository) async {
    return await StartApplicationUseCase().checkCredentials(repository.workDirectory);
  }

  void allLocalBranches() async {
    GitOutput gitOutput = await  Git().branch().local().call();
    _localBranchesController.sink.add(gitOutput);
  }

  void dispose() {
    _localBranchesController.close();
  }
}
import 'dart:async';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/start_application_usecase.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class DashboardViewModel {
  final StreamController<GitOutput> _localBranchesController = StreamController<GitOutput>.broadcast();
  Stream<GitOutput> get localBranchesOutput => _localBranchesController.stream;

  Future<bool> initRepository(Repository repository, String username, String password) async {
    return await StartApplicationUseCase().startGitApplication(repository.workDirectory, username, password);
  }

  void allLocalBranches() async {
    GitOutput gitOutput = await  Git().branch().local().call();
    _localBranchesController.sink.add(gitOutput);
  }

  void dispose() {
    _localBranchesController.close();
  }
}
import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/command/remote.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StartApplicationUseCase {
  Future<String> startGitApplicationWithCredentials(String workDirectory, String username, String password) async {
    return await Git().startRepositoryWithCredentials(username, password, workDirectory);
  }

  Future<bool> startGitApplication(Repository repository) async {
    return await Git().startRepository(repository);
  }

  Future<bool> checkCredentials(String workDirectory) async {
    Remote remoteCommand = Remote(workDirectory);
    GitOutput gitOutput = await remoteCommand.call();
    if(gitOutput.isSuccess()) {
      GitRemote gitRemote = gitOutput.object as GitRemote;
      gitOutput = await remoteCommand.showFrom(gitRemote.name).call();

      return gitOutput.isSuccess();
    }

    return false;
  }
}

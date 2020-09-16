import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/command/remote.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StartApplicationUseCase {
  Future<bool> startGitApplicationWithCredentials(String workDirectory, String username, String password) async {
    return Git().startRepositoryWithCredentials(username, password, workDirectory).then((success) {

      return success;
    });
  }

  Future<bool> startGitApplication(String workDirectory) async {
    return Git().startRepository(workDirectory).then((success) {

      return success;
    });
  }

  Future<bool> checkCredentials(String workDirectory) async {
    Remote remoteCommand = Remote(workDirectory);
    GitOutput gitOutput = await remoteCommand.call();
    if(gitOutput.isSuccess()) {
      GitRemote gitRemote = gitOutput.object as GitRemote;
      gitOutput = await remoteCommand.show(gitRemote).call();

      return gitOutput.isSuccess();
    }

    return false;
  }
}

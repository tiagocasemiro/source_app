import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/command/remote.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StartRepositoryUseCase {

  Future<bool> startGitApplication(String workDirectory, String username, String password) async {
    Remote remoteCommand = Remote(workDirectory);
    GitOutput gitOutput = await remoteCommand.call();
    if(gitOutput.isSuccess()) {
      GitRemote gitRemote = gitOutput.object as GitRemote;
      gitOutput = await remoteCommand.show(gitRemote).call();
      if(gitOutput.isSuccess()) {
        gitRemote = gitOutput.object as GitRemote;
        Git().startRepository(username, password, workDirectory, gitRemote.hostPush(), gitRemote.pathGitPush()).then((success) {
          print("Application is started");

          return true;
        });
      }
    }

    return false;
  }
}

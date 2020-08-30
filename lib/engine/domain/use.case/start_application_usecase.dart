import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/command/remote.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StartApplicationUseCase {

  Future<bool> startGitApplication(String workDirectory, String username, String password) async {
    Remote remoteCommand = Remote(workDirectory);
    GitOutput gitOutput = await remoteCommand.call();
    if(gitOutput.isSuccess()) {
      return Git().startRepository(username, password, workDirectory).then((success) {

        return success;
      });
    }

    return false;
  }
}

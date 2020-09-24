import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/command/remote.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StartApplicationUseCase {
  Future<String> startGitApplicationWithCredentials(Repository repository) async {
    return await Git().startRepositoryWithCredentials(repository);
  }

  Future<bool> startGitApplication(Repository repository) async {
    return await Git().startRepository(repository);
  }
}

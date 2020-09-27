import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/git.dart';

class StartApplicationUseCase {
  Future<String> startGitApplicationWithCredentials(Repository repository) async {
    return await Git().startRepositoryWithCredentials(repository);
  }

  Future<bool> startGitApplication(Repository repository) async {
    return await Git().startRepository(repository);
  }
}

import 'package:source_app/engine/database/dao/repository_dao.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StartRepositoryUseCase {

  Future<GitOutput> startRepository(String name, String workDirectory) async {
    GitOutput gitOutput = await Git().checkWorkDirectory(workDirectory);
    if(gitOutput.isSuccess()) {
      Repository repository = Repository(name, workDirectory);
      RepositoryDao().save(repository);
    }

    return gitOutput;
  }
}

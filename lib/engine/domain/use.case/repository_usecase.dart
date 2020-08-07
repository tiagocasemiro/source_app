import 'package:source_app/engine/database/dao/repository_dao.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class RepositoryUseCase {

  Future<GitOutput> addLocalRepository(String name, String workDirectory) async {
    GitOutput gitOutput = await Git().checkWorkDirectory(workDirectory);
    if(gitOutput.isSuccess()) {
      Repository repository = Repository(name, workDirectory);
      int id = await RepositoryDao().save(repository);
      if(id != null) {
        gitOutput.withObject(repository);
      }
    }

    return gitOutput;
  }

  Future<List<Repository>> allLocalRepository() async {
    List<Repository> repositories = await RepositoryDao().findAll();

    return repositories;
  }

  Future<int> deleteLocalRepository(Repository repository) async {
    int id = await RepositoryDao().delete(repository);

    return id;
  }
}
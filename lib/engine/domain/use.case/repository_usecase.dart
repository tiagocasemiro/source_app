import 'package:source_app/engine/database/dao/repository_dao.dart';
import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/shell/git/command/status.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class RepositoryUseCase {

  Future<GitOutput> addLocalRepository(String name, String workDirectory) async {
    GitOutput gitOutput = await Git().checkWorkDirectory(workDirectory);
    if(gitOutput.isSuccess()) {
      Repository repository = Repository(name, workDirectory);
      bool isSaved = await RepositoryDao().save(repository);
      if(isSaved) {
        gitOutput.withObject(repository);
      }
    }

    return gitOutput;
  }

  Future<List<Repository>> allLocalRepository() async {
    List<Repository> repositories = await RepositoryDao().findAll();

    return repositories;
  }

  Future<bool> deleteLocalRepository(Repository repository) async {
    int id = await RepositoryDao().delete(repository);

    return id > 0;
  }

  Future<String> statusOfRepository(Repository repository) async {
    GitOutput gitOutput = await Status(repository.workDirectory).call();

    return gitOutput.message;
  }
}

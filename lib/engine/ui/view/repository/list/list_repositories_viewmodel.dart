import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';

class SelectRepositoryViewModel {

  Future<List<Repository>> all() async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return RepositoryUseCase().allLocalRepository();
    });
  }

  Future<String> status(Repository repository) async {
    String output =  await RepositoryUseCase().statusOfRepository(repository);

    print(output);

    return output;
  }

  Future newRepository() async {
    // todo implement
    return null;
  }
}
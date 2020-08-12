import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';

class SelectRepositoryViewModel {

  Future<List<Repository>> all() async {
    return RepositoryUseCase().allLocalRepository();
  }
}
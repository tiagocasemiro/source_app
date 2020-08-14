import 'dart:async';

import 'package:source_app/engine/domain/model/git_repository.dart';
import 'package:source_app/engine/domain/use.case/repository_usecase.dart';

class SelectRepositoryViewModel {
  // ignore: close_sinks
  final StreamController<String> _streamController = StreamController();
  Sink<String> get input => _streamController.sink;
  Stream<String> get output => _streamController.stream;

  Future<List<Repository>> all() async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return RepositoryUseCase().allLocalRepository();
    });
  }

   void status(Repository repository) {
    RepositoryUseCase().statusOfRepository(repository).then((String content) {
      input.add(content);
    });
  }

  Future newRepository() async {
    // todo implement
    return null;
  }
}
import 'package:source_app/engine/domain/use.case/fetch_usecase.dart';
import 'package:source_app/engine/domain/use.case/pull_usecase.dart';
import 'package:source_app/engine/domain/use.case/push_usecase.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class HeaderViewModel {

  Future<GitOutput> push() async {
    return await PushUseCase().push();
  }

  Future<GitOutput> pull() async {
    return await PullUseCase().pull();
  }

  Future<GitOutput> fetch() async {
    return await FetchUseCase().fetch();
  }
}
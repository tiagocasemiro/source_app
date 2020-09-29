import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class FetchUseCase {
  Future<GitOutput> fetch() async {
    return Git().fetch().prune().all().call();
  }
}

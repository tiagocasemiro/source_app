import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class PullUseCase {
  Future<GitOutput> pull() async {
    return await Git().pull().call();
  }
}

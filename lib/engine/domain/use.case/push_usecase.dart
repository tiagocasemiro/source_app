import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class PushUseCase {
  Future<GitOutput> push() async {
    return await Git().push().call();
  }
}

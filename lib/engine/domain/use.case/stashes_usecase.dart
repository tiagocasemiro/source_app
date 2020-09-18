import 'package:source_app/engine/domain/model/git_stash.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class StashesUseCase {
  Future<GitOutput> all() async {
    return await Git().stash().list().call();
  }

  Future<GitOutput> apply(GitStash stash) async {
    return await Git().stash().apply(stash).call();
  }

  void create(String name) {

  }
}

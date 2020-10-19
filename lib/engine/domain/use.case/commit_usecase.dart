import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class CommitUseCase {
  void addAll() {}

  Future<GitOutput> commit(String message) async {
    return await Git().commit().message(message).call();
  }

  Future<GitOutput> uncommittedFiles() async {
    return await Git().diff().nameOnly().call();
  }

  Future<GitOutput> untrackedFiles() async {
    return await Git().lsFiles().others().excludeStandard().call();
  }

  Future<GitOutput> diff(String file) async {
    return await Git().diff().file(file).call();
  }

  Future<GitOutput> diffCached(String file) async {
    return await Git().diff().cached().file(file).call();
  }

  Future<GitOutput> add(String file) async {
    return await Git().add().file(file).call();
  }

  Future<GitOutput> stagedFiles() async {
    return await Git().diff().cached().nameOnly().call();
  }

  Future<GitOutput> remove(String file) async {
    return await Git().restore().file(file).call();
  }

  Future<GitOutput> filesModifieds(String hashCommit) async {
    return await Git().diff().tree().noCommitId().nameStatus().r().hash(hashCommit).call();
  }
}

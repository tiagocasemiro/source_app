import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class CommitUseCase {
  void addAll() {}

  void commit() {}

  Future<GitOutput> uncommittedFiles() async {
    return await Git().diff().nameOnly().call();
  }

  Future<GitOutput> untrackedFiles() async {
    return await Git().lsFiles().others().excludeStandard().call();
  }

  Future<GitOutput> diff(String file) async {
    return await Git().diff().file(file).call();
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
}

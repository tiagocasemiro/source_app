import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class CommitUseCase {
  void add(String fileName) {}

  void addAll() {}

  void commit() {}

  Future<GitOutput> uncommittedFiles() async {
    return Git().diff().nameOnly().call();
  }
}

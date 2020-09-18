import 'package:source_app/engine/domain/model/git_tag.dart';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';

class TagsUseCase {
  Future<GitOutput> all() async {
    return await Git().tag().call();
  }
}

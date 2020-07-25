import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/model/git_tag.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';

class TagAdapter extends BaseAdapter {

  GitOutput toTags(String _gitOutput) {
    try {
      List<GitTag> tags = List();
      toLines(_gitOutput).forEach((line) {
        if (line.isNotEmpty) {
          tags.add(GitTag(clean(line)));
        }
      });

      return GitOutput(_gitOutput).success(object: tags);
    } catch (e) {
      return GitOutput(_gitOutput).failure();
    }
  }
}

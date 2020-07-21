import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/model/git_tag.dart';

class TagAdapter extends BaseAdapter{

  List<GitTag> toTags(String terminalOutput) {
    List<GitTag> tags = List();
    toLines(terminalOutput).forEach((line) {
      if(line.isNotEmpty) {
        tags.add(GitTag(clean(line)));
      }
    });

    return tags;
  }
}
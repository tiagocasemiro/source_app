import 'package:source_app/git/adapter/BaseAdapter.dart';
import 'package:source_app/git/model/Tag.dart';

class TagAdapter extends BaseAdapter{

  List<Tag> toTags(String terminalOutput) {
    List<Tag> tags = List();
    toLines(terminalOutput).forEach((line) {
      if(line.isNotEmpty) {
        tags.add(Tag(clean(line)));
      }
    });

    return tags;
  }
}
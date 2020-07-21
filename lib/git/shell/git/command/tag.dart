
import 'package:source_app/git/model/git_tag.dart';
import 'package:source_app/git/shell/git/adapter/tag_adapter.dart';
import '../../terminal.dart';

class Tag {
  String _workDirectory;
  Tag(this._workDirectory);

  Future<List<GitTag>> all() {
    return Terminal(_workDirectory).run("git", parameters: ['tag']).then((String terminalOutput) {
      return TagAdapter().toTags(terminalOutput != null ? terminalOutput: "");
    });
  }
}
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/model/git_tag.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class TagAdapter extends BaseAdapter {

  TerminalOutput<List<GitTag>> toTags(String _terminalOutput) {
    try {
      List<GitTag> tags = List();
      toLines(_terminalOutput).forEach((line) {
        if (line.isNotEmpty) {
          tags.add(GitTag(clean(line)));
        }
      });

      return TerminalOutput().success(object: tags);
    } catch (e) {
      return TerminalOutput().failure(_terminalOutput);
    }
  }
}

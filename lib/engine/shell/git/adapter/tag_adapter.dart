import 'package:source_app/engine/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/engine/model/git_tag.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class TagAdapter extends BaseAdapter {

  TagAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput toTags() {
    return execute(transform: (gitOutput) {
      List<GitTag> tags = List();
      gitOutput.lines.forEach((line) {
        if (line.isNotEmpty) {
          tags.add(GitTag(clean(line)));
        }
      });
      return gitOutput.withObject(tags);
    });
  }
}

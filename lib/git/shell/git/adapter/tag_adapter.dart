import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/model/git_tag.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

class TagAdapter extends BaseAdapter {

  TagAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput toTags() {
    return execute(transform: (gitOutput) {
      List<GitTag> tags = List();
      toLines(gitOutput.message).forEach((line) {
        if (line.isNotEmpty) {
          tags.add(GitTag(clean(line)));
        }
      });
      return gitOutput.withObject(tags);
    });
  }
}

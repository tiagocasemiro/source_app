import 'package:source_app/engine/domain/model/git_file_modified.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';
import 'base/base_adapter.dart';

class DiffAdapter extends BaseAdapter {

  DiffAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput files() {
    return execute(transform: (gitOutput) {
      List<String> files = List();
      gitOutput.lines.forEach((String line) {
        files.add(clean(line));
      });

      return gitOutput.withObject(files);
    });
  }

  GitOutput filesModifiedFromCommit() {
    return execute(transform: (gitOutput) {
      List<GitFileModified> files = List();
      gitOutput.lines.forEach((String line) {
        List<String> parts = line.split("\t");

        TypeFile typeFile = TypeFile.modification;
        if(parts.length == 2) {
          if(parts[0] == "A") {
            typeFile = TypeFile.add;
          } else if(parts[0] == "D") {
            typeFile = TypeFile.delete;
          } else if(parts[0] == "M") {
            typeFile = TypeFile.modification;
          }
          files.add(GitFileModified(parts[1], typeFile));
        }
      });

      return gitOutput.withObject(files);
    });
  }
}

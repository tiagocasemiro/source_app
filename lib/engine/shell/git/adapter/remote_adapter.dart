import 'package:source_app/engine/domain/model/git_remote.dart';
import 'package:source_app/engine/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/engine/shell/git/model/git_output.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class RemoteAdapter extends BaseAdapter {

  RemoteAdapter(TerminalOutput terminalOutput) : super(terminalOutput);

  GitOutput remote() {
    return execute(transform: (gitOutput) {
      String name = gitOutput.message.trim();
      GitRemote gitRemote = GitRemote();
      gitRemote.name = name;

      return gitOutput.withObject(gitRemote);
    });
  }

  GitOutput show() {
    return execute(transform: (gitOutput) {
      GitRemote gitRemote = GitRemote();
      gitOutput.lines.forEach((line) {
        if(line.trim().startsWith("* remote")) {
          gitRemote.name = _extractRemoteName(line);
        }
        if(line.trim().startsWith("Fetch")) {
          gitRemote.fetchUrl = _extractFetchUrl(line);
        }
        if(line.trim().startsWith("Push")) {
          gitRemote.pushUrl = _extractPushUrl(line);
        }
      });
      gitOutput.withObject(gitRemote);

      return gitOutput;
    });
  }
  
  String _extractRemoteName(String line) {
    return line.replaceAll("* remote", "").trim();
  }

  String _extractFetchUrl(String line) {
    return line.replaceAll("Fetch URL:", "").trim();
  }

  String _extractPushUrl(String line) {
    return line.replaceAll("Push  URL:", "").trim();
  }
}
import 'package:source_app/git/model/git_remote.dart';
import 'package:source_app/git/shell/git/adapter/base/base_adapter.dart';
import 'package:source_app/git/shell/git/model/git_output.dart';
import 'package:source_app/git/shell/model/terminal_output.dart';

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
      toLines(gitOutput.message).forEach((line) {
        if(line.startsWith("* remote")) {
          gitRemote.name = _extractRemoteName(line);
        }
        if(line.startsWith("Fetch")) {
          gitRemote.name = _extractFetchUrl(line);
        }
        if(line.startsWith("Push")) {
          gitRemote.name = _extractPushUrl(line);
        }
      });

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
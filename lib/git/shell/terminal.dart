import 'dart:io';
import 'dart:async';

import 'package:source_app/git/shell/model/terminal_output.dart';

class Terminal {
  final String _workDirectory;

  Terminal(this._workDirectory);

  Future<TerminalOutput> run(String command, {List<String> parameters = const []}) {
    return Process.run(command, parameters, workingDirectory: _workDirectory).then((results) {
      return TerminalOutput(results.stdout.toString(), results.exitCode);
    });
  }

 /* @deprecated
  Future<int> runAndReturnExitCode(String command,
      {List<String> parameters = const []}) {
    return Process.run(command, parameters, workingDirectory: _workDirectory)
        .then((results) {
      return results.exitCode;
    });
  }*/
}

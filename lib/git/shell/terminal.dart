import 'dart:io';
import 'dart:async';

import 'package:source_app/git/shell/model/terminal_output.dart';

class Terminal {
  final String _workDirectory;

  Terminal(this._workDirectory);

  Future<TerminalOutput> run(String command, {List<String> parameters = const []}) {
    return Process.run(command, parameters, workingDirectory: _workDirectory).then((processResult) {
      print("Error output : " + processResult.stderr.toString());
      print("Saida output : " + processResult.stdout.toString());
      print("Exit code : " + processResult.exitCode.toString());
      String stderr = processResult.stderr.toString();
      String stdout = processResult.stdout.toString();
      String message = (stdout != null && stdout.isNotEmpty)? stdout : stderr;

      return TerminalOutput(message, processResult.exitCode);
    });
  }
}

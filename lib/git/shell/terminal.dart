import 'dart:io';
import 'dart:async';

class Terminal {
  final String _workDirectory;

  Terminal(this._workDirectory);

  Future<String> run(String command, {List<String> parameters = const []}) {
    return Process.run(command, parameters, workingDirectory: _workDirectory).then((results) {
      return results.stdout.toString();
    });
  }

  Future<int> runAndReturnExitCode(String command,
      {List<String> parameters = const []}) {
    return Process.run(command, parameters, workingDirectory: _workDirectory)
        .then((results) {
      return results.exitCode;
    });
  }
}

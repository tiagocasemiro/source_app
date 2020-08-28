import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:source_app/engine/shell/git/git.dart';
import 'package:source_app/engine/shell/model/terminal_output.dart';

class Terminal {
  final String _workDirectory;

  Terminal(this._workDirectory);

  Future<TerminalOutput> run(String command, {List<String> parameters = const [], Map<String, String> environment}) {
    return Process.run(command, parameters, workingDirectory: _workDirectory, environment: environment).then((processResult) {
      String stderr = processResult.stderr.toString();
      String stdout = processResult.stdout.toString();
      String message = (stdout != null && stdout.isNotEmpty)? stdout : stderr;

      return TerminalOutput(message, processResult.exitCode);
    });
  }

  Future<TerminalOutput> runWithGitCredentials(String command, {List<String> parameters = const [], Map<String, String> environment}) async {
    Process process = await Process.start(command, parameters, workingDirectory: _workDirectory, environment: environment);
    var completer = new Completer<TerminalOutput>();
    process.stdout.transform(utf8.decoder).listen((data) {
      if(data.toLowerCase().contains("username")) {
        process.stdin.writeln(Git.username);
      } else if(data.toLowerCase().contains("password")) {
        process.stdin.writeln(Git.password);
      } else {
        _printOutput(data, exitCode.toString(), command, parameters: parameters);
        completer.complete(TerminalOutput(data, 0));
      }
    });
    process.stderr.transform(utf8.decoder).listen((data) {
      _printOutput( data.toString(), exitCode.toString(), command, parameters: parameters);
      completer.complete(TerminalOutput(data, 1));
    });

    return completer.future;
  }

  void _printOutput(String message, String exitCode, String command, {List<String> parameters = const []}) {
    parameters.forEach((element) {
      command += " $element";
    });
    print("Git command: " + command);
    print("Directory: " + _workDirectory);
    print("Message : " + message);
    print("Exit code : " + exitCode);
  }
}

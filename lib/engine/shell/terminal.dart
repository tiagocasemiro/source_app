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

  Future<TerminalOutput> runWithGitCredentials(String command, String username, String password, {List<String> parameters = const [], Map<String, String> environment}) async {
    Process process = await Process.start(command, parameters, workingDirectory: _workDirectory, environment: environment, runInShell: true);
    var _completer = new Completer<TerminalOutput>();
    var message = "";
    int exitCode = -1;

    process.stdout.transform(utf8.decoder).listen((data) {
      if(data.toLowerCase().contains("username")) {
        process.stdin.write(username);
      } else if(data.toLowerCase().contains("password")) {
        process.stdin.write(password);
      } else {
        message += data;
        TerminalOutput terminalOutput = _build(message, exitCode);
        if(terminalOutput != null) {
          print("success: \n");
          _printOutput(message, exitCode.toString(), command, parameters: parameters);
          _completer.complete(terminalOutput);
        }
      }
    });
    process.stderr.transform(utf8.decoder).listen((data) {
      message += data;
      TerminalOutput terminalOutput = _build(message, exitCode);
      if(terminalOutput != null) {
        print("erro: \n");
        _printOutput(message, exitCode.toString(), command, parameters: parameters);
        _completer.complete(terminalOutput);
      }
    });

    process.exitCode.then((value) {
      exitCode = value;
      TerminalOutput terminalOutput = _build(message, value);
      if(terminalOutput != null) {
        print("exitcode: \n");
        _printOutput(message, value.toString(), command, parameters: parameters);
        _completer.complete(terminalOutput);
      }
    });

    return _completer.future;
  }

  TerminalOutput _build(String message, int exitCode) {
    if(message.isNotEmpty && exitCode >= 0) {
      return TerminalOutput(message, exitCode);
    }

    return null;
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

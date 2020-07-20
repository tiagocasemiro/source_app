import 'dart:convert';
import 'dart:io';

class Terminal {
  final String _git = "git";
  final String _path;

  Terminal(this._path);

  Future<String> _run(String command, {List<String> parameters = const []}) {
    return Process.run(command, parameters, workingDirectory: _path).then((results) {
      return results.stdout.toString();
    });
  }

  Future<String> git(List<String> parameters) {
    return _run(_git, parameters: parameters);
  }

  Future<String> ls() {
    return _run("ls");
  }

  Future<String> pwd() {
    return _run("pwd");
  }
}
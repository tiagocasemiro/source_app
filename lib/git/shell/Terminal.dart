import 'dart:io';

class Terminal {
  final String _git;
  Terminal(_path) : _git = "cd $_path ; git";

  String _fullCommand(String command, {List<String> parameters = const []}) {
    parameters.forEach((parameter) {
      command += " $parameter";
    });

    return "($command)";
  }

  Future<String> _command(String command, {List<String> parameters = const []}) {
    return Process.run("sh", ["-c", _fullCommand(command, parameters: parameters)]).then((results) {
      return results.stdout.toString();
    });
  }

  Future<String> git(List<String> parameters) {
    return _command(_git, parameters: parameters);
  }

  Future<String> ls() {
    return _command("ls");
  }
}
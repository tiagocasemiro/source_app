import 'dart:io';

class Terminal {

  Future<String> command(String command, {List<String> parameters = const []}) {
    return Process.run(command, parameters).then((results) {
      return results.stdout.toString();
    });
  }

  Future<String> git(List<String> parameters) {
    return command("git", parameters: parameters);
  }

  Future<String> ls() {
    return command("ls");
  }
}
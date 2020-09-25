
import 'package:source_app/engine/shell/git/git.dart';

class Repository {
  String name;
  String workDirectory;
  String status;
  String url;
  String credentials;
  String username;
  String password;
  String origin = "origin";

  Repository(this.name, this.workDirectory, {this.url});

  @override
  String toString() {
    return 'Repository{name: $name, workDirectory: $workDirectory}';
  }

  bool hasCredentials() {
    return credentials != null && credentials.isNotEmpty;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Repository &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          workDirectory == other.workDirectory;

  @override
  int get hashCode => name.hashCode ^ workDirectory.hashCode;

  void generateCredentials() {
    if(url != null && url.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
        if(parts[1].contains("@")) {
          List<String> identifier = parts[1].split("@");
          credentials = parts[0].trim() + "//\$" + Git.gitRepoUsername + ":\$" + Git.gitRepoPassword + "@" + identifier.last.split("/")[0].trim();
        } else {
          credentials =  parts[0].trim() + "//\$" + Git.gitRepoUsername + ":\$" + Git.gitRepoPassword + "@" + parts[1].split("/")[0].trim();
        }
      }
    }
  }

  String serviceUrl() {
    if(url != null && url.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
          String host = parts[1].split("/")[0];
          return parts[0].trim() + "//" + host;
      }
    }

    return null;
  }
}

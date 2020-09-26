
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
    if(url != null && url.isNotEmpty && password != null && password.isNotEmpty && username != null && username.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
        if(parts[1].contains("@")) {
          List<String> identifier = parts[1].split("@");
          credentials = parts[0].trim() + "//" + username + ":" + password + "@" + identifier.last.split("/")[0].trim();
        } else {
          credentials =  parts[0].trim() + "//" + username + ":" + password + "@" + parts[1].split("/")[0].trim();
        }
      }
    }
  }

  String urlWithCredentials() {
    if(url != null && url.isNotEmpty && password != null && password.isNotEmpty && username != null && username.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
        if(parts[1].contains("@")) {
          List<String> identifier = parts[1].split("@");
          return parts[0].trim() + "//" + username + ":" + password + "@" + identifier.last.trim();
        } else {
          return  parts[0].trim() + "//" + username + ":" + password + "@" + parts[1].trim();
        }
      }
    }

    return null;
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

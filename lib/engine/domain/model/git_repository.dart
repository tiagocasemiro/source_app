
class Repository {
  String name;
  String workDirectory;
  String status;
  String url = "";
  String credentials = "";
  String username = "";
  String password = "";
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

  String hidePasswordCredentials() {
    if(credentials != null && credentials.isNotEmpty) {
      List<String> parts = credentials.split("//");
      if(parts.length == 2) {
        if(parts[1].contains("@")) {
          List<String> identifier = parts[1].split("@");
          return parts[0].trim() + "//" + identifier[0].split(":")[0] + "@" + identifier[1].trim();
        } else {
          return credentials;
        }
      }
    }

    return "";
  }

  void generateCredentials() {
    if(url != null && url.isNotEmpty && username != null && username.isNotEmpty && password != null && password.isNotEmpty) {
      List<String> parts = url.split("//");
      if(parts.length == 2) {
        if(parts[1].contains("@")) {
          List<String> identifier = parts[1].split("@");
          credentials = parts[0].trim() + "//" + username + ":" + password + "@" + identifier[1].trim();
        } else {
          credentials =  parts[0].trim() + "//" + username + ":" + password + "@" + parts[1].trim();
        }
      }
    }
  }
}

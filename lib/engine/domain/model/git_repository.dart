
class Repository {
  String name;
  String workDirectory;
  String status;
  String url;
  String credentials;

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
}

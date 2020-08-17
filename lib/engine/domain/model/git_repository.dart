
class Repository {
  String name;
  String workDirectory;
  String status;

  Repository(this.name, this.workDirectory);

  @override
  String toString() {
    return 'Repository{name: $name, workDirectory: $workDirectory}';
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
}

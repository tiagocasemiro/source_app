
class Repository {
  String name;
  String workDirectory;
  String status;

  Repository(this.name, this.workDirectory);

  @override
  String toString() {
    return 'Repository{name: $name, workDirectory: $workDirectory}';
  }
}

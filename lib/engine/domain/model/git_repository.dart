
class Repository {
  String name;
  String workDirectory;

  Repository(this.name, this.workDirectory);

  @override
  String toString() {
    return 'Repository{name: $name, workDirectory: $workDirectory}';
  }
}

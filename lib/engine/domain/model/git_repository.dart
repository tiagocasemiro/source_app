
class Repository {
  String name;
  String workDirectory;
  State state;

  Repository(this.name, this.workDirectory, {this.state = State.allCommitted});

  @override
  String toString() {
    return 'Repository{name: $name, workDirectory: $workDirectory, state: $state}';
  }
}

enum State {
  allCommitted,
  toCommit,
  needUpdate
}



class GitBranch {
  String name;
  bool current;

  GitBranch(this.name, {this.current = false});

  @override
  String toString() {
    return 'GitBranch{name: $name, current: $current}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GitBranch &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          current == other.current;

  @override
  int get hashCode => name.hashCode ^ current.hashCode;
}


class GitStash {
  String reference;
  String branchName;
  String name;

  GitStash(this.reference, this.branchName, this.name);

  @override
  String toString() {
    return 'GitStash{reference: $reference, branchName: $branchName, name: $name}';
  }
}
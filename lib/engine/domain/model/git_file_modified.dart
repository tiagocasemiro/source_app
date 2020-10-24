class GitFileModified {
  String commitHash;
  String beforeCommitHash;
  String name;
  TypeFile typeFile;
  StageFile stageFile;

  GitFileModified(this.name, {this.typeFile, this.commitHash, this.stageFile, this.beforeCommitHash});
}

enum TypeFile { add, delete, modification, rename, conflict }
enum StageFile { staged, unstaged, committed }

class GitFileModified {
  String commitHash;
  String name;
  TypeFile typeFile;
  StageFile stageFile;

  GitFileModified(this.name, {this.typeFile, this.commitHash, this.stageFile});
}

enum TypeFile { add, delete, modification, rename, conflict }
enum StageFile { staged, unstaged, committed }

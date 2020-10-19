class GitFileModified {
  String name;
  TypeFile typeFile;

  GitFileModified(this.name, this.typeFile);
}

enum TypeFile { add, delete, modification, rename, conflict }

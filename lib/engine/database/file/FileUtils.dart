import 'dart:io';

class FileUtil {
  String _path;

  FileUtil(this._path);

  Future<bool> addLine(String newLine) async {
    File file = File(_path);
    bool fileExists = await file.exists();
    if(fileExists){
      String contents = await file.readAsString();
      if(contents.trim().isNotEmpty) {
        String newContent = "";
        contents.split("\n").forEach((line) {
          if(line.trim().isNotEmpty) {
            if(newContent.isEmpty) {
              newContent = line.trim();
            } else {
              newContent = newContent + "\n" +  line.trim();
            }
          }
        });
        if(!newContent.contains(newLine)) {
          newContent = newContent + "\n" + newLine;
        }

        return await file.writeAsString(newContent.trim(), mode: FileMode.write) != null;
      }
    }
    return await file.writeAsString(newLine.trim(), mode: FileMode.write) != null;
  }
}
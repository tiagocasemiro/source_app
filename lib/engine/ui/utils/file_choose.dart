import 'dart:io';
import 'package:file_chooser/file_chooser.dart';

Future<String> pickDirectory() async {
  String confirmText = "Select";
  String path = "/";
  if(Platform.isLinux) {
    path = "/home";
  } else if(Platform.isMacOS) {
    path = "/Users";
  } else if(Platform.isWindows) {
    path = "c:\\";
  }
  String initialPath = Directory(path).path;

  final result = await showOpenPanel(
    initialDirectory: initialPath,
    allowsMultipleSelection: false,
    canSelectDirectories: true,
    confirmButtonText: confirmText,
  );
  if (result.canceled || result.paths.isEmpty) {
    return null;
  }

  return result.paths[0];
}
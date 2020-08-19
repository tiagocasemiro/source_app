import 'dart:io';
import 'package:file_chooser/file_chooser.dart';

Future<String> pickImage() async {
  String confirmText = "Select";
  String initialPath = Directory("/home").path;

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
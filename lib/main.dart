import 'package:flutter/material.dart';

import 'git/git.dart';
import 'git/shell/Terminal.dart';

void main() {
  runApp(SourceApp());

  Git().branches().then((branches) => print(branches));
  Git().branch().then((branch) => print(branch));
  Terminal().ls().then((value) => print(value));
}

class SourceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Container(
        color: Colors.white,
      ),
    );
  }
}
